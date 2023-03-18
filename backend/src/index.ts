import express from "express";
import cors from "cors";
import env from "dotenv";
import "express-async-errors";

import { auth } from "./routes/auth.js";
import { scrape } from "./routes/scrape.js";
import { authorizeJWT } from "./middleware/jwt-authorize.js";
import { list } from "./routes/list.js";

env.config({ path: ".env" });

const app = express();
app.use(
  cors({
    methods: "GET,POST",
    preflightContinue: true,
    optionsSuccessStatus: 204,
  })
);

app.use(express.json());

app.use("/auth", auth);
app.use("/scrape", scrape);
app.use("/list", list);

app.get("/", (_, res) => {
  res.json("");
});

app.get("/jwt-test", authorizeJWT, (req, res) => res.json("OK!"));

app.listen(process.env.API_PORT, () => {
  console.log(
    `API listening at ${process.env.API_PROTOCOL}://${process.env.API_DOMAIN}:${process.env.API_PORT}`
  );
});
