import express from "express";
import cors from "cors";
import env from "dotenv";
import "express-async-errors";

import { auth } from "./routes/auth.js";

env.config({ path: ".env" });

const app = express();
app.use(cors({
    "methods": "GET,POST",
    "preflightContinue": true,
    "optionsSuccessStatus": 204
}));

app.use("/auth", auth);

app.get("/", (_, res) => {
    res.json("");
});

app.listen(process.env.API_PORT, () => {
    console.log(`API listening at ${process.env.API_PROTOCOL}://${process.env.API_DOMAIN}:${process.env.API_PORT}`);
});