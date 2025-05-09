USE Northwind;

DECLARE @n int = 1;

WHILE @n <= 10
BEGIN
	PRINT @n;
	SET @n = @n + 1;
END;
GO

/* int a, b, c; */
/* DECLARE @a, @b, @c int; --X */
/* DECLARE @a int, @b int, @c int; --O */

DECLARE @d date, @d1 date, @d2 date;
DECLARE @tbl AS TABLE(dt date);
SET @d1 = DATEFROMPARTS(1997, 1, 1);
SET @d2 = EOMONTH(@d1);
SET @d = @d1;
SET NOCOUNT ON;
WHILE @d <= @d2
BEGIN
	INSERT INTO @tbl(dt) VALUES(@d);
	SET @d = DATEADD(DAY, 1, @d);
END;
SELECT * FROM @tbl;
GO


SELECT o.OrderDate, SUM(od.Quantity*od.UnitPrice) AS Total
FROM dbo.Orders o
INNER JOIN dbo.[Order Details] od
	ON o.OrderID = od.OrderID
WHERE o.OrderDate BETWEEN '1997-1-1' AND '1997-1-31'
GROUP BY o.OrderDate
ORDER BY o.OrderDate;

GO

CREATE PROC dbo.DailyReport
@yr int, @mn int
AS
SET NOCOUNT ON;
DECLARE @d date, @d1 date, @d2 date;
DECLARE @tbl AS TABLE(dt date);
SET @d1 = DATEFROMPARTS(@yr, @mn, 1);
SET @d2 = EOMONTH(@d1);
SET @d = @d1;
WHILE @d <= @d2
BEGIN
	INSERT INTO @tbl(dt) VALUES(@d);
	SET @d = DATEADD(DAY, 1, @d);
END;
WITH Ord
AS
(
SELECT o.OrderDate, SUM(od.Quantity*od.UnitPrice) AS Total
FROM dbo.Orders o
INNER JOIN dbo.[Order Details] od
	ON o.OrderID = od.OrderID
WHERE o.OrderDate BETWEEN @d1 AND @d2
GROUP BY o.OrderDate
)
SELECT t.dt, ISNULL(o.Total, 0) AS Total
FROm @tbl t
LEFT JOIN Ord o ON t.dt = o.OrderDate
ORDER BY t.dt;
GO

EXEC dbo.DailyReport @yr=1997, @mn=1;
EXEC dbo.DailyReport @yr=1997, @mn=2;