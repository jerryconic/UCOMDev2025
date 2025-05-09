USE Northwind;

SELECT e.EmployeeID, e.FirstName, 
MONTH(o.OrderDate) AS mn, 
SUM(od.Quantity*od.UnitPrice) AS Total
FROM dbo.Employees e
INNER JOIN dbo.Orders o	
	ON e.EmployeeID = o.EmployeeID
INNER JOIN dbo.[Order Details] od
	ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY e.EmployeeID, e.FirstName, MONTH(o.OrderDate)
ORDER BY e.EmployeeID, mn;


WITH EmpTotal
AS
(
SELECT e.EmployeeID, e.FirstName, 
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
SELECT EmployeeID, FirstName, --mn, Total,
CASE mn WHEN 1 THEN Total END AS [1],
CASE mn WHEN 2 THEN Total END AS [2],
CASE mn WHEN 3 THEN Total END AS [3]
FROM EmpTotal
ORDER BY EmployeeID, mn;


WITH EmpTotal
AS
(
SELECT e.EmployeeID, e.FirstName, 
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
SELECT EmployeeID, FirstName,-- mn, Total,

SUM(CASE mn WHEN 1 THEN Total END) AS [1],
SUM(CASE mn WHEN 2 THEN Total END) AS [2],
SUM(CASE mn WHEN 3 THEN Total END) AS [3],
SUM(CASE mn WHEN 4 THEN Total END) AS [4],
SUM(CASE mn WHEN 5 THEN Total END) AS [5],
SUM(CASE mn WHEN 6 THEN Total END) AS [6],
SUM(CASE mn WHEN 7 THEN Total END) AS [7],
SUM(CASE mn WHEN 8 THEN Total END) AS [8],
SUM(CASE mn WHEN 9 THEN Total END) AS [9],
SUM(CASE mn WHEN 10 THEN Total END) AS [10],
SUM(CASE mn WHEN 11 THEN Total END) AS [11],
SUM(CASE mn WHEN 12 THEN Total END) AS [12]
FROM EmpTotal
GROUP BY EmployeeID, FirstName;


WITH EmpTotal
AS
(
SELECT e.EmployeeID, e.FirstName, 
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
PIVOT(SUM(Total)
FOR mn IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) a;
--------------------------

WITH EmpTotal
AS
(
SELECT e.EmployeeID, e.FirstName, 
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
SELECT a.EmployeeID, a.FirstName,
ISNULL(a.[1] , 0) + ISNULL(a.[2] , 0) + ISNULL(a.[3] , 0) AS Q1,
ISNULL(a.[4] , 0) + ISNULL(a.[5] , 0) + ISNULL(a.[6] , 0) AS Q2,
ISNULL(a.[7] , 0) + ISNULL(a.[8] , 0) + ISNULL(a.[9] , 0) AS Q3,
ISNULL(a.[10] , 0) + ISNULL(a.[11] , 0) + ISNULL(a.[12] , 0) AS Q4
FROM EmpTotal
PIVOT(SUM(Total)
FOR mn IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) a;



WITH EmpTotal
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
/*
SELECT CONCAT(FirstName, ',') FROM dbo.Employees
(Nancy,Andrew,Janet,Margaret,Steven,Michael,Robert,Laura,Anne)
*/


WITH EmpTotal
AS
(
SELECT e.EmployeeID, e.FirstName, 
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
SELECT * 
INTO #tmp
FROM EmpTotal
PIVOT(SUM(Total)
FOR mn IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) a;


SELECT * FROM #tmp;

SELECT * FROM #tmp
UNPIVOT(Total
FOR mn IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) a;