import { NextFunction, Request, Response } from 'express';
import { tokenCache } from "../services/AuthService.js"
import jwt from 'jsonwebtoken';

export function authorizeJWT(req: Request, res: Response, next: NextFunction) {
    const { token } = req.cookies;

    if (typeof token !== "undefined") {
        jwt.verify(token, process.env.JWT_SECRET, (err: any, data: any) => {
            if (err) {
                // throw new APIError(ResponseCode.Forbidden, ErrorCode.JWTExpired);
            }
            else if (tokenCache.has(token) === false) {
                // throw new APIError(ResponseCode.Forbidden, ErrorCode.JWTExpired);
            }
            else if (typeof data === 'undefined' || typeof data === 'string') {
                // throw new APIError(ResponseCode.Forbidden, ErrorCode.JWTExpired);
            }
            else {
                // req.user = data.user;
                next();
            }
        });
    } else{
        // throw new APIError(ResponseCode.Forbidden, ErrorCode.JWTExpired);
    }
}