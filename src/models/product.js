import { DataTypes } from "sequelize";
import { sequelize } from "../database/database.js";
import { ProductSubCategory } from "./productSubCategory.js";

const Product = sequelize.define('Product', {
    productid: {
        type: DataTypes.INTEGER,
        primaryKey: true
    },
    name: {
        type: DataTypes.STRING(50)
    },
    productnumber: {
        type: DataTypes.STRING(50)
    },
    color: {
        type: DataTypes.STRING(15)
    },
    safetystocklevel: {
        type: DataTypes.INTEGER
    },
    reorderpoint: {
        type: DataTypes.INTEGER
    },
    standardcost: {
        type: DataTypes.INTEGER
    },
    listprice: {
        type: DataTypes.INTEGER
    },
    size: {
        type: DataTypes.STRING(5)
    },
    sizeunitmeasurecode: {
        type: DataTypes.STRING(3)
    },
    weight: {
        type: DataTypes.INTEGER
    },
    daystomanufacture: {
        type: DataTypes.INTEGER
    },
    productsubcategoryid: {
        type: DataTypes.INTEGER
    }
}, {
    tableName: 'product',
    updatedAt: false,
    createdAt: false
})
Product.belongsTo(ProductSubCategory, {
    foreignKey: 'productsubcategoryid',
    sourceKey: 'productsubcategoryid',
});

ProductSubCategory.hasMany(Product, {
    foreignKey: 'productsubcategoryid',
    targetKey: 'productsubcategoryid'
});


/* const product = await Product.findAll({
    include:ProductSubCategory
})
console.log(product)
 */
export {
    Product
}