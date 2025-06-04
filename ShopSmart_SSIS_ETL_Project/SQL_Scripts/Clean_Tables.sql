------------------------------CREATE DATABASE------------------------------
Create Database ECommerce_ShopSmartDW
Use ECommerce_ShopSmartDW

------------------------------CREATE DIMENSION TABLES------------------------------
---------------LoadDimensions Package---------------
----Customer Table
Create Table DimCustomer (
    customer_id varchar(100) PRIMARY KEY NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
	Full_name NVARCHAR(200) NOT NULL,
    email NVARCHAR(255) UNIQUE,
    country VARCHAR(100) NOT NULL
)
Alter Table DimCustomer Alter Column Full_name NVARCHAR(201) NOT NULL

----Supplier Table
Create Table DimSupplier (
    supplier_id varchar(100) PRIMARY KEY NOT NULL,
    supplier_name VARCHAR(100) NOT NULL,
    email NVARCHAR(255) UNIQUE NOT NULL
)

----Category Table
CREATE TABLE DimCategory (
    category_id varchar(100) PRIMARY KEY NOT NULL,
    category_name VARCHAR(100) NOT NULL 
)

----Subcategory Table
CREATE TABLE DimSubcategory (
    subcategory_id varchar(100) PRIMARY KEY NOT NULL,
    subcategory_name VARCHAR(100),
    category_id varchar(100) FOREIGN KEY REFERENCES DimCategory(category_id) on update cascade on delete cascade
)

----Product Table
CREATE TABLE DimProduct (
    product_id varchar(100) PRIMARY KEY NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    price decimal(10,2) NOT NULL,
    product_description NVARCHAR(MAX) NOT NULL,
    subcategory_id varchar(100) FOREIGN KEY REFERENCES DimSubcategory(subcategory_id) on update cascade on delete cascade
)

----Payment Method Table
CREATE TABLE DimPaymentMethod (
    payment_method_id varchar(100) PRIMARY KEY NOT NULL,
    payment_method VARCHAR(100) NOT NULL
)

----Marketing Campaign Table
CREATE TABLE DimMarketingCampaign (
    campaign_id varchar(100) PRIMARY KEY NOT NULL,
    campaign_name VARCHAR(100) NOT NULL,
    offer_week INT NOT NULL
)

--Load Table Records
select * from DimCustomer
select * from DimSupplier
select * from DimCategory
select * from DimSubcategory
select * from DimProduct
select * from DimPaymentMethod
select * from DimMarketingCampaign


------------------------------CREATE FACT TABLES------------------------------
---------------LoadFactOrders Package---------------
----Orders Table
CREATE TABLE FactOrders (
    order_id_surrogate varchar(100) NOT NULL,
    order_id varchar(100) PRIMARY KEY NOT NULL,
    customer_id varchar(100) FOREIGN KEY REFERENCES DimCustomer(customer_id) on update cascade on delete cascade,
    order_date DATE NOT NULL,
    campaign_id varchar(100) FOREIGN KEY REFERENCES DimMarketingCampaign(campaign_id) on update cascade on delete cascade,
    amount decimal(10,2) NOT NULL,
    payment_method_id varchar(100) FOREIGN KEY REFERENCES DimPaymentMethod(payment_method_id) on update cascade on delete cascade
)

----Order Items Table
CREATE TABLE FactOrderItems (
    orderitem_id varchar(100) PRIMARY KEY NOT NULL,
    order_id varchar(100) FOREIGN KEY REFERENCES FactOrders(order_id) on update cascade on delete cascade,
    product_id varchar(100) FOREIGN KEY REFERENCES DimProduct(product_id) on update cascade on delete cascade,
    quantity INT NOT NULL,
    supplier_id varchar(100) FOREIGN KEY REFERENCES DimSupplier(supplier_id) on update cascade on delete cascade,
    subtotal decimal(10,2) NOT NULL,
    discount FLOAT NOT NULL
)

----Returns Table
CREATE TABLE FactReturns (
    return_id varchar(100) PRIMARY KEY NOT NULL,
    order_id varchar(100) FOREIGN KEY REFERENCES FactOrders(order_id) on update cascade on delete cascade,
    product_id varchar(100) FOREIGN KEY REFERENCES DimProduct(product_id) on update cascade on delete cascade,
    return_date DATE NOT NULL,
    reason NVARCHAR(255) NOT NULL,
    amount_refunded decimal(10,2) NOT NULL
)

--Load Table Records
select * from FactOrders
select * from FactOrderItems
select * from FactReturns


---------------LoadFactRating Package---------------
----Customer Ratings Table
CREATE TABLE FactCustomerRatings (
    customerproductrating_id varchar(100) PRIMARY KEY NOT NULL,
    customer_id varchar(100) FOREIGN KEY REFERENCES DimCustomer(customer_id) on update cascade on delete cascade,
    product_id varchar(100) FOREIGN KEY REFERENCES DimProduct(product_id) on update cascade on delete cascade,
    ratings FLOAT NOT NULL,
    review NVARCHAR(MAX) NOT NULL,
    sentiment VARCHAR(100) NOT NULL
)

--Load Table Records
select * from FactCustomerRatings


---------------LoadFactCampaignProductSubCategory Package---------------
----Campaign-Subcategory Mapping Table
CREATE TABLE FactCampaignSubcategory (
    campaign_product_subcategory_id varchar(100) PRIMARY KEY NOT NULL,
    campaign_id varchar(100) FOREIGN KEY REFERENCES DimMarketingCampaign(campaign_id) on update cascade on delete cascade,
    subcategory_id varchar(100) FOREIGN KEY REFERENCES DimSubcategory(subcategory_id) on update cascade on delete cascade,
    discount FLOAT NOT NULL
)

--Load Table Records
select * from FactCampaignSubcategory

