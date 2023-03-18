import { NextFunction, Request, Response } from 'express';
import AuthService from "../services/AuthService.js"
import jwt from 'jsonwebtoken';

export function authorizeJWT(req: Request, res: Response, next: NextFunction) {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (typeof token !== "undefined") {
        jwt.verify(token, process.env.JWT_SECRET, (err: any, data: any) => {
            if (err) {
                res.sendStatus(ResponseCode.Forbidden);
            }
            else if (
                AuthService.tokenCache.has(token) === false
                && AuthService.refreshTokenCache.has(token) === false) {
                res.sendStatus(ResponseCode.Forbidden);
            }
            else if (typeof data === 'undefined' || typeof data === 'string') {
                res.sendStatus(ResponseCode.Forbidden);
            }
            else {
                req.user = data.user;
                next();
            }
        });
    } else{
        res.sendStatus(ResponseCode.Forbidden);
    }
}