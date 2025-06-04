------------------------------USED DATABASE------------------------------
Use ECommerce_ShopSmartDW

------------------------------CREATED TABLES------------------------------
---------------LoadDimensions Package---------------
----Customer Staging Table
CREATE TABLE StgCustomer (
    customer_id VARCHAR(100) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    Full_name NVARCHAR(200) NOT NULL,
    email NVARCHAR(255) NOT NULL,
    country VARCHAR(100) NOT NULL,
    LoadDateTime DATETIME DEFAULT GETDATE() 
);
Alter Table StgCustomer Alter Column Full_name NVARCHAR(201) NOT NULL

----Supplier Staging Table
CREATE TABLE StgSupplier (
    supplier_id VARCHAR(100) PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    email NVARCHAR(255) NOT NULL,
    LoadDateTime DATETIME DEFAULT GETDATE() 
);

----Category Staging Table
CREATE TABLE StgCategory (
    category_id VARCHAR(100) PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    LoadDateTime DATETIME DEFAULT GETDATE()
);

----SubCategory Staging Table
CREATE TABLE StgSubcategory (
    subcategory_id VARCHAR(100) PRIMARY KEY,
    subcategory_name VARCHAR(100) NOT NULL,
    category_id VARCHAR(100),
    LoadDateTime DATETIME DEFAULT GETDATE()
);

----Product Staging Table
CREATE TABLE StgProduct (
    product_id VARCHAR(100) PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    product_description NVARCHAR(MAX) NOT NULL,
    subcategory_id VARCHAR(100),
    LoadDateTime DATETIME DEFAULT GETDATE()
);

----PaymentMethod Staging Table
CREATE TABLE StgPaymentMethod (
    payment_method_id VARCHAR(100) PRIMARY KEY,
    payment_method VARCHAR(100) NOT NULL,
    LoadDateTime DATETIME DEFAULT GETDATE()
);

----MarketingCampaign Staging Table
CREATE TABLE StgMarketingCampaign (
    campaign_id VARCHAR(100) PRIMARY KEY,
    campaign_name VARCHAR(100) NOT NULL,
    offer_week INT NOT NULL,
    LoadDateTime DATETIME DEFAULT GETDATE()
);

--Load Table Records
select * from StgCustomer
select * from StgSupplier
select * from StgCategory
select * from StgSubcategory
select * from StgProduct
select * from StgPaymentMethod
select * from StgMarketingCampaign


---------------LoadFactOrders Package---------------
----Staging Table for Orders
CREATE TABLE StgFactOrders (
    order_id_surrogate VARCHAR(100) NOT NULL,
    order_id VARCHAR(100) PRIMARY KEY,
    customer_id VARCHAR(100),
    order_date DATE NOT NULL,
    campaign_id VARCHAR(100),
    amount DECIMAL(10,2) NOT NULL,
    payment_method_id VARCHAR(100),
    LoadDateTime DATETIME DEFAULT GETDATE()
);

----Staging Table for OrderItem
CREATE TABLE StgFactOrderItems (
    orderitem_id VARCHAR(100) PRIMARY KEY,
    order_id VARCHAR(100) ,
    product_id VARCHAR(100),
    quantity INT NOT NULL,
    supplier_id VARCHAR(100),
    subtotal DECIMAL(10,2) NOT NULL,
    discount FLOAT NOT NULL,
    LoadDateTime DATETIME DEFAULT GETDATE()
);

----Staging Table for Returns
CREATE TABLE StgFactReturns (
    return_id VARCHAR(100) PRIMARY KEY,
    order_id VARCHAR(100),
    product_id VARCHAR(100),
    return_date DATE NOT NULL,
    reason NVARCHAR(255) NOT NULL,
    amount_refunded DECIMAL(10,2) NOT NULL,
    LoadDateTime DATETIME DEFAULT GETDATE()
);

--Load Table Records
select * from StgFactOrders
select * from StgFactOrderItems
select * from StgFactReturns


---------------LoadFactRating Package---------------
--Staging Table for CustomerRating
CREATE TABLE StgFactCustomerRatings (
    customerproductrating_id VARCHAR(100) PRIMARY KEY,
    customer_id VARCHAR(100),
    product_id VARCHAR(100),
    ratings FLOAT NOT NULL,
    review NVARCHAR(MAX) NOT NULL,
    sentiment VARCHAR(100) NOT NULL,
    LoadDateTime DATETIME DEFAULT GETDATE()
);

--Load Table Records
select * from StgFactCustomerRatings


---------------LoadFactCampaignProductSubCategory Package---------------
--Staging Table for CampaignSubcatgeory
CREATE TABLE StgFactCampaignSubcategory (
    campaign_product_subcategory_id VARCHAR(100) PRIMARY KEY,
    campaign_id VARCHAR(100),
    subcategory_id VARCHAR(100),
    discount FLOAT NOT NULL,
    LoadDateTime DATETIME DEFAULT GETDATE()
);

--Load Table Records
select * from StgFactCampaignSubcategory