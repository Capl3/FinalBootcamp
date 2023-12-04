import { DataTypes } from "sequelize";
import { sequelize } from "../database/database.js";

const ProductSubCategory = sequelize.define('ProductSubCategory', {
    productsubcategoryid: {
        type: DataTypes.INTEGER,
        primaryKey: true,
    },
    productcategoryid: {
        type: DataTypes.INTEGER,
    },
    name: {
        type: DataTypes.STRING(50)
    }
}, {
    tableName:'productsubcategory',
    createdAt: false,
    updatedAt: false

})

/* const productoSubCategoria = await ProducSubCategory.findAll()
console.log(productoSubCategoria) */

export{
    ProductSubCategory
}