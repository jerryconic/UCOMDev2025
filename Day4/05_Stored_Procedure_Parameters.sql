USE Northwind;

GO

CREATE PROC dbo.P4
AS
SELECT * FROM dbo.Orders;
GO

DECLARE @n int;
EXEC @n=dbo.P4;
SELECT @n AS ret_value; --0
GO


ALTER PROC dbo.P4
AS
SELECT * FROM dbo.Orders;
RETURN 100;
GO

DECLARE @n int;
EXEC @n=dbo.P4;
SELECT @n AS ret_value; --100
GO

CREATE PROC dbo.P5
@yr int, @mn int, @record_count int OUTPUT
AS
SELECT @record_count = COUNT(*)
FROM dbo.Orders
WHERE YEAR(OrderDate) = @yr AND MONTH(OrderDate) = @mn;
GO

DECLARE @n int;
  EXEC dbo.P5 @yr=1997,  @mn=1,  @record_count=@n OUTPUT;
--EXEC dbo.P5 @yr<=1997, @mn<=1, @record_count=>@n OUTPUT;
SELECT @n AS RecordCount;
GO

CREATE TABLE #tmp
(
id int IDENTITY(1, 1),
data nvarchar(20)
);

INSERT INTO #tmp(data) 
VALUES('aaa'), ('bbb'), ('ccc');

SELECT * FROM #tmp;
SELECT SCOPE_IDENTITY();

INSERT INTO #tmp(data) 
OUTPUT inserted.*
VALUES('aaa'), ('bbb'), ('ccc');

GO
-----------------------------------------------------------
SELECT * FROM dbo.Orders
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-1-5'

SELECT * FROM dbo.Orders
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-1-31'
GO

CREATE PROC dbo.P6
@d1 date, @d2 date
AS
SELECT * FROM dbo.Orders
WHERE OrderDate BETWEEN @d1 AND @d2
GO

EXEC dbo.P6 @d1 = '1997-1-1', @d2='1997-1-5';
EXEC dbo.P6 @d1 = '1997-1-1', @d2='1997-1-31';

EXEC dbo.P6 @d1 = '1997-1-1', @d2='1997-1-31' WITH RECOMPILE;
GO

ALTER PROC dbo.P6
@d1 date, @d2 date
WITH RECOMPILE
AS
SELECT * FROM dbo.Orders
WHERE OrderDate BETWEEN @d1 AND @d2
GO

EXEC dbo.P6 @d1 = '1997-1-1', @d2='1997-1-5';
EXEC dbo.P6 @d1 = '1997-1-1', @d2='1997-1-31';
GO

ALTER PROC dbo.P6
@d1 date, @d2 date
AS
SELECT * FROM dbo.Orders
WHERE OrderDate BETWEEN @d1 AND @d2
OPTION (OPTIMIZE FOR(@d1='1997-1-1', @d2='1997-1-31'))
GO

EXEC dbo.P6 @d1 = '1997-1-1', @d2='1997-1-5';
EXEC dbo.P6 @d1 = '1997-1-1', @d2='1997-1-31';
GO
