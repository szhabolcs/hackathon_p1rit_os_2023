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
async function carrefour() {
  // Launch browser instance - defualt launch is without caching
  const browser = await puppeteer.launch({
    executablePath: process.env.PUPPETEER_BROWSER_PATH,
  });

  // Creating new page for puppeteer
  const page = await browser.newPage();

  // Go to website
  const website: string = "https://www.bringo.ro/ro/";

  // Automating location form data input
  await page.goto(website);
  await page.type("#address", "Strada Narciselor 8, Târgu Mureș, Romani");

  // todo: click on the first result
  const firstLocationSelector = "";
  await page.waitForSelector(firstLocationSelector);
  await page.click(firstLocationSelector);

  // Completing street number
  await page.type("#street_number", "13");

  // Show markets
  await page.click("#view_stores");

  // Click on specific market

  // Fetch the categories from the market
  const containerDiv = await page.waitForSelector(
    "div > .col-lg-3.col-xl-3.col-md-4.col-6.box"
  );

  let containerItems = await page.evaluate(
    (el) => el?.textContent,
    containerDiv
  );
  // Print the results
  console.log("page content: ", containerItems);

  // Fetch elements from each category

  // Put the data into the database

  // Close browser
  await browser.close();
}

export default { carrefour };
