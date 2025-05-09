USE AdventureWorks2019
GO

CREATE VIEW dbo.V1
WITH SCHEMABINDING
AS
SELECT  CUST.CustomerID ,
        PER.FirstName ,
        PER.LastName ,
        SOH.SalesOrderID ,
        SOH.OrderDate ,
        SOH.[Status] ,
        SOD.ProductID ,
        PROD.Name ,
        SOD.OrderQty
FROM    Sales.SalesOrderHeader SOH
        INNER JOIN Sales.SalesOrderDetail SOD 
               ON SOH.SalesOrderID = SOD.SalesOrderID
        INNER JOIN Production.Product PROD
               ON PROD.ProductID = SOD.ProductID
        INNER JOIN Sales.Customer CUST
               ON SOH.CustomerID = CUST.CustomerID
        INNER JOIN Person.Person PER
               ON PER.BusinessEntityID = CUST.PersonID;
GO
CREATE UNIQUE CLUSTERED INDEX CX_V1 
ON dbo.V1(CustomerID ASC, SalesOrderID ASC, ProductID ASC)

GO

EXEC sp_spaceused 'dbo.V1'

SELECT * FROM dbo.V1

SELECT * FROM dbo.V1 WITH(NOEXPAND)



SELECT * FROM dbo.V1
WHERE CustomerID = 29825;

SELECT * FROM dbo.V1 WITH(NOEXPAND)
WHERE CustomerID = 29825;


SELECT CustomerID, FirstName, LastName, SalesOrderID, ProductID
FROM dbo.V1 
WHERE FirstName = 'James'
--0.658843

SELECT CustomerID, FirstName, LastName, SalesOrderID, ProductID
FROM dbo.V1 WITH(NOEXPAND)
WHERE FirstName = 'James'
--1.30858
GO

CREATE NONCLUSTERED INDEX IX_FirstName 
ON dbo.V1(FirstName)
INCLUDE(LastName)


GO



SELECT CustomerID, FirstName, LastName, SalesOrderID, ProductID
FROM dbo.V1 
WHERE FirstName = 'James'
--0.658843

SELECT CustomerID, FirstName, LastName, SalesOrderID, ProductID
FROM dbo.V1 WITH(NOEXPAND)
WHERE FirstName = 'James'
--0.0100102
GO



CREATE VIEW dbo.V2
WITH SCHEMABINDING
AS

SELECT  CUST.CustomerID ,
        SOH.SalesOrderID ,
        SOH.OrderDate ,
        SOD.ProductID ,
        PROD.Name ,
        SUM(SOD.OrderQty) AS TotalSpent,
		COUNT_BIG(*) AS CNT
FROM    Sales.SalesOrderHeader SOH
        INNER JOIN Sales.SalesOrderDetail SOD
               ON SOH.SalesOrderID = SOD.SalesOrderID
        INNER JOIN Production.Product PROD
               ON PROD.ProductID = SOD.ProductID
        INNER JOIN Sales.Customer CUST
               ON SOH.CustomerID = CUST.CustomerID
        INNER JOIN Person.Person PER
               ON PER.BusinessEntityID = CUST.PersonID
GROUP BY CUST.CustomerID ,
        SOH.SalesOrderID ,
        SOH.OrderDate ,
        SOD.ProductID ,
        PROD.Name; 
GO


CREATE UNIQUE CLUSTERED INDEX CX_V2 
ON dbo.V2(CustomerID ASC, SalesOrderID ASC, ProductID ASC)

GO

