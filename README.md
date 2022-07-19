# SQL Staging Database and Data Warehouse
An example of a company using a staging database and a star schema data warehouse made specifically for data analysis.

## INTO
- The examples are based on a global company with offices and  employees based in different locations around the world.
- The company uses different cloud services from different cloud providers.
- Staff log any incidents and the length of downtime they experience for each of their cloud services.

## STAGING TABLES

![Staging Tables](https://github.com/richardgourley/sql-staging-database-and-data-warehouse/blob/main/staging_tables.png)

- It is considered good practice to create a staging database which the data warehouse can be fed data from.
- The main reason for having a staging database is to keep the main company transaction database to be used and specifically designed for inserting data such as new employees, sales details, incidents, orders etc.
- A staging database can be designed differently, acting as a read only database where data is extracted from, transformed and then loaded into the data warehouse tables.
- The staging tables in the example staging database are tables taken from an example company transaction database that logs downtime incidents with cloud services.

## DATA WAREHOUSE TABLES

![Data Warehouse Tables](https://github.com/richardgourley/sql-staging-database-and-data-warehouse/blob/main/data_warehouse_tables.png)

- The data warehouse tables are a de-normalized version of the staging tables, optimized for data analysis.
- The data warehouse table examples given is a simplified example of a star schema.
- In this star schema, the FactIncidents table is made up of columns that are linked to the unique surrogate keys (not business keys) of the dimension tables.
- The surrogate key should ideally be an integer for faster querying.
- The surrogate key should link to the fact table and be unique to the data warehouse.
- The business keys (such as employee_key or office_key) should not be used to link to the data warehouse, as they are from the main transaction table and can change over time.
- Notice that the FactIncidents table has numerous foreign keys - this allows filtering by the dimension tables (whether using SQL, SSRS, PowerBI, Tableau)
- Star and snowflake schemas are tailored to data analysis where you want to find out how results look by different dimensions.
- The data warehouse can be populated by ETL processes with data taken from the staging database without needing to retrieve data from the main company transaction database.

## EXAMPLE QUESTIONS
**Through native SQL queries or BI tools such as PowerBI, the star schema is optimized to answer example questions like these:**
1. Is there a particular day of the month we have more outages? Is there a company reason for this? (DimDate table)
2. Is there a particular office that has more incidents than others? (DimOffice table)
3. Is there a specific employee that reports more incidents than others?  Could an investigation and better staff training solve this? (DimEmployee table)
4. Is there a specific cloud service or cloud provider that keeps letting us down in terms of downtime and regularity of problems? (DimCloudService, DimCloudProvider)
5. Could it be that we mainly have problems in one region or one country?  (DimCountry, DimRegion)
6. What is the average downtime in minutes per region/ office/ country? (DimRegion, DimOffice, DimCountry)

## CONTENTS
**Staging Tables (staging schema)**
- Offices
- Employees
- CloudProvider
- CloudService
- AcquiredCloudService
- Incidents

**Data Warehouse Tables**

(Dim means dimension table. All Dim tables point to the main FactIncidents fact table.)

- DimCloudProvider
- DimCloudService
- DimOffice
- DimRegion
- DimCountry
- DimEmployee
- DimDate
- FactIncidents
