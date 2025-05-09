USE Northwind;

--1997/1�C����u�̫�T�i�q��

--1997/1�Y����u(EmployeeID=1)�̫�T�i�q��
SELECT TOP(3)
OrderID, OrderDate, CustomerID, EmployeeID
FROM dbo.Orders
WHERE EmployeeID = 1 AND YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 1
ORDER BY OrderID DESC;

--�]�b�l�d��, �M�Φb�C����u
SELECT e.EmployeeID, e.FirstName,
o.OrderID, o.OrderDate, o.CustomerID
FROM dbo.Employees e
CROSS APPLY
(
SELECT TOP(3)
OrderID, OrderDate, CustomerID, EmployeeID
FROM dbo.Orders
WHERE EmployeeID = e.EmployeeID AND YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 1
ORDER BY OrderID DESC
) o;

SELECT e.EmployeeID, e.FirstName,
o.OrderID, o.OrderDate, o.CustomerID
FROM dbo.Employees e
OUTER APPLY
(
SELECT TOP(3)
OrderID, OrderDate, CustomerID, EmployeeID
FROM dbo.Orders
WHERE EmployeeID = e.EmployeeID AND YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 1
ORDER BY OrderID DESC
) o;


SELECT e.EmployeeID, e.FirstName,
o.OrderID, o.OrderDate, o.CustomerID
FROM dbo.Employees e
CROSS APPLY
dbo.Top3Order(1997, 1, e.EmployeeID) o;


SELECT e.EmployeeID, e.FirstName,
o.OrderID, o.OrderDate, o.CustomerID
FROM dbo.Employees e
OUTER APPLY
dbo.Top3Order(1997, 1, e.EmployeeID) o

