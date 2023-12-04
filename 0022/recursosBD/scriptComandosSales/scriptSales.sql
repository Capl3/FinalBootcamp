CREATE TABLE store(
	businessentityid INTEGER, 
	name VARCHAR(50), 
	salespersonid INTEGER,
	CONSTRAINT pk_store PRIMARY KEY (businessentityid)
);

CREATE TABLE salesterritory(
	territoryid INTEGER, 
	name VARCHAR(50), 
	countryregioncode VARCHAR(3), 
	"group" VARCHAR(50), 
	salesytd NUMERIC, 
	saleslastyear NUMERIC, 
	costytd NUMERIC, 
	costlastyear NUMERIC,
	CONSTRAINT pk_salesterritory PRIMARY KEY (territoryid)
);

CREATE TABLE person(
	businessentityid INTEGER,
	persontype CHAR(2),
	namestyle INTEGER,
	title VARCHAR(8),
	firstname VARCHAR(50),
	middlename VARCHAR(50),
	lastname VARCHAR(50),
	suffix VARCHAR(10),
	emailpromotion INTEGER,
	CONSTRAINT pk_person PRIMARY KEY (businessentityid)
);

CREATE TABLE customer(
	customerid INTEGER,
	personid INTEGER,
	storeid INTEGER,
	territoryid INTEGER,
	CONSTRAINT pk_customer PRIMARY KEY (customerid),
	CONSTRAINT fk_cursomer_person FOREIGN KEY (personid) REFERENCES person(businessentityid),
	CONSTRAINT fk_cursomer_store FOREIGN KEY (storeid) REFERENCES store(businessentityid),
	CONSTRAINT fk_cursomer_territory FOREIGN KEY (territoryid) REFERENCES salesterritory(territoryid)
);

CREATE TABLE productcategory(
	productcategoryid INTEGER,
	name VARCHAR(50),
	CONSTRAINT pk_productcategory PRIMARY KEY (productcategoryid)
);

CREATE TABLE productsubcategory(
	productsubcategoryid INTEGER,
	productcategoryid INTEGER,
	name VARCHAR(50),
	CONSTRAINT pk_productsubcategory PRIMARY KEY (productsubcategoryid),
	CONSTRAINT fk_productsubcategory_productcategory FOREIGN KEY (productcategoryid) REFERENCES productcategory(productcategoryid)
);

CREATE TABLE product(
	productid INTEGER,
	name VARCHAR(50),
	productnumber VARCHAR(25),
	color VARCHAR(15),
	safetystocklevel SMALLINT,
	reorderpoint SMALLINT,
	standardcost NUMERIC,
	listprice NUMERIC,
	size VARCHAR(5),
	sizeunitmeasurecode CHAR(3),
	weight NUMERIC(8,2),
	daystomanufacture INTEGER,
	productsubcategoryid INTEGER,
	CONSTRAINT pk_product PRIMARY KEY (productid),
	CONSTRAINT fk_product_productsubcategory FOREIGN KEY (productsubcategoryid) REFERENCES productsubcategory(productsubcategoryid)	
);

CREATE TABLE creditcard(
	creditcardid INTEGER,
	cardtype VARCHAR(50),
	cardnumber VARCHAR(25),
	expmonth SMALLINT,
	expyear SMALLINT,
	CONSTRAINT pk_creditcard PRIMARY KEY (creditcardid)
);

CREATE TABLE personcreditcard(
	personcreditcardid INTEGER GENERATED ALWAYS AS IDENTITY,
	businessentityid INTEGER,
	creditcardid INTEGER,
	CONSTRAINT pk_personcreditcard PRIMARY KEY (personcreditcardid),
	CONSTRAINT fk_personcreditcard_person FOREIGN KEY (businessentityid) REFERENCES person(businessentityid),
	CONSTRAINT fk_personcreditcard_creditcard FOREIGN KEY (creditcardid) REFERENCES creditcard(creditcardid)
);

CREATE TABLE address(
	addressid INTEGER,
	addressline1 VARCHAR(60),
	addressline2 VARCHAR(60),
	city VARCHAR(30),
	postalcode VARCHAR(15),
	CONSTRAINT pk_address PRIMARY KEY (addressid)
);

CREATE TABLE salesorderheader(
	salesorderid INTEGER,
	revisionnumber SMALLINT,
	orderdate TIMESTAMP WITHOUT TIME ZONE,
	duedate TIMESTAMP WITHOUT TIME ZONE,
	shipdate TIMESTAMP WITHOUT TIME ZONE,
	status SMALLINT,
	onlineorderflag BOOLEAN,
	purchaseordernumber VARCHAR(25),
	accountnumber VARCHAR(15),
	customerid INTEGER,
	territoryid INTEGER,
	shiptoaddressid INTEGER,
	creditcardid INTEGER,
	subtotal NUMERIC,
	taxamt NUMERIC,
	freight NUMERIC,
	totaldue NUMERIC,
	"comment" VARCHAR(128),
	CONSTRAINT pk_salesorderheader PRIMARY KEY (salesorderid),
	CONSTRAINT fk_salesorderheader_salesterritory FOREIGN KEY (territoryid) REFERENCES salesterritory(territoryid),
	CONSTRAINT fk_salesorderheader_adderss FOREIGN KEY (shiptoaddressid) REFERENCES address(addressid),
	CONSTRAINT fk_salesorderheader_creditcard FOREIGN KEY (creditcardid) REFERENCES creditcard(creditcardid)
);

CREATE TABLE salesorderdetails(
	salesorderdetailid INTEGER,
	salesorderid INTEGER,
	productid INTEGER,
	carriertrackingnumber VARCHAR(25),
	orderqty SMALLINT,
	specialofferid INTEGER,
	unitprice NUMERIC,
	unitpricediscount NUMERIC,
	CONSTRAINT pk_salesorderdetails PRIMARY KEY (salesorderdetailid),
	CONSTRAINT fk_salesorderdetails_salesorderheader FOREIGN KEY (salesorderid) REFERENCES salesorderheader(salesorderid),
	CONSTRAINT fk_salesorderdetails_product FOREIGN KEY (productid) REFERENCES product(productid)
);