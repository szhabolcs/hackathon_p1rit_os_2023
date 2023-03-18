import { Request, Response } from 'express';

import ListService from '../services/ListService.js';

async function query(req: Request, res: Response) {
    const { name, email, password } = req.body;
    
    try {
        const lists = ListService.query(["alma", "korte"]);
        
        res.status(ResponseCode.Ok).json(lists);
        
    } catch (error) {
        console.log(error);
        res.sendStatus(ResponseCode.BadRequest);
    }
}

export default {
    query
}