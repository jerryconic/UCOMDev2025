USE master;
IF EXISTS(SELECT * FROM sys.databases WHERE name = 'db01')
BEGIN
	ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE db01;
END
GO

CREATE DATABASE db01
GO

USE db01;

CREATE TABLE dbo.Product
(
prdt_id int PRIMARY KEY,
prdt_name nvarchar(50),
price decimal(5, 2)
);


INSERT INTO dbo.Product(prdt_id, prdt_name, price)
SELECT ProductID, ProductName, UnitPrice
FROM Northwind.dbo.Products
GO

CREATE VIEW dbo.LowPriceProduct
AS
SELECT * FROM dbo.Product 
WHERE price < 10;
GO

SELECT * FROM dbo.Product;
SELECT * FROM dbo.LowPriceProduct
GO

----------------------------------------------------------
INSERT INTO dbo.LowPriceProduct(prdt_id, prdt_name, price)
VALUES(101, 'xxxx' , 999);

SELECT * FROM dbo.Product;
SELECT * FROM dbo.LowPriceProduct

UPDATE dbo.LowPriceProduct
SET price = 999
WHERE prdt_id = 13

SELECT * FROM dbo.Product;
SELECT * FROM dbo.LowPriceProduct

DELETE FROM dbo.LowPriceProduct WHERE prdt_id = 19;

SELECT * FROM dbo.Product;
SELECT * FROM dbo.LowPriceProduct;

GO


ALTER VIEW dbo.LowPriceProduct
AS
SELECT * FROM dbo.Product 
WHERE price < 10
WITH CHECK OPTION
GO

SELECT * FROM dbo.LowPriceProduct

INSERT INTO dbo.LowPriceProduct(prdt_id, prdt_name, price)
VALUES(888, 'zzz', 999);

INSERT INTO dbo.LowPriceProduct(prdt_id, prdt_name, price)
VALUES(888, 'zzz', 9);

SELECT * FROM dbo.LowPriceProduct
SELECT * FROM dbo.Product;

UPDATE dbo.LowPriceProduct
SET price = 999
WHERE prdt_id = 23;


UPDATE dbo.LowPriceProduct
SET price = 5
WHERE prdt_id = 23;

SELECT * FROM dbo.LowPriceProduct
SELECT * FROM dbo.Product;

