CREATE TABLE DimCloudProvider(
provider_surrogate_key INT PRIMARY KEY IDENTITY(100,1),
provider_key INT NOT NULL,
provider_name VARCHAR(100) NOT NULL
);

CREATE TABLE DimCloudService(
service_surrogate_key INT PRIMARY KEY IDENTITY(100,1),
service_key VARCHAR(10) NOT NULL,
service_name VARCHAR(100) NOT NULL,
provider_name VARCHAR(100) NOT NULL,
description TEXT NULL
);

CREATE TABLE DimOffice(
office_surrogate_key INT PRIMARY KEY IDENTITY(100,1),
office_key VARCHAR(10) NOT NULL,
office_name VARCHAR(100) NOT NULL,
office_street_address VARCHAR(100) NOT NULL,
office_city VARCHAR(100) NOT NULL,
office_state VARCHAR(100) NOT NULL,
office_region VARCHAR(100) NOT NULL,
office_country VARCHAR(100) NOT NULL
);

CREATE TABLE DimRegion(
region_surrogate_key INT PRIMARY KEY IDENTITY(100,1),
region_name VARCHAR(100) NOT NULL
);

CREATE TABLE DimCountry(
country_surrogate_key INT PRIMARY KEY IDENTITY(100,1),
country_name VARCHAR(100) NOT NULL
);

CREATE TABLE DimEmployee(
employee_surrogate_key INT PRIMARY KEY IDENTITY(100,1),
employee_key VARCHAR(10) NOT NULL,
employee_name VARCHAR(100) NOT NULL
);

CREATE TABLE DimDate(
date DATE NOT NULL,
year SMALLINT NOT NULL,
month_number CHAR(2) NOT NULL,
month_name VARCHAR(10) NOT NULL,
day_of_month CHAR(2) NOT NULL,
quarter CHAR(2) NOT NULL,
weekday_number TINYINT NOT NULL,
weekday_name VARCHAR(10) NOT NULL,
week_number TINYINT NOT NULL,
year_month VARCHAR(20) NOT NULL,
year_quarter CHAR(7) NOT NULL
);

CREATE TABLE FactIncidents(
incident_surrogate_key INT PRIMARY KEY IDENTITY(100,1),
incident_key VARCHAR(10) NOT NULL,
incident_date DATETIME NOT NULL,
provider_surrogate_key INT NOT NULL,
service_surrogate_key INT NOT NULL,
office_surrogate_key INT NOT NULL,
region_surrogate_key INT NOT NULL,
country_surrogate_key INT NOT NULL,
employee_surrogate_key INT NOT NULL,
downtime_minutes NULL,
    
CONSTRAINT fk_provider_surrogate_key
FOREIGN KEY (provider_surrogate_key) REFERENCES DimCloudProvider(provider_surrogate_key),
    
CONSTRAINT fk_service_surrogate_key
FOREIGN KEY (service_surrogate_key) REFERENCES DimCloudService(service_surrogate_key),
    
CONSTRAINT fk_office_surrogate_key
FOREIGN KEY (office_surrogate_key) REFERENCES DimOffice(office_surrogate_key),
    
CONSTRAINT fk_region_surrogate_key
FOREIGN KEY (region_surrogate_key) REFERENCES DimRegion(region_surrogate_key),
    
CONSTRAINT fk_country_surrogate_key
FOREIGN KEY (country_surrogate_key) REFERENCES DimCountry(country_surrogate_key),
    
CONSTRAINT fk_employee_surrogate_key
FOREIGN KEY (employee_surrogate_key) REFERENCES DimEmployee(employee_surrogate_key)
);