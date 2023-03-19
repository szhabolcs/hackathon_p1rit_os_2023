import puppeteer from "puppeteer";
import { PrismaClient } from "@prisma/client";
import process from "process";
import { list } from "../routes/list.js";
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
async function carrefour() {}

async function kaufland() {
  const page = await browser.newPage();
  await page.goto(
    "https://www.kaufland.ro/oferte/oferte-saptamanale/saptamana-curenta.category=01_Carne__mezeluri.html"
  );

  // sometimes buggy
  await page.waitForSelector(".cookie-alert-extended-button");
  await page.click(".cookie-alert-extended-button").catch();

  try {
    const links = await page.evaluate(() => {
      const sidemenu = document.querySelector(
        "body > div.body__wrapper > main > div.content__separator > div > div > div.g-row.g-layout-overview > div.g-col.g-col-1"
      );
      const links = sidemenu?.querySelectorAll(".m-accordion__link");
      return Array.from(links ?? []).map((link) => {
        // Get link
        const page = link.getAttribute("href");
        const baseUri = "https://www.kaufland.ro" + page;
        return baseUri;
      });
    });

    await page.close();

    links.forEach(async (link) => {
      try {
        await doOneKategory(link);
        await new Promise((r) => setTimeout(r, 2000));
      } catch (error) {
        console.log(error);
      }
    });
  } catch (error) {
    console.log(error);
  }
}

async function doOneKategory(link: string) {
  const page = await browser.newPage();
  await page.goto(link);

  const products = await page.evaluate(() => {
    const products = document.querySelectorAll(".m-offer-tile");
    return Array.from(products).map((product) => {
      //
      const nameElement = product.querySelector(".m-offer-tile__title");
      const brandElement = product.querySelector(".m-offer-tile__subtitle");

      const discountElement = product.querySelector(".a-pricetag__price");
      const priceElement = product.querySelector(".a-pricetag__old-price");
      const quantityElement = product.querySelector(".m-offer-tile__quantity");
      const image =
        product
          .querySelector(".a-image-responsive")
          ?.getAttribute("data-src") ?? "";

      const name = `${
        brandElement?.textContent ?? "".replace("&amp;", "&").trim() ?? ""
      } ${nameElement?.textContent?.trim() ?? ""}`.trim();

      let price = Number.parseFloat(
        priceElement?.textContent?.trim().replace(",", ".") ?? ""
      );
      let discountedPrice = Number.parseFloat(
        discountElement?.textContent?.trim().replace(",", ".") ?? ""
      );
      const unitOfMeasure = quantityElement?.textContent?.trim() ?? "";
      const storeName = "Kaufland";

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

  console.log(products);

  await page.close();

  await prisma.product.createMany({
    data: products as Product[],
    skipDuplicates: true,
  });
}

async function lidl() {
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
      const priceElement = product.querySelector(
        ".lidl-m-pricebox__discount-price"
      );
      const discountElement = product.querySelector(".lidl-m-pricebox__price");

      const quantityElement = product.querySelector(
        ".lidl-m-pricebox__basic-quantity"
      );
      const image = product
        .querySelector(".nuc-a-source")
        ?.getAttribute("srcset")
        ?.split(" ")[0]; // optional chaining here

      const name = nameElement?.textContent?.trim();
      let price = Number.parseFloat(
        priceElement?.textContent?.trim().replace(",", ".") ?? ""
      );
      let discountedPrice = Number.parseFloat(
        discountElement?.textContent?.trim().replace(",", ".") ?? ""
      );
      const unitOfMeasure = quantityElement?.textContent?.trim() ?? "";
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

async function auchan() {
  // Open page
  const page = await browser.newPage();
  await page.goto("https://auchan.ro");

  await page.click("#onetrust-accept-btn-handler");
  // document.querySelectorAll("a.theme__item").forEach((link) => console.log("https://lidl.ro" + link.getAttribute("href")))

  try {
    // doOneCategory(page, "");
    const links = await page.evaluate(() => {
      const links = document.querySelectorAll(
        "a.vtex-slider-layout-0-x-infoCardCallActionContainer.vtex-slider-layout-0-x-infoCardCallActionContainer--popularCategories.vtex-slider-layout-0-x-infoCardCallActionContainer--normalArrows.mt6.mb6"
      );
      return Array.from(links).map((link) => {
        // Get link
        const page = link.getAttribute("href");
        const baseUri = "" + page;
        return baseUri;
      });
    });

    console.log(links);
    console.log("I'm scraping");

    // await page for selector

    links.forEach(async (link) => {
      try {
        await doOneAuchanCategory(link);
      } catch (error) {
        console.log(error);
      }
    });
  } catch (error) {
    console.log(error);
  }
}

async function doOneAuchanCategory(link: string) {
  const page = await browser.newPage();
  await page
    .goto(link, {
      waitUntil: "domcontentloaded",
    })
    .catch((err) => console.log("error loading url", err));
  // console.timeEnd("goto");

  const products = await page.evaluate(() => {
    const products = document.querySelectorAll(
      ".vtex-search-result-3-x-galleryItem.vtex-search-result-3-x-galleryItem--normal.pa4 "
    );

    return Array.from(products).map((product) => {
      const nameElement = product.querySelector(
        "span.vtex-product-summary-2-x-productBrand.vtex-product-summary-2-x-productBrand--defaultShelf.vtex-product-summary-2-x-brandName.vtex-product-summary-2-x-brandName--defaultShelf.t-body"
      );

      const sellingPriceElementInteger =
        (document.querySelector(
          ".vtex-product-price-1-x-sellingPriceWithUnitMultiplier--shelfPrice .vtex-product-price-1-x-currencyInteger"
        ) as HTMLElement) ?? "";
      const listPriceElementInteger =
        (document.querySelector(
          ".vtex-product-price-1-x-listPriceWithUnitMultiplier--shelfPrice .vtex-product-price-1-x-currencyInteger"
        ) as HTMLElement) ?? "";

      const sellingPriceElementFraction =
        (document.querySelector(
          ".vtex-product-price-1-x-currencyFraction.vtex-product-price-1-x-currencyFraction--shelfPrice"
        ) as HTMLElement) ?? "";
      const listPriceElementFraction =
        (document.querySelector(
          ".vtex-product-price-1-x-currencyFraction.vtex-product-price-1-x-currencyFraction--shelfPrice"
        ) as HTMLElement) ?? "";

      let sellingPrice = 0;
      let listPrice = 0;
      if (
        sellingPriceElementInteger === null ||
        sellingPriceElementInteger === null
      ) {
        sellingPrice = 0;
        listPrice = 0;
      } else {
        sellingPrice = parseFloat(
          `${sellingPriceElementInteger.innerText}.${sellingPriceElementFraction.innerText}`
        );
        listPrice = parseFloat(
          `${listPriceElementInteger.innerText}.${listPriceElementFraction.innerText}`
        );
      }

      const image = product
        .querySelector(
          "img.vtex-product-summary-2-x-imageNormal.vtex-product-summary-2-x-image.vtex-product-summary-2-x-image--defaultShelf"
        )
        ?.getAttribute("src")
        ?.split(" ")[0]; // optional chaining here

      const name = nameElement?.textContent?.trim();
      let price = listPrice;
      let discountedPrice = sellingPrice;
      const unitOfMeasure = "";
      const storeName = "Auchan";

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

  // console.log(products);
  await prisma.product.createMany({
    data: products as Product[],
    skipDuplicates: true,
  });
}

export default { auchan, carrefour, kaufland, lidl };
