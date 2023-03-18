import { Request, Response } from "express";
import ScrapeService from "../services/ScrapeService.js";

async function carrefour(req: Request, res: Response) {
  try {
    await ScrapeService.carrefour();
    res.sendStatus(ResponseCode.Ok);
  } catch (error) {
    console.log(error);
    res.sendStatus(ResponseCode.BadRequest);
  }
}

async function kaufland(req: Request, res: Response) {
  try {
    await ScrapeService.kaufland();
    res.sendStatus(ResponseCode.Ok);
  } catch (error) {
    console.log(error);
    res.sendStatus(ResponseCode.BadRequest);
  }
}

async function lidl(req: Request, res: Response) {
  try {
    await ScrapeService.lidl();
    res.sendStatus(ResponseCode.Ok);
  } catch (error) {
    console.log(error);
    res.sendStatus(ResponseCode.BadRequest);
  }
}

export { carrefour, kaufland, lidl };
