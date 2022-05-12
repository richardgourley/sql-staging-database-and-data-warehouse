# SQL Staging Database and Data Warehouse
An example of a company using a staging database and a star schema data warehouse made specifically for data analysis.

## INTO
- The examples are based on a global company with offices and  employees based in different locations around the world.
- The company uses different cloud services from different cloud providers.
- Staff log any incidents with their cloud services and how long any downtime was, in minutes.

## STAGING TABLES
- It is considered good practice to create a staging database which the data warehouse can be fed data from.
- The main reason for having a staging database instead of directly querying the main transaction database is that the main transaction database will receive a lot of insert statements and a lot of reads would slow down the main company database.
- Therefore, the staging database can be used mainly for reads instead of writes.
- The staging tables in this example, are the only required tables to analyse cloud services incidents, taken from a main transaction database.

## DATA WAREHOUSE TABLES
- The data warehouse tables give a simple example of a star schema.
- In this star schema, the FactIncidents table is made up of columns that are linked to the unique surrogate keys (not business keys) of the dimension tables.
- The surrogate key should ideally be an integer for faster querying.
- The surrogate key should link to the fact table and be unqiue to the data warehouse.
- The business keys (such as employee_key or office_key) should not be used to link to the data warehouse, as they are from the main transaction table and can change over time.
- Notice that the FactIncidents table has numerous foreign keys - this allows filtering by the dimension tables (whether using SQL, PowerBI, Tableau)
- Star and snowflake schemas are tailored to data analysis where you want to find out how results look by different dimensions.
- This data warehouse could allow us to answer these type of questions efficiently:

**Some company questions which this data warehouse setup could answer**
1. Is there a particular day of the month we have more outages? Is there a company reason for this? (DimDate table)
2. Is there a particular office that has more incidents than others? (DimOffice table)
3. Is there a specific employee that reports more incidents than others?  Could an investigation and better staff training solve this? (DimEmployee table)
4. Is there a specific cloud service or cloud provider that keeps letting us down in terms of downtime and regularity of problems? (DimCloudService, DimCloudProvider)
5. Could it be that we mainly have problems in one region or one country?  (DimCountry, DimRegion)

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
