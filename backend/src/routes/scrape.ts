import express from "express";
import cors from "cors";

import { carrefour, kaufland, lidl } from "../controllers/ScrapeController.js";

export const scrape = express.Router();
scrape.use(
  cors({
    origin: process.env.CLIENT_DOMAIN,
    methods: "GET,POST",
    preflightContinue: true,
    optionsSuccessStatus: 204,
    credentials: true,
  })
);

scrape.post("/carrefour", carrefour);
scrape.post("/kaufland", kaufland);
scrape.post("/lidl", lidl);
