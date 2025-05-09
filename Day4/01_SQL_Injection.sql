USE Northwind;

GO

DECLARE @sql nvarchar(100);
SET @sql = N'SELECT * FROM dbo.Employees';
EXECUTE(@sql);
GO

DECLARE @sql nvarchar(1000);
DECLARE @name nvarchar(100);

--SET @name = N'Nancy';
--SET @name = N'xxx'' OR 1=1;--';
--SET @name = N'xxx'';SELECT * FROM dbo.Products;--';
SET @name = N'xxx'';UPDATE dbo.Products SET UnitPrice=0 WHERE ProductID=1;--';

SET @sql = N'SELECT * FROM dbo.Employees
			 WHERE FirstName=N''' + @name + '''';
EXECUTE(@sql);
PRINT @sql;
GO

SELECT * FROM dbo.Products


DECLARE @sql nvarchar(1000);
DECLARE @name nvarchar(100);

SET @name = N'Nancy';
--SET @name = N'xxx'' OR 1=1;--';
--SET @name = N'xxx'';SELECT * FROM dbo.Products;--';

SET @sql = N'SELECT * FROM dbo.Employees
			 WHERE FirstName=@FirstName';

EXEC sp_executesql @statement=@sql,
				   @params=N'@FirstName nvarchar(100)',
				   @FirstName=@name;
GO
SELECT * FROM dbo.Products

UPDATE dbo.Products SET UnitPrice=18 WHERE ProductID=1

/*
--C# Input:
Nancy
xxx' OR 1=1;--
xxx';UPDATE dbo.Products SET UnitPrice=0 WHERE ProductID=1;--

*/