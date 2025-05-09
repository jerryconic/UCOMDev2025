USE Northwind;

SELECT CustomerID AS id, CompanyName AS [Customer Name]
FROM dbo.Customers AS Customer 
FOR XML AUTO;

SELECT CustomerID, CompanyName
FROM dbo.Customers
FOR XML RAW;


SELECT CustomerID, CompanyName
FROM dbo.Customers
FOR XML RAW('Customer');


SELECT TOP(5) CustomerID, CompanyName
FROM dbo.Customers AS Customer
FOR XML AUTO, ROOT('Customers'), ELEMENTS;

SELECT CustomerID, CompanyName
FROM dbo.Customers
FOR XML RAW, ROOT('Customers'), ELEMENTS;
------------------------------------------------
SELECT Customer.CustomerID, Customer.CompanyName,
	SalesOrder.OrderID, SalesOrder.OrderDate
FROM dbo.Orders AS SalesOrder
INNER JOIN dbo.Customers AS Customer
	ON SalesOrder.CustomerID = Customer.CustomerID
ORDER BY CustomerID, OrderID
FOR XML AUTO;

SELECT Customer.CustomerID, Customer.CompanyName,
	SalesOrder.OrderID, SalesOrder.OrderDate
FROM dbo.Orders AS SalesOrder
INNER JOIN dbo.Customers AS Customer
	ON SalesOrder.CustomerID = Customer.CustomerID
ORDER BY CustomerID, OrderID
FOR XML RAW;

SELECT Customer.CustomerID, Customer.CompanyName,
	SalesOrder.OrderID, SalesOrder.OrderDate
FROM dbo.Orders AS SalesOrder
INNER JOIN dbo.Customers AS Customer
	ON SalesOrder.CustomerID = Customer.CustomerID
ORDER BY CustomerID, OrderID
FOR XML AUTO, ROOT('Customers'), ELEMENTS;

SELECT Customer.CustomerID, Customer.CompanyName,
	SalesOrder.OrderID, SalesOrder.OrderDate
FROM dbo.Orders AS SalesOrder
INNER JOIN dbo.Customers AS Customer
	ON SalesOrder.CustomerID = Customer.CustomerID
ORDER BY CustomerID, OrderID
FOR XML RAW, ROOT('Customers'), ELEMENTS;
-------------------------------------------------------------

SELECT ProductID
FROM dbo.[Order Details] od
WHERE OrderID = 10400
FOR XML PATH('a');

SELECT ProductID
FROM dbo.[Order Details] od
WHERE OrderID = 10400
FOR XML PATH('');


SELECT CONCAT(ProductID, ',')
FROM dbo.[Order Details] od
WHERE OrderID = 10400
FOR XML PATH('');

SELECT o.OrderID, o.OrderDate, od.ProductID
FROM dbo.Orders o
INNER JOIN dbo.[Order Details] od ON o.OrderID = od.OrderID
WHERE o.OrderDate BETWEEN '1997-1-1' AND '1997-1-5';

SELECT CONCAT(ProductID, ',')
FROM dbo.[Order Details] od
WHERE OrderID = 10400
FOR XML PATH('');

SELECT OrderID, OrderDate,
(
SELECT CONCAT(ProductID, ',')
FROM dbo.[Order Details] od
WHERE OrderID = o.OrderID
FOR XML PATH('')
)
FROM dbo.Orders o
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-1-5';
GO

DECLARE @sql nvarchar(max);
SET @sql = 
N'WITH EmpTotal
AS
(
SELECT  e.FirstName, 
MONTH(o.OrderDate) AS mn, 
SUM(od.Quantity*od.UnitPrice) AS Total
FROM dbo.Employees e
INNER JOIN dbo.Orders o	
	ON e.EmployeeID = o.EmployeeID
INNER JOIN dbo.[Order Details] od
	ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY e.EmployeeID, e.FirstName, MONTH(o.OrderDate)
)
SELECT * FROM EmpTotal
PIVOT(
	SUM(Total)
	FOR FirstName IN (Nancy,Andrew,Janet,Margaret,Steven,Michael,Robert,Laura,Anne)
) a;
';
EXECUTE(@sql);

GO
DECLARE @name nvarchar(1000);
DECLARE @sql nvarchar(max);
SET @name = N'Nancy,Andrew,Janet,Margaret,Steven,Michael,Robert,Laura,Anne';
SET @sql = 
N'WITH EmpTotal
AS
(
SELECT  e.FirstName, 
MONTH(o.OrderDate) AS mn, 
SUM(od.Quantity*od.UnitPrice) AS Total
FROM dbo.Employees e
INNER JOIN dbo.Orders o	
	ON e.EmployeeID = o.EmployeeID
INNER JOIN dbo.[Order Details] od
	ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY e.EmployeeID, e.FirstName, MONTH(o.OrderDate)
)
SELECT * FROM EmpTotal
PIVOT(
	SUM(Total)
	FOR FirstName IN (' + @name + N')
) a;
';
EXECUTE(@sql);
GO

DECLARE @name nvarchar(1000);
DECLARE @sql nvarchar(max);
--SET @name = N'Nancy,Andrew,Janet,Margaret,Steven,Michael,Robert,Laura,Anne';
SET @name = (SELECT FirstName + ',' FROM dbo.Employees FOR XML PATH(''));
SET @name = SUBSTRING(@name, 1, LEN(@name)-1)
SET @sql = 
N'WITH EmpTotal
AS
(
SELECT  e.FirstName, 
MONTH(o.OrderDate) AS mn, 
SUM(od.Quantity*od.UnitPrice) AS Total
FROM dbo.Employees e
INNER JOIN dbo.Orders o	
	ON e.EmployeeID = o.EmployeeID
INNER JOIN dbo.[Order Details] od
	ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY e.EmployeeID, e.FirstName, MONTH(o.OrderDate)
)
SELECT * FROM EmpTotal
PIVOT(
	SUM(Total)
	FOR FirstName IN (' + @name + N')
) a;
';
EXECUTE(@sql);
GO
--------------------------------------------------------------------
SELECT * FROM dbo.Customers AS Customer
FOR XML AUTO, ROOT('Customers'), ELEMENTS, XMLSCHEMA;


USE AdventureWorks2019;

SELECT * FROM Production.Product
FOR XML AUTO;

SELECT * FROM Production.Product
FOR XML AUTO, ROOT('Products');


SELECT * FROM Production.Product
FOR XML AUTO, ROOT('Products'), XMLSCHEMA;