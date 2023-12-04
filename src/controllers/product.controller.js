import { Product } from "../models/product.js"
import { ProductSubCategory } from "../models/productSubCategory.js"


const findAll = async (req, res) => {
    try {
        const producto = await Product.findAll({
            include: ProductSubCategory
        })

        res.json({
            msg: 'Funcionando findall',
            producto
        })
    } catch (error) {
        console.log(error)
        res.status(500).json({
            msg: 'contacte al administrador'
        })
    }
}

const findFiler = async (req, res) => {
    const { ProductSubCategoryId, nombreSub, ...datos } = req.body
    const keys = Object.keys(datos)//muestra el nombre que le indicamos por variable
    const values = Object.values(datos)//Muestra el dato que posee en la base de datos
    const criteriosProduct = {}
    const criteriosSubCategory = {}
    for (let i = 0; i < values.length; i++) {
        if (values[i] !== null && values[i] !== undefined && values[i] !== '') {
            criteriosProduct[keys[i]] = values[i]
        }
    }
    if (ProductSubCategoryId !== null && ProductSubCategoryId !== undefined && ProductSubCategoryId !== '') {
        criteriosSubCategory['productsubcategoryid'] = ProductSubCategoryId
    }
    if (nombreSub !== null && nombreSub !== undefined && nombreSub !== '') {
        criteriosSubCategory['name'] = nombreSub
    }
    try {
        const productoFiltrado = await Product.findAll({
            include: [{
                model: ProductSubCategory,
                where: criteriosSubCategory
            }],
            where: criteriosProduct
        })
        res.json({
            msg: 'funcionando findfilter',
            productoFiltrado
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({
            msg: 'contacte al administrador'
        })
    }
}

export {
    findAll,
    findFiler
}