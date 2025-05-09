USE Northwind;

GO

DROP VIEW IF EXISTS dbo.V1
GO

CREATE OR ALTER VIEW dbo.V1
AS
SELECT TOP(100) PERCENT
EmployeeID, 
FirstName + ' ' + LastName AS EmployeeName
FROM dbo.Employees
ORDER BY FirstName
GO

SELECT * FROM dbo.V1;

/*
EXEC sp_helptext 'dbo.V2'
SELECT * FROM dbo.V2;
*/

SELECT * FROM sys.views;
GO


CREATE OR ALTER VIEW dbo.V1
WITH ENCRYPTION
AS
SELECT TOP(100) PERCENT
EmployeeID, 
FirstName + ' ' + LastName AS EmployeeName
FROM dbo.Employees
ORDER BY FirstName
GO

SELECT * FROM dbo.V1;

EXEC sp_help 'dbo.V1'
EXEC sp_helptext 'dbo.V1'
EXEC sp_helptext 'dbo.Invoices'

SELECT * FROM sys.views;
SELECT * FROM INFORMATION_SCHEMA.VIEWS;

