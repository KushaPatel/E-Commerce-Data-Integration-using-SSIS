# E-Commerce SSIS ETL Project

This project implements a comprehensive ETL (Extract, Transform, Load) pipeline using **SQL Server Integration Services (SSIS)** to automate the ingestion, transformation, validation, and loading of raw e-commerce data from multiple CSV sources into a well-structured **Snowflake schema** in a SQL Server Data Warehouse.

## 📌 Project Overview
Project Name: E-Commerce Data Integration and ETL using SSIS  
Tools Used:
- SQL Server Integration Services (SSIS)  
- Microsoft SQL Server Management Studio (SSMS)  
- Visual Studio with SSDT  
- CSV Files as data sources  

## 🎯 Objectives
✅ Automate extraction and loading of raw CSV data into staging, dimension, and fact tables.  
✅ Enforce data quality through cleansing, validation, and error handling.  
✅ Centralized error logging for auditing and debugging.  
✅ Incremental data loading for efficient performance.  
✅ Reusable and scalable SSIS package design.  

## 🗂️ Data Warehouse Schema
The schema follows a **Snowflake model** to ensure data normalization and optimal performance for analytics.


## 📦 SSIS Packages
The project is organized into modular SSIS packages:

| Package Name                       | Purpose                                |
|------------------------------------|----------------------------------------|
| LoadDimensions.dtsx                | Loads data into dimension tables       |
| LoadFactOrders.dtsx                | Loads data into FactOrders, FactOrderItems, and FactReturns |
| LoadRatings.dtsx                   | Loads data into FactCustomerRatings    |
| LoadCampaignProductSubCategory.dtsx| Loads data into FactCampaignProductSubcategory |

Each package includes robust error handling, audit logging, and data validation to ensure referential integrity and data consistency.

## ⚙️ Error Handling
Invalid or problematic data is captured in a centralized **BadDataLog** table, including details like:
- Table name  
- Error description  
- Raw error data  
- Log date  

This ensures that no data issues are lost and enables thorough auditing and data quality monitoring.

## 🚀 Key Features
- **Data Quality Enforcement:** Consistent cleansing and validation of data fields (e.g., trimming, proper case formatting, type conversions).  
- **Incremental Load Support:** Efficiently updates new or changed data without reloading the entire dataset.  
- **Scalability:** Ready to integrate additional data sources or new business cases.  
- **Detailed Logging:** Centralized error logging with descriptions for easier debugging and auditing.

## 📝 Conclusion
This project delivers a robust and scalable ETL solution tailored for e-commerce data analytics. It ensures data integrity, supports comprehensive KPIs and business insights, and lays a solid foundation for future data-driven decision-making in the organization.

---

**Note:** For detailed package-level documentation and data flow diagrams, please refer to the [E-Commerce_SSIS_Project.docx](./E-Commerce_SSIS_Project.docx) file.

---
