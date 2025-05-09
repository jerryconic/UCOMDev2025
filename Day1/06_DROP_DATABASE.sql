USE master;

DROP DATABASE db01;

EXEC sp_who

--kill 74

IF EXISTS(SELECT * FROM sys.databases WHERE name = 'db01')
BEGIN
	ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE db01;
END


CREATE DATABASE db01;

GO

USE db01;

CREATE TABLE dbo.Employee
(
emp_id int PRIMARY KEY,
emp_name nvarchar(20),
birth_date date,
salary decimal(10, 2)
);

ALTER TABLE dbo.Employee
ALTER COLUMN emp_name nvarchar(25)
GO

ALTER TABLE dbo.Employee 
ADD
	mobile nvarchar(20) NULL,
	phone nvarchar(20) NULL
GO

EXEC sp_help 'dbo.Employee'
GO

ALTER TABLE dbo.Employee
	DROP COLUMN mobile, phone
GO

EXEC sp_help 'dbo.Employee'
GO
