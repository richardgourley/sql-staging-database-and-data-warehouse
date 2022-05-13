CREATE SCHEMA staging
GO

BEGIN TRANSACTION

BEGIN TRY

    CREATE TABLE staging.Offices(
        office_id INT PRIMARY KEY IDENTITY,
        office_key VARCHAR(10),
        office_name VARCHAR(100) NOT NULL,
        office_address VARCHAR(200) NOT NULL,
        office_city VARCHAR(100) NOT NULL,
        office_state VARCHAR(100) NOT NULL,
        office_region VARCHAR(100) NOT NULL,
        office_country VARCHAR(100) NOT NULL,
        date_opened DATETIME NOT NULL,
        date_closed DATETIME NULL,
        directions TEXT NULL
    );

    CREATE TABLE staging.Employees(
        employee_id INT PRIMARY KEY IDENTITY,
        employee_number VARCHAR(10),
        employee_office_id INT NOT NULL,
        employee_first_name VARCHAR(100) NOT NULL,
        employee_last_name VARCHAR(100) NOT NULL,
        social_number VARCHAR(20) NOT NULL,
        date_of_birth DATETIME NOT NULL,
        start_date DATETIME NOT NULL,
        finish_date DATETIME NULL,

        CONSTRAINT fk_employee_office_id
        FOREIGN KEY(employee_office_id) REFERENCES staging.Offices(office_id)
    );

    CREATE TABLE staging.CloudProvider(
        provider_id INT PRIMARY KEY IDENTITY,
        provider_key VARCHAR(10) NOT NULL,
        provider_name VARCHAR(100) NOT NULL,
        provider_url VARCHAR(100) NOT NULL,
        provider_docs_url VARCHAR(100) NULL
    );

    CREATE TABLE staging.CloudService(
        service_id INT PRIMARY KEY IDENTITY,
        service_key VARCHAR(10) NOT NULL,
        service_name VARCHAR(100) NOT NULL,
        provider_id INT NOT NULL,

        CONSTRAINT fk_provider_id
        FOREIGN KEY(provider_id) REFERENCES staging.CloudProvider(provider_id)
    );

    CREATE TABLE staging.AcquiredCloudServices(
        acquired_service_id INT PRIMARY KEY IDENTITY,
        service_id INT NOT NULL,
        office_id INT NOT NULL,
        date_activated DATETIME NOT NULL,
        date_terminated DATETIME NULL,

        CONSTRAINT fk_service_id
        FOREIGN KEY(service_id) REFERENCES staging.CloudService(service_id),

        CONSTRAINT fk_office_id
        FOREIGN KEY(office_id) REFERENCES staging.Offices(office_id)
    );

    CREATE TABLE staging.Incidents(
        incident_id INT PRIMARY KEY IDENTITY,
        incident_date DATETIME NOT NULL,
        acquired_service_id INT NOT NULL,
            -- Can be null if the incident has not been resolved
        downtime_minutes SMALLINT NULL,

        CONSTRAINT fk_acquired_service_id
        FOREIGN KEY(acquired_service_id) REFERENCES staging.AcquiredCloudServices(acquired_service_id)
    );

END TRY

BEGIN CATCH

IF @@TRANCOUNT > 0
    ROLLBACK TRANSACTION;

END CATCH

IF @@TRANCOUNT > 0
    COMMIT TRANSACTION;

