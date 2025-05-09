USE Northwind;

GO


CREATE OR ALTER FUNCTION dbo.Top3Order
(@yr int, @mn int, @eid int)
RETURNS TABLE AS RETURN
(
	SELECT TOP(3)
	OrderID, OrderDate, EmployeeID, CustomerID
	FROM dbo.Orders
	WHERE YEAR(OrderDate) = @yr AND MONTH(OrderDate) = @mn AND EmployeeID = @eid
	ORDER BY OrderID DESC
)
GO

SELECT * FROM dbo.Top3Order(1997, 1, 1);

SELECT * FROM dbo.Top3Order(1997, 1, 2);

SELECT o.*, c.CompanyName FROM dbo.Top3Order(1997, 1, 1) o 
LEFT JOIN dbo.Customers c
	ON o.CustomerID = c.CustomerID;
