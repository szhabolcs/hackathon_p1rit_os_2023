import { Request, Response } from "express";
import ScrapeService from "../services/ScrapeService.js";

function carrefour(req: Request, res: Response) {
  try {
    ScrapeService.carrefour();
    res.sendStatus(ResponseCode.Ok);
  } catch (error) {
    console.log(error);
    res.sendStatus(ResponseCode.BadRequest);
  }
}

export { carrefour };
