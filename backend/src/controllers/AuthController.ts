import { Request, Response } from 'express';

import AuthService from "../services/AuthService.js";

function register(req: Request, res: Response) {
    const { name, email, password } = req.body;
    
    try {
        AuthService.register({ name, email, password });
        
        res.sendStatus(ResponseCode.Ok);
        
    } catch (error) {
        console.log(error);
        res.sendStatus(ResponseCode.BadRequest);
    }
}

function login(req: Request, res: Response) {
    const { email, password } = req.body;
    
    try {
        const token = AuthService.login({ email, password });
        
        res.cookie("token", token,{
            secure: process.env.NODE_ENV !== "dev",
            httpOnly: true,
            maxAge: 3600000
        });

        res.status(ResponseCode.Ok);
    
    } catch (error) {
        console.log(error);
        res.sendStatus(ResponseCode.Forbidden);
    }

}

export default {
    register,
    login
}