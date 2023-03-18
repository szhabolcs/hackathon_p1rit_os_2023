import { Request, Response } from 'express';

import AuthService from "../services/AuthService.js";

async function register(req: Request, res: Response) {
    const { name, email, password } = req.body;
    
    try {
        const tokens = await AuthService.register({ name, email, password });
        
        res.status(ResponseCode.Ok).json(tokens);
        
    } catch (error) {
        console.log(error);
        res.sendStatus(ResponseCode.BadRequest);
    }
}

async function login(req: Request, res: Response) {
    const { email, password } = req.body;

    console.log(req.body);
    
    try {
        const tokens = await AuthService.login({ email, password });
        
        res.status(ResponseCode.Ok).json(tokens);
    
    } catch (error) {
        console.log(error);
        res.sendStatus(ResponseCode.Forbidden);
    }

}

async function refresh(req: Request, res: Response) {
    const authHeader = req.headers['authorization'];
    const refreshtoken = authHeader && authHeader.split(' ')[1];

    if (typeof refreshtoken === "undefined"){
        res.sendStatus(ResponseCode.BadRequest);
        return;
    }
    
    try {
        const newTokens = await AuthService.refresh(req.user, refreshtoken);
        res.status(ResponseCode.Ok).json(newTokens);
    
    } catch (error) {
        console.log(error);
        res.sendStatus(ResponseCode.Forbidden);
    }
}

export default {
    register,
    login,
    refresh
}