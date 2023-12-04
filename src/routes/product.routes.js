import { Router } from "express";
import { findAll, findFiler } from "../controllers/product.controller.js";

const routerProduct = Router()

routerProduct.get('/', findAll)
routerProduct.get('/filter', findFiler)

export{
    routerProduct
}