import puppeteer from "puppeteer";
import { PrismaClient } from "@prisma/client";
import env from "dotenv";
import process from "process";
const prisma = new PrismaClient();
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

async function kaufland() {}

async function lidl() {
  // Launch browser
  const browser = await puppeteer.launch({
    executablePath: process.env.PUPPETEER_BROWSER_PATH,
  });

  // Open page
  const page = await browser.newPage();

  await page.goto(
    "https://www.lidl.ro/c/ofertele-saptamanale-lidl-plus/c5201/w1"
  );

  await page.click(".cookie-alert-extended-button");

  const products: Product[] = await page.evaluate(() => {
    const products = document.querySelectorAll(".ret-o-card");

    return Array.from(products).map((product) => {
      const nameElement = product.querySelector("h3.ret-o-card__headline");
      const priceElement = product.querySelector(
        ".lidl-m-pricebox__discount-price"
      );
      const discountElement = product.querySelector(".lidl-m-pricebox__price");
      //   const discountPercantage = product.querySelector(
      //     ".lidl-m-pricebox__highlight"
      //   );
      const quantityElement = product.querySelector(
        ".lidl-m-pricebox__basic-quantity"
      );
      const image = product
        // .querySelector(".nuc-m-picture__image")
        .querySelector(".nuc-a-source")
        ?.getAttribute("srcset"); // optional chaining here

      const name = nameElement?.textContent?.trim();
      const price = priceElement?.textContent?.trim();
      const discountedPrice = discountElement?.textContent?.trim();
      const unitOfMeasure = quantityElement?.textContent?.trim();
      const storeName = "Lidl";

      console.log({
        name,
        price,
        discountedPrice,
        unitOfMeasure,
        image,
      });

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

  //   console.log(products);
  const createMany = await prisma.product.createMany({
    data: products,
    skipDuplicates: true,
  });
}
export default { carrefour, kaufland, lidl };
