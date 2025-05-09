USE Northwind;

SELECT OrderID, OrderDate, 
ROW_NUMBER() OVER (ORDER BY OrderID) AS rno
FROM dbo.Orders;

WITH Ord
AS
(
SELECT OrderID, OrderDate, 
ROW_NUMBER() OVER (ORDER BY OrderID) AS rno
FROM dbo.Orders
)
SELECT * FROM Ord 
WHERE rno BETWEEN 81 AND 100;

SELECT ProductID, CategoryID, ProductName, UnitPrice,
ROW_NUMBER() OVER (ORDER BY UnitPrice DESC) AS rno,
RANK() OVER (ORDER BY UnitPrice DESC) AS rnk,
DENSE_RANK() OVER (ORDER BY UnitPrice DESC) AS d_rnk
FROM dbo.Products;


SELECT ProductID, CategoryID, ProductName, UnitPrice,
RANK() OVER (PARTITION BY CategoryID ORDER BY UnitPrice DESC) AS rnk
FROM dbo.Products;


SELECT ProductID, CategoryID, ProductName, UnitPrice,
NTILE(5) OVER (ORDER BY UnitPrice DESC) AS PriceType
FROM dbo.Products

-------------------------------------------------------------------------

SELECT CategoryID, ProductID, ProductName, UnitPrice,
SUM(UnitPrice) OVER (ORDER BY ProductID) AS RunningTotal
FROM dbo.Products;

SELECT CategoryID, ProductID, ProductName, UnitPrice,
(
	SELECT SUM(UnitPrice) FROM dbo.Products
	WHERE ProductID <= p.ProductID
) AS RunningTotal
FROM dbo.Products p

SELECT CategoryID, ProductID, ProductName, UnitPrice,
SUM(UnitPrice) OVER (ORDER BY UnitPrice) AS RunningTotal
FROM dbo.Products


SELECT CategoryID, ProductID, ProductName, UnitPrice,
SUM(UnitPrice) OVER (ORDER BY UnitPrice
	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM dbo.Products

SELECT CategoryID, ProductID, ProductName, UnitPrice,
AVG(UnitPrice) OVER (ORDER BY UnitPrice
	ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
FROM dbo.Products

SELECT CategoryID, ProductID, ProductName, UnitPrice,
SUM(UnitPrice) OVER () AS Total_All,
SUM(UnitPrice) OVER (Partition BY CategoryID) AS Total_Category,
SUM(UnitPrice) OVER (Partition BY CategoryID ORDER BY ProductID) AS Running_Total
FROM dbo.Products


SELECT CategoryID, ProductID, ProductName, UnitPrice,
SUM(UnitPrice) OVER (Partition BY CategoryID) AS Total_Category,
UnitPrice * 100 / SUM(UnitPrice) OVER (Partition BY CategoryID) AS [%]
FROM dbo.Products
ORDER BY CategoryID, UnitPrice DESC;



------------------------
--SQL 2022 Window Clause
------------------------

WITH OrderValues AS
(
    SELECT o.OrderID, o.CustomerID, o.OrderDate, od.Quantity, od.Quantity * od.UnitPrice AS Total
    FROM dbo.Orders o
    INNER JOIN dbo.[Order Details] od
        ON o.OrderID = od.OrderID
)
SELECT OrderID, CustomerID, OrderDate, Quantity, Total,
  SUM(Quantity) OVER( PARTITION BY CustomerID
                 ORDER BY OrderDate, OrderID
                 ROWS UNBOUNDED PRECEDING ) AS RunsQuantity,
  SUM(Total) OVER( PARTITION BY CustomerID
                 ORDER BY OrderDate, OrderID
                 ROWS UNBOUNDED PRECEDING ) AS RunsTotal
FROM OrderValues
WHERE CustomerID IN('ALFKI', 'ANATR')
ORDER BY CustomerID, OrderDate, OrderID;

--Window Clause
WITH OrderValues AS
(
    SELECT o.OrderID, o.CustomerID, o.OrderDate, od.Quantity, od.Quantity * od.UnitPrice AS Total
    FROM dbo.Orders o
    INNER JOIN dbo.[Order Details] od
        ON o.OrderID = od.OrderID
)
SELECT OrderID, CustomerID, OrderDate, Quantity, Total,
  SUM(Quantity) OVER W AS RunsQuantity,
  SUM(Total) OVER W AS RunsTotal
FROM OrderValues
WHERE CustomerID IN('ALFKI', 'ANATR')
WINDOW W AS 
( PARTITION BY CustomerID
  ORDER BY OrderDate, OrderID
  ROWS UNBOUNDED PRECEDING 
)
ORDER BY CustomerID, OrderDate, OrderID;

----------------------------------------------------

WITH OrderValues AS
(
    SELECT o.OrderID, o.CustomerID, o.OrderDate, od.Quantity, od.Quantity * od.UnitPrice AS Total
    FROM dbo.Orders o
    INNER JOIN dbo.[Order Details] od
        ON o.OrderID = od.OrderID
)
SELECT OrderID, CustomerID, OrderDate, Quantity, Total,
  ROW_NUMBER() OVER( PARTITION BY CustomerID
                     ORDER BY OrderDate, OrderID ) AS OrderNo,
  MAX(OrderDate) OVER( PARTITION BY CustomerID ) AS MaxOrderDate,
  SUM(Quantity) OVER( PARTITION BY CustomerID
                 ORDER BY OrderDate, OrderID
                 ROWS UNBOUNDED PRECEDING ) AS RunQuantity,
  SUM(Total) OVER( PARTITION BY CustomerID           
                 ORDER BY orderdate, orderid   
                 ROWS UNBOUNDED PRECEDING ) AS RunTotal
FROM OrderValues
WHERE CustomerID IN('ALFKI', 'ANATR')
ORDER BY CustomerID, OrderDate, OrderID;

--Window Clause
WITH OrderValues AS
(
    SELECT o.OrderID, o.CustomerID, o.OrderDate, od.Quantity, od.Quantity * od.UnitPrice AS Total
    FROM dbo.Orders o
    INNER JOIN dbo.[Order Details] od
        ON o.OrderID = od.OrderID
)
SELECT OrderID, CustomerID, OrderDate, Quantity, Total,
  ROW_NUMBER() OVER PO AS PO_OrderNo,
  MAX(OrderDate) OVER P AS P_MaxOrderDate,
  SUM(Quantity) OVER POF AS POF_RunQuantity,
  SUM(Total) OVER POF AS POF_RunTotal
FROM OrderValues
WHERE CustomerID IN('ALFKI', 'ANATR')
WINDOW P AS (PARTITION BY CustomerID),
PO AS (P Order BY OrderDate, OrderID),
POF AS (PO ROWS UNBOUNDED PRECEDING)
--WINDOW POF AS (PO ROWS UNBOUNDED PRECEDING),
--PO AS (P Order BY OrderDate, OrderID),
--P AS (PARTITION BY CustomerID)
ORDER BY CustomerID, OrderDate, OrderID;


WITH OrderValues AS
(
    SELECT o.OrderID, o.CustomerID, o.OrderDate, od.Quantity, od.Quantity * od.UnitPrice AS Total
    FROM dbo.Orders o
    INNER JOIN dbo.[Order Details] od
        ON o.OrderID = od.OrderID
)
SELECT OrderID, CustomerID, OrderDate, Quantity, Total,
  ROW_NUMBER() OVER (P ORDER BY CustomerID) AS PO_OrderNo,
  MAX(OrderDate) OVER P AS P_MaxOrderDate
FROM OrderValues
WHERE CustomerID IN('ALFKI', 'ANATR')
WINDOW P AS (PARTITION BY CustomerID)
ORDER BY CustomerID, OrderDate, OrderID;

SELECT 'This is valid'
WINDOW W1 AS (), W2 AS (W1), W3 AS (W2);

SELECT 'This is invalid'
WINDOW W1 AS (W2), W2 AS (W3), W3 AS (W1);


WITH OrderValues AS
(
    SELECT o.OrderID, o.CustomerID, o.OrderDate, od.Quantity, od.Quantity * od.UnitPrice AS Total
    FROM dbo.Orders o
    INNER JOIN dbo.[Order Details] od
        ON o.OrderID = od.OrderID
),
C AS
(
  SELECT OrderID, CustomerID, OrderDate, Quantity, Total,
    SUM(Quantity) OVER W AS RunSumQuantity
  FROM OrderValues
WHERE CustomerID IN('ALFKI', 'ANATR')
  WINDOW W AS ( PARTITION BY CustomerID
                ORDER BY OrderDate, OrderID
                ROWS UNBOUNDED PRECEDING )
)
SELECT *
    --,SUM(Quantity) OVER W AS RunSumQuantity97
FROM C
WHERE orderdate >= '1997-1-1';

WITH OrderValues AS
(
    SELECT o.OrderID, o.CustomerID, o.OrderDate, od.Quantity, od.Quantity * od.UnitPrice AS Total
    FROM dbo.Orders o
    INNER JOIN dbo.[Order Details] od
        ON o.OrderID = od.OrderID
),
C AS
(
  SELECT OrderID, CustomerID, OrderDate, Quantity, Total,
    SUM(Quantity) OVER W AS RunSumQuantity
  FROM OrderValues
WHERE CustomerID IN('ALFKI', 'ANATR')
  WINDOW W AS ( PARTITION BY CustomerID
                ORDER BY OrderDate, OrderID
                ROWS UNBOUNDED PRECEDING )
)
SELECT *
    ,SUM(Quantity) OVER W AS RunSumQuantity97
FROM C
WHERE orderdate >= '1997-1-1'
  WINDOW W AS ( PARTITION BY CustomerID
                ORDER BY OrderDate, OrderID
                ROWS UNBOUNDED PRECEDING );
--
SELECT GREATEST('6.62', 3.1415, N'7') AS GreatestVal;

SELECT LEAST('6.62', 3.1415, N'7') AS LeastVal;
GO
--SQL 2016
SELECT value FROM STRING_SPLIT('Lorem ipsum dolor sit amet.', ' ');
GO
--
DECLARE @d datetime2 = '2025-3-20 11:30:15.1234567';
SELECT 'Year', DATETRUNC(year, @d);
SELECT 'Quarter', DATETRUNC(quarter, @d);
SELECT 'Month', DATETRUNC(month, @d);
SELECT 'Week', DATETRUNC(week, @d); -- Using the default DATEFIRST setting value of 7 (U.S. English)
SELECT 'Iso_week', DATETRUNC(iso_week, @d);
SELECT 'DayOfYear', DATETRUNC(dayofyear, @d);
SELECT 'Day', DATETRUNC(day, @d);
SELECT 'Hour', DATETRUNC(hour, @d);
SELECT 'Minute', DATETRUNC(minute, @d);
SELECT 'Second', DATETRUNC(second, @d);
SELECT 'Millisecond', DATETRUNC(millisecond, @d);
SELECT 'Microsecond', DATETRUNC(microsecond, @d);

GO
DECLARE @d datetime2 = '2025-03-20 11:11:11.1234567';

SELECT 'Week-7', DATETRUNC(WEEK, @d); -- Uses the default DATEFIRST setting value of 7 (U.S. English)

SET DATEFIRST 6;
SELECT 'Week-6', DATETRUNC(WEEK, @d);

SET DATEFIRST 3;
SELECT 'Week-3', DATETRUNC(WEEK, @d);

GO
SELECT DATETRUNC(month, '2025-03-20');

SELECT DATETRUNC(millisecond, '2025-03-20 10:10:05.1234567');

DECLARE @d1 char(200) = '2025-03-20';
SELECT DATETRUNC(millisecond, @d1);

DECLARE @d2 nvarchar(max) = '2025-03-20 10:10:05';
SELECT DATETRUNC(minute, @d2);

----------------------------------

DROP TABLE IF EXISTS #SampleTempTable;
GO
CREATE TABLE #SampleTempTable (id INT, message nvarchar(50));
INSERT INTO #SampleTempTable VALUES (null, 'hello') ;
INSERT INTO #SampleTempTable VALUES (10, null);
INSERT INTO #SampleTempTable VALUES (17, 'abc');
INSERT INTO #SampleTempTable VALUES (17, 'yes');
INSERT INTO #SampleTempTable VALUES (null, null);
GO

SELECT * FROM #SampleTempTable WHERE id IS DISTINCT FROM 17;
DROP TABLE IF EXISTS #SampleTempTable;
GO
DROP TABLE IF EXISTS #SampleTempTable;
GO
CREATE TABLE #SampleTempTable (id INT, message nvarchar(50));
INSERT INTO #SampleTempTable VALUES (null, 'hello') ;
INSERT INTO #SampleTempTable VALUES (10, null);
INSERT INTO #SampleTempTable VALUES (17, 'abc');
INSERT INTO #SampleTempTable VALUES (17, 'yes');
INSERT INTO #SampleTempTable VALUES (null, null);
GO

SELECT * FROM #SampleTempTable WHERE id IS NOT DISTINCT FROM 17;
DROP TABLE IF EXISTS #SampleTempTable;
GO

DROP TABLE IF EXISTS #SampleTempTable;
GO
CREATE TABLE #SampleTempTable (id INT, message nvarchar(50));
INSERT INTO #SampleTempTable VALUES (null, 'hello') ;
INSERT INTO #SampleTempTable VALUES (10, null);
INSERT INTO #SampleTempTable VALUES (17, 'abc');
INSERT INTO #SampleTempTable VALUES (17, 'yes');
INSERT INTO #SampleTempTable VALUES (null, null);
GO

SELECT * FROM #SampleTempTable WHERE id IS DISTINCT FROM NULL;
DROP TABLE IF EXISTS #SampleTempTable;
GO

DROP TABLE IF EXISTS #SampleTempTable;
GO
CREATE TABLE #SampleTempTable (id INT, message nvarchar(50));
INSERT INTO #SampleTempTable VALUES (null, 'hello') ;
INSERT INTO #SampleTempTable VALUES (10, null);
INSERT INTO #SampleTempTable VALUES (17, 'abc');
INSERT INTO #SampleTempTable VALUES (17, 'yes');
INSERT INTO #SampleTempTable VALUES (null, null);
GO

SELECT * FROM #SampleTempTable WHERE id IS NOT DISTINCT FROM NULL;
DROP TABLE IF EXISTS #SampleTempTable;
GO
---------------------------------

USE db01;

DROP TABLE IF EXISTS dbo.T1;

CREATE TABLE dbo.T1
(
  id INT NOT NULL CONSTRAINT PK_T1 PRIMARY KEY,
  col1 INT NULL,
  col2 INT NULL
);
GO

INSERT INTO dbo.T1(id, col1, col2) VALUES
  ( 2, NULL,  200),
  ( 3,   10, NULL),
  ( 5,   -1, NULL),
  ( 7, NULL,  202),
  (11, NULL,  150),
  (13,  -12,   50),
  (17, NULL,  180),
  (19, NULL,  170),
  (23, 1759, NULL);

  WITH C AS
(
  SELECT id, col1,
    MAX(CASE WHEN col1 IS NOT NULL THEN id END)
    --MAX(id)
      OVER(ORDER BY id
           ROWS UNBOUNDED PRECEDING) AS grp
  FROM dbo.T1
)
SELECT id, col1,
  MAX(col1) OVER(PARTITION BY grp
                 ORDER BY id
                 ROWS UNBOUNDED PRECEDING) AS lastknowncol1
FROM C;
GO

SELECT id, col1,
  LAST_VALUE(col1) IGNORE NULLS OVER( ORDER BY id ROWS UNBOUNDED PRECEDING ) AS lastknowncol
FROM dbo.T1;

SELECT id, 
  col1, LAST_VALUE(col1) IGNORE NULLS OVER W AS lastknowncol1,
  col2, LAST_VALUE(col2) IGNORE NULLS OVER W AS lastknowncol2
FROM dbo.T1
WINDOW W AS ( ORDER BY id ROWS UNBOUNDED PRECEDING );

SELECT id, col1, 
  LAG(col1) IGNORE NULLS OVER ( ORDER BY id ) AS prevknowncol1
FROM dbo.T1;

SELECT id, col1, 
  LAG(col1) RESPECT NULLS OVER ( ORDER BY id ) AS prevknowncol1
FROM dbo.T1;