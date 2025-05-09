EXEC sp_who

USE master;
IF EXISTS(SELECT * FROM sys.databases WHERE name = 'db01')
BEGIN
	ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE db01;
END
GO

CREATE DATABASE [db01]
GO
USE db01;
GO

CREATE TABLE dbo.Prdt
(
prdt_id int PRIMARY KEY,
prdt_name nvarchar(50),
unitprice decimal(10, 2),
cat_id int
);

CREATE TABLE dbo.Cat
(
cat_id int PRIMARY KEY,
cat_name nvarchar(50)
);

GO

INSERT INTO dbo.Cat(cat_id, cat_name)
SELECT CategoryID, CategoryName FROM Northwind.dbo.Categories;

INSERT INTO dbo.Prdt(prdt_id, prdt_name, unitprice, cat_id)
SELECT ProductID, ProductName, UnitPrice, CategoryID FROM Northwind.dbo.Products

GO
SELECT * FROM dbo.Cat;
SELECT * FROM dbo.Prdt;
GO
-----------------------------------------------------------------------------------
CREATE VIEW dbo.CatTotal
AS
SELECT c.cat_id, c.cat_name, SUM(p.unitprice) AS total
FROM dbo.Cat c
INNER JOIN dbo.Prdt p
	ON c.cat_id = p.cat_id
GROUP BY c.cat_id, c.cat_name
GO

SELECT * FROM dbo.CatTotal;
GO

SELECT * FROM dbo.CatTotal
WHERE total < 200;
GO

DELETE FROM dbo.CatTotal
WHERE total < 200;
--Error
----------------------------------------------------------
GO
CREATE OR ALTER TRIGGER trgCatTotal
ON dbo.CatTotal
INSTEAD OF DELETE
AS
SET NOCOUNT ON;
DELETE FROM dbo.Prdt WHERE cat_id IN
(SELECT cat_id FROM deleted);
DELETE FROM dbo.Cat WHERE cat_id IN
(SELECT cat_id FROM deleted);

GO

SELECT * FROM dbo.CatTotal
SELECT * FROM dbo.Prdt;
SELECT * FROM dbo.Cat;

DELETE FROM dbo.CatTotal
WHERE total < 200;

SELECT * FROM dbo.CatTotal

SELECT * FROM dbo.Prdt ORDER BY cat_id;
SELECT * FROM dbo.Cat;

GO

