-----------------------------------------------------------------------------------------------
--Consulta 1
SELECT
    p.productid,
    p.name,
    p.productnumber,
    p.productsubcategoryid
FROM
    product p
INNER JOIN
    productSubcategory ps ON p.productsubcategoryid = ps.productsubcategoryid;
	
-------------------------------------------------------------------------------------------------

--Consulta 2
SELECT
    EXTRACT(YEAR FROM orderdate) AS año,
    COUNT(*) AS cantidad_ordenes
FROM
   salesorderheader
GROUP BY
    año
	
-------------------------------------------------------------------------------------------------	

--Consulta 3
SELECT
    sh.salesorderid,
    sh.orderdate,
    sh.duedate,
    sh.shipdate,
    cc.cardtype,
    cc.cardnumber
FROM
    salesorderheader sh
JOIN
    creditcard cc ON sh.creditcardid = cc.creditcardid
WHERE
    cc.cardtype = 'Vista'
	
-------------------------------------------------------------------------------------------------	


SELECT
    p.productid,
    p.name,
    p.productnumber,
    p.color,
    COALESCE(ps.name, 'N/A') AS "subcategory name"
FROM
    product p
LEFT JOIN
    productsubcategory ps ON p.productsubcategoryid = ps.productsubcategoryid;
	
	