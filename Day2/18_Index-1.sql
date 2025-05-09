USE db01;

--Ctrl + Shift + R
SELECT * FROM dbo.Orders

SELECT * FROM Northwind.dbo.Orders;

SET STATISTICS IO ON;

dbcc ind('db01', 'dbo.Orders', -1);

dbcc ind('Northwind', 'dbo.Orders', -1);

SELECT * FROM dbo.Orders
WHERE OrderID = 10400;

SELECT * FROM Northwind.dbo.Orders
WHERE OrderID = 10400;

GO
CREATE UNIQUE CLUSTERED INDEX CX_OrderID 
ON dbo.Orders(OrderID)

GO

SELECT * FROM Northwind.dbo.Orders
WHERE OrderID = 10400;

SELECT * FROM dbo.Orders
WHERE OrderID = 10400;

SELECT * FROM dbo.Orders
WHERE OrderDate = '1997-1-1'

SELECT * FROM Northwind.dbo.Orders
WHERE OrderDate = '1997-1-1'

GO

CREATE NONCLUSTERED INDEX IX_OrderDate 
ON dbo.Orders(OrderDate)


GO


SELECT * FROM dbo.Orders
WHERE OrderDate = '1997-1-1'

SELECT * FROM dbo.Person;

SELECT * FROM dbo.Person
WHERE BusinessEntityID = 1001;
GO

CREATE UNIQUE CLUSTERED INDEX CX_BusinessEntityID 
ON dbo.Person(BusinessEntityID)


GO

SELECT * FROM dbo.Person WITH(INDEX(0))
WHERE BusinessEntityID = 1001;


SELECT * FROM dbo.Person
WHERE BusinessEntityID = 1001;
GO


SELECT * FROM dbo.Orders
WHERE OrderDate = '1997-1-1'


SELECT * FROM dbo.Orders
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-1-5';


SELECT * FROM dbo.Orders WITH(INDEX(IX_OrderDate))
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-1-31';

SELECT * FROM dbo.Orders
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-1-31';


SELECT OrderID, OrderDate FROM dbo.Orders
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-1-31';


SELECT OrderID, OrderDate, CustomerID, EmployeeID FROM dbo.Orders
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-1-31';

GO
CREATE NONCLUSTERED INDEX IX_OrderDate 
ON dbo.Orders(OrderDate)
INCLUDE(CustomerID,EmployeeID) 
WITH (DROP_EXISTING = ON)


GO
SELECT OrderID, OrderDate, CustomerID, EmployeeID FROM dbo.Orders
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-1-31';

GO

SELECT * FROM dbo.Person
WHERE FirstName = 'Ken' AND LastName = 'Myer';

GO
CREATE NONCLUSTERED INDEX IX_FirstName_LastName 
ON dbo.Person(FirstName ASC, LastName ASC)
GO
SELECT * FROM dbo.Person
WHERE FirstName = 'Ken' AND LastName = 'Myer';


SELECT BusinessEntityID, FirstName, LastName, MiddleName, Title FROM dbo.Person
WHERE FirstName = 'Ken' AND LastName = 'Myer';

GO
CREATE NONCLUSTERED INDEX IX_FirstName_LastName 
ON dbo.Person(FirstName ASC, LastName ASC)
INCLUDE(Title,MiddleName) 
WITH (DROP_EXISTING = ON) 
GO


SELECT BusinessEntityID, FirstName, LastName, MiddleName, Title FROM dbo.Person
WHERE FirstName = 'Ken' AND LastName = 'Myer';




SELECT BusinessEntityID, FirstName, LastName, MiddleName, Title FROM dbo.Person
WHERE FirstName = 'Ken' 


SELECT BusinessEntityID, FirstName, LastName, MiddleName, Title FROM dbo.Person
WHERE LastName = 'Myer' 


SELECT BusinessEntityID, FirstName, LastName, MiddleName, Title FROM dbo.Person
WHERE MiddleName = 'L';


SELECT BusinessEntityID, FirstName, LastName, MiddleName, Title  FROM dbo.Person
ORDER BY FirstName, LastName

SELECT BusinessEntityID, FirstName, LastName, MiddleName, Title  FROM dbo.Person
ORDER BY FirstName DESC, LastName DESC

SELECT BusinessEntityID, FirstName, LastName, MiddleName, Title  FROM dbo.Person
ORDER BY FirstName ASC, LastName DESC

SELECT BusinessEntityID, FirstName, LastName, MiddleName, Title  FROM dbo.Person
ORDER BY FirstName DESC, LastName ASC

SELECT * FROM dbo.Person
ORDER BY BusinessEntityID;

SELECT * FROM dbo.Person
ORDER BY BusinessEntityID DESC;

SELECT OrderID, OrderDate, EmployeeID, CustomerID FROM dbo.Orders
WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 1;

SELECT OrderID, OrderDate, EmployeeID, CustomerID FROM dbo.Orders
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-1-31'
GO

ALTER TABLE dbo.Orders
ADD Yr AS YEAR(OrderDate),
Mn AS MONTH(OrderDate);
GO

CREATE NONCLUSTERED INDEX IX_Yr_Mn 
ON dbo.Orders(Yr ASC, Mn ASC)
INCLUDE(CustomerID,EmployeeID,OrderDate)

GO

SELECT OrderID, OrderDate, EmployeeID, CustomerID FROM dbo.Orders
WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 1;
GO


SELECT BusinessEntityID, FirstName, LastName, MiddleName, Title FROM dbo.Person
WHERE FirstName='Ken' OR LastName = 'Myer' 
--0.105251
GO


CREATE NONCLUSTERED INDEX IX_Lastname 
ON dbo.Person(LastName)
INCLUDE(Title,FirstName,MiddleName) 

GO


SELECT BusinessEntityID, FirstName, LastName, MiddleName, Title FROM dbo.Person
WHERE FirstName='Ken' OR LastName = 'Myer' 
--0.0179867
