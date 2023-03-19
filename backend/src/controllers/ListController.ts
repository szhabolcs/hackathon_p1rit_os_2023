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

  // console.log(JSON.stringify(products));
  // console.log(JSON.stringify(query));
  // console.log(JSON.stringify(sum));
  // console.log(JSON.stringify(storeName));
  try {
    const _save = await ListService.save(
      tokenUser,
      products,
      query,
      sum,
      storeName
    );

    res.status(ResponseCode.Ok).json(products);
  } catch (error) {
    console.log(error);
    res.sendStatus(ResponseCode.BadRequest);
  }
}

export default {
  query,
  save,
};
