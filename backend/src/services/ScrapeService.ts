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
  
}

async function kaufland() {
  
}

async function lidl() {
  
}
export default { carrefour, kaufland, lidl };
