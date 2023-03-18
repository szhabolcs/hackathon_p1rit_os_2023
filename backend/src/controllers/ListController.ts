import { Request, Response } from 'express';

import ListService from '../services/ListService.js';

async function query(req: Request, res: Response) {
    const list: string[] = req.body.list;

    try {
        const _list = await ListService.query(list);

        res.status(ResponseCode.Ok).json(_list);

    } catch (error) {
        console.log(error);
        res.sendStatus(ResponseCode.BadRequest);
    }
}

export default {
    query
}