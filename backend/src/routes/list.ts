import express from 'express';
import cors from 'cors';

import ListController from '../controllers/ListController.js';

export const list = express.Router();
list.use(cors({
    "origin": process.env.CLIENT_DOMAIN,
    "methods": "GET,POST",
    "preflightContinue": true,
    "optionsSuccessStatus": 204,
    "credentials": true
}));


list.post("/query", ListController.query);
list.post("/save", ListController.save);
list.get("/:id", ListController.retrieve);
list.get("/:id/meta", ListController.retrieveMeta);