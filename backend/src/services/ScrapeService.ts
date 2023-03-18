import puppeteer from "puppeteer";
import { PrismaClient } from "@prisma/client";
import env from "dotenv";
import process from "process";
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

  const three = await page.evaluate(() => {
    return 3;
  });

  console.log(three);
}
export default { carrefour, kaufland, lidl };
