import puppeteer from "puppeteer";
import { PrismaClient } from "@prisma/client";
import env from "dotenv";
import process from "process";
const prisma = new PrismaClient();
const browser = await puppeteer.launch({
  executablePath: process.env.PUPPETEER_BROWSER_PATH,
});

// Todo:
/***
 - scrape carrefour website
    - disable cache
    - save location cache
    - each category
    - mass, quantity, price, discounted price, name ...
 - show data on console
 - send data to database
 **/
async function carrefour() { }

async function kaufland() {
  const page = await browser.newPage();
  // await page.goto("https://kaufland.ro");
  await page.goto(
    "https://www.kaufland.ro/oferte/oferte-saptamanale/saptamana-curenta.html"
  );

  await page.click(".cookie-alert-extended-button");

  const products = await page.evaluate(() => {
    const products = document.querySelectorAll(".o-slider-to-grid__tile");
    return Array.from(products).map((product) => {
      //
      const nameElement = product.querySelector(".m-offer-tile__title");
      const prodElement = product.querySelector(".m-offer-tile__subtitle");

      const discountElement = product.querySelector(".a-pricetag__price");
      const priceElement = product.querySelector(".a-pricetag__old-price");
      const quantityElement = product.querySelector(".m-offer-tile__quantity");
      const image = product
        .querySelector(".a-image-responsive")
        ?.getAttribute("srcset");

      const name = prodElement?.textContent
        ?.trim()
        .concat(nameElement?.textContent?.trim() ?? "");

      let price = Number.parseFloat(
        priceElement?.textContent?.trim().replace(",", ".") ?? ""
      );
      let discountedPrice: number | null = Number.parseFloat(
        discountElement?.textContent?.trim().replace(",", ".") ?? ""
      );
      const unitOfMeasure = quantityElement?.textContent?.trim();
      const storeName = "Kaufland";

      // database bug - price cannot be null
      // if (price === null && discountedPrice !== null) {
      //   price = discountedPrice;
      // }

      return {
        name,
        price,
        discountedPrice,
        unitOfMeasure,
        image,
        storeName,
      };
    });
  });

  // products.forEach((product) => console.log(product));
  console.log(products);

  try {
  } catch (error) {
    console.log(error);
  }
}

async function lidl() {
  // Launch browser

  // Open page
  const page = await browser.newPage();
  await page.goto("https://lidl.ro");

  await page.click(".cookie-alert-extended-button");
  // document.querySelectorAll("a.theme__item").forEach((link) => console.log("https://lidl.ro" + link.getAttribute("href")))

  try {
    // doOneCategory(page, "");
    const links = await page.evaluate(() => {
      const links = document.querySelectorAll("a.theme__item");
      return Array.from(links).map((link) => {
        // Get link
        const page = link.getAttribute("href");
        const baseUri = "https://lidl.ro" + page;
        return baseUri;
      });
    });

    links.forEach(async (link) => {
      try {
        await doOneCategory(link);
      } catch (error) {
        console.log(error);
      }
    });

    console.log(links);
  } catch (error) {
    console.log(error);
  }
}

async function doOneCategory(link: string) {
  const page = await browser.newPage();
  await page.goto(link);

  const products = await page.evaluate(() => {
    const products = document.querySelectorAll(".ret-o-card");

    return Array.from(products).map((product) => {
      const nameElement = product.querySelector("h3.ret-o-card__headline");
      const priceElement = product.querySelector(".lidl-m-pricebox__discount-price");
      const discountElement = product.querySelector(".lidl-m-pricebox__price");

      const quantityElement = product.querySelector(".lidl-m-pricebox__basic-quantity");
      const image = product.querySelector(".nuc-a-source")?.getAttribute("srcset")?.split(" ")[0]; // optional chaining here

      const name = nameElement?.textContent?.trim();
      let price = Number.parseFloat(
        priceElement?.textContent?.trim().replace(",", ".") ?? ""
      );
      let discountedPrice = Number.parseFloat(
        discountElement?.textContent?.trim().replace(",", ".") ?? ""
      );
      const unitOfMeasure = quantityElement?.textContent?.trim();
      const storeName = "Lidl";

      if (isNaN(price) && discountedPrice !== null) {
        price = discountedPrice;
        // @ts-ignore
        discountedPrice = null;
      }

      return {
        name,
        price,
        discountedPrice,
        unitOfMeasure,
        image,
        storeName,
      };
    });
  });

  await prisma.product.createMany({
    data: products as Product[],
    skipDuplicates: true,
  });
}

export default { carrefour, kaufland, lidl };
