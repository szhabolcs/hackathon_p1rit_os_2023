import express from 'express';
import cors from 'cors';

import AuthController from '../controllers/AuthController.js';
import { authorizeJWT } from '../middleware/jwt-authorize.js';

export const auth = express.Router();
auth.use(cors({
    "origin": process.env.CLIENT_DOMAIN,
    "methods": "GET,POST",
    "preflightContinue": true,
    "optionsSuccessStatus": 204,
    "credentials": true
}));


auth.post("/register", AuthController.register);
auth.post("/login", AuthController.login);
auth.post("/refresh", authorizeJWT, AuthController.refresh);