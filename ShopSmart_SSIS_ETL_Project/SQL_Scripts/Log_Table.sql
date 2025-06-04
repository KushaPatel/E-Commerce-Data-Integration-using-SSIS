------------------------------USED DATABASE------------------------------
Use ECommerce_ShopSmartDW

------------------------------BAD LOG TABLE------------------------------
----Bad Data Logging Table
CREATE TABLE BadDataLog (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    table_name NVARCHAR(100) NOT NULL,
    error_description NVARCHAR(MAX) NOT NULL,
    error_data NVARCHAR(MAX) NOT NULL,
    log_date DATETIME DEFAULT GETDATE()
)

--Load Table Records
select * from BadDataLog


------------------------------AUDIT LOG TABLES------------------------------
---------------LoadDimensions Package---------------
----Audit Table of Customer
CREATE TABLE CustomerAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID VARCHAR(100) NOT NULL,
    ActionType VARCHAR(50) NOT NULL, 
    ActionDateTime DATETIME DEFAULT GETDATE(), 
    PerformedBy NVARCHAR(100) DEFAULT SYSTEM_USER, 
    Old_first_name VARCHAR(100),
    New_first_name VARCHAR(100),
    Old_last_name VARCHAR(100),
    New_last_name VARCHAR(100),
	Old_Full_name NVARCHAR(201),
    New_Full_name NVARCHAR(201),
    Old_email NVARCHAR(255),
    New_email NVARCHAR(255),
    Old_country VARCHAR(100),
    New_country VARCHAR(100) 
);

----Audit Table of Supplier
CREATE TABLE SupplierAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierID VARCHAR(100) NOT NULL,
    ActionType VARCHAR(50) NOT NULL, 
    ActionDateTime DATETIME DEFAULT GETDATE(),
    PerformedBy NVARCHAR(100) DEFAULT SYSTEM_USER,
    Old_supplier_name VARCHAR(100),
    New_supplier_name VARCHAR(100),
    Old_email NVARCHAR(255),
    New_email NVARCHAR(255)
);

----Audit Table of Category
CREATE TABLE CategoryAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryID VARCHAR(100) NOT NULL,
    ActionType VARCHAR(50) NOT NULL, 
    ActionDateTime DATETIME DEFAULT GETDATE(),
    PerformedBy NVARCHAR(100) DEFAULT SYSTEM_USER,
    Old_category_name VARCHAR(100),
    New_category_name VARCHAR(100)
);

----Audit Table of SubCategory
CREATE TABLE SubcategoryAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    SubcategoryID VARCHAR(100) NOT NULL,
    ActionType VARCHAR(50) NOT NULL, 
    ActionDateTime DATETIME DEFAULT GETDATE(),
    PerformedBy NVARCHAR(100) DEFAULT SYSTEM_USER,
    Old_subcategory_name VARCHAR(100),
    New_subcategory_name VARCHAR(100),
    Old_category_id VARCHAR(100),
    New_category_id VARCHAR(100)
);

----Audit Table of Product
CREATE TABLE ProductAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID VARCHAR(100) NOT NULL,
    ActionType VARCHAR(50) NOT NULL, 
    ActionDateTime DATETIME DEFAULT GETDATE(),
    PerformedBy NVARCHAR(100) DEFAULT SYSTEM_USER,
    Old_product_name VARCHAR(255),
    New_product_name VARCHAR(255),
    Old_price DECIMAL(10,2),
    New_price DECIMAL(10,2),
    Old_product_description NVARCHAR(MAX),
    New_product_description NVARCHAR(MAX),
    Old_subcategory_id VARCHAR(100),
    New_subcategory_id VARCHAR(100)
);

----Audit Table of PaymentMethod
CREATE TABLE PaymentMethodAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    PaymentMethodID VARCHAR(100) NOT NULL,
    ActionType VARCHAR(50) NOT NULL, 
    ActionDateTime DATETIME DEFAULT GETDATE(),
    PerformedBy NVARCHAR(100) DEFAULT SYSTEM_USER,
    Old_payment_method VARCHAR(100),
    New_payment_method VARCHAR(100)
);

----Audit Table of MarketingCampaign 
CREATE TABLE MarketingCampaignAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    CampaignID VARCHAR(100) NOT NULL,
    ActionType VARCHAR(50) NOT NULL, 
    ActionDateTime DATETIME DEFAULT GETDATE(),
    PerformedBy NVARCHAR(100) DEFAULT SYSTEM_USER,
    Old_campaign_name VARCHAR(100),
    New_campaign_name VARCHAR(100),
    Old_offer_week INT,
    New_offer_week INT
);

--Load Table Records
select * from CustomerAuditLog
select * from SupplierAuditLog
select * from CategoryAuditLog
select * from SubcategoryAuditLog
select * from ProductAuditLog
select * from PaymentMethodAuditLog
select * from MarketingCampaignAuditLog


---------------LoadFactOrders Package---------------
----Audit for Orders
CREATE TABLE OrdersAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID VARCHAR(100) NOT NULL,
    ActionType VARCHAR(50) NOT NULL, 
    ActionDateTime DATETIME DEFAULT GETDATE(),
    PerformedBy NVARCHAR(100) DEFAULT SYSTEM_USER,
    Old_order_id_surrogate VARCHAR(100),
    New_order_id_surrogate VARCHAR(100),
    Old_customer_id VARCHAR(100),
    New_customer_id VARCHAR(100),
    Old_order_date DATE,
    New_order_date DATE,
    Old_campaign_id VARCHAR(100),
    New_campaign_id VARCHAR(100),
    Old_amount DECIMAL(10,2),
    New_amount DECIMAL(10,2),
    Old_payment_method_id VARCHAR(100),
    New_payment_method_id VARCHAR(100)
);

----Audit Table for OrderItem
CREATE TABLE OrderItemsAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    OrderItemID VARCHAR(100) NOT NULL,
    ActionType VARCHAR(50) NOT NULL,
    ActionDateTime DATETIME DEFAULT GETDATE(),
    PerformedBy NVARCHAR(100) DEFAULT SYSTEM_USER,
    Old_order_id VARCHAR(100),
    New_order_id VARCHAR(100),
    Old_product_id VARCHAR(100),
    New_product_id VARCHAR(100),
    Old_quantity INT,
    New_quantity INT,
    Old_supplier_id VARCHAR(100),
    New_supplier_id VARCHAR(100),
    Old_subtotal DECIMAL(10,2),
    New_subtotal DECIMAL(10,2),
    Old_discount FLOAT,
    New_discount FLOAT
);

----Audit Table for Returns
CREATE TABLE ReturnsAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    ReturnID VARCHAR(100) NOT NULL,
    ActionType VARCHAR(50) NOT NULL,
    ActionDateTime DATETIME DEFAULT GETDATE(),
    PerformedBy NVARCHAR(100) DEFAULT SYSTEM_USER,
    Old_order_id VARCHAR(100),
    New_order_id VARCHAR(100),
    Old_product_id VARCHAR(100),
    New_product_id VARCHAR(100),
    Old_return_date DATE,
    New_return_date DATE,
    Old_reason NVARCHAR(255),
    New_reason NVARCHAR(255),
    Old_amount_refunded DECIMAL(10,2),
    New_amount_refunded DECIMAL(10,2)
);

--Load Table Records
select * from OrdersAuditLog
select * from OrderItemsAuditLog
select * from ReturnsAuditLog


---------------LoadFactRating Package---------------
----Audit Table for CustomerRating
CREATE TABLE CustomerRatingsAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerProductRatingID VARCHAR(100) NOT NULL,
    ActionType VARCHAR(50) NOT NULL,
    ActionDateTime DATETIME DEFAULT GETDATE(),
    PerformedBy NVARCHAR(100) DEFAULT SYSTEM_USER,
    Old_customer_id VARCHAR(100),
    New_customer_id VARCHAR(100),
    Old_product_id VARCHAR(100),
    New_product_id VARCHAR(100),
    Old_ratings FLOAT,
    New_ratings FLOAT,
    Old_review NVARCHAR(MAX),
    New_review NVARCHAR(MAX),
    Old_sentiment VARCHAR(100),
    New_sentiment VARCHAR(100)
);

--Load Table Records
select * from CustomerRatingsAuditLog


---------------LoadFactCampaignProductSubCategory Package---------------
----Audit Table for CampaignSubcategory
CREATE TABLE CampaignSubcategoryAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    CampaignProductSubcategoryID VARCHAR(100) NOT NULL,
    ActionType VARCHAR(50) NOT NULL,
    ActionDateTime DATETIME DEFAULT GETDATE(),
    PerformedBy NVARCHAR(100) DEFAULT SYSTEM_USER,
    Old_campaign_id VARCHAR(100),
    New_campaign_id VARCHAR(100),
    Old_subcategory_id VARCHAR(100),
    New_subcategory_id VARCHAR(100),
    Old_discount FLOAT,
    New_discount FLOAT
);

--Load Table Records
Select * from CampaignSubcategoryAuditLog