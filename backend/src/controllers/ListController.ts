import { Request, Response } from "express";

import ListService from "../services/ListService.js";

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

async function save(req: Request, res: Response) {
  const products: string[] = req.body.products;
  const query: string = req.body.query;
  const sum: number = req.body.price;
  const storeName: string = req.body.store;
  const tokenUser = req.user.id;

  try {
    await ListService.save(
      tokenUser,
      products,
      query,
      sum,
      storeName
    );

    res.sendStatus(ResponseCode.Ok);
  } catch (error) {
    console.log(error);
    res.sendStatus(ResponseCode.BadRequest);
  }
}

async function retrieveMeta(req: Request, res: Response) {
  const id = Number.parseInt(req.params.id);

  try {
    const list = await ListService.retrieveMeta(id);

    res.status(ResponseCode.Ok).json(list);
  } catch (error) {
    console.log(error);
    res.sendStatus(ResponseCode.BadRequest);
  }
}

async function retrieve(req: Request, res: Response) {
  const id = Number.parseInt(req.params.id);

  try {
    const list = await ListService.retrieve(id);
    const ret = list.map(el => el.product);
    res.status(ResponseCode.Ok).json(ret);
  } catch (error) {
    console.log(error);
    res.sendStatus(ResponseCode.BadRequest);
  }
}

async function retrieveAllMeta(req: Request, res: Response) {
  const id = req.user.id;
  
  try {
    const list = await ListService.retrieveAllMeta(id);
    res.status(ResponseCode.Ok).json(list);
  } catch (error) {
    console.log(error);
    res.sendStatus(ResponseCode.BadRequest);
  }
}

export default {
  query,
  save,
  retrieveMeta,
  retrieve,
  retrieveAllMeta
};
