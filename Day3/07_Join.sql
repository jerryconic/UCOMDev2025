USE tempdb;

DROP TABLE IF EXISTS dbo.Data1;
CREATE TABLE dbo.Data1
(
id int CONSTRAINT PK_Data1 PRIMARY KEY IDENTITY(1, 1),
c1 nvarchar(20),
c2 nvarchar(20)
);

DROP TABLE IF EXISTS dbo.Data2;
CREATE TABLE dbo.Data2
(
id int CONSTRAINT PK_Data2 PRIMARY KEY IDENTITY(1, 1),
c1 nvarchar(20),
c2 nvarchar(20)
);
GO

SELECT * FROM dbo.Data1 d1
INNER JOIN dbo.Data2 d2
	ON d1.id = d2.id;
GO

SELECT * FROM dbo.Data1 d1
INNER JOIN dbo.Data2 d2
	ON d1.c1 = d2.c1;
GO
SET NOCOUNT ON;
DECLARE @n int = 1
WHILE @n <= 10000
BEGIN
    INSERT INTO dbo.Data1(c1, c2)
    VALUES(CONCAT('a', @n), CONCAT('b', @n));
    SET @n = @n + 1;
END;
SET @n = 1
WHILE @n <= 10000
BEGIN
    INSERT INTO dbo.Data2(c1, c2)
    VALUES(CONCAT('a', @n), CONCAT('b', @n));
    SET @n = @N + 1;
END
GO

SELECT * FROM dbo.Data1 d1
INNER JOIN dbo.Data2 d2
	ON d1.id = d2.id;
GO

SELECT * FROM dbo.Data1 d1
INNER JOIN dbo.Data2 d2
	ON d1.c1 = d2.c1;
GO

SELECT * FROM dbo.Data1 d1
INNER JOIN dbo.Data2 d2
	ON d1.c1 = d2.c1
OPTION(MERGE JOIN);
GO

SELECT * FROM dbo.Data1 d1
INNER JOIN dbo.Data2 d2
	ON d1.id = d2.id
GO
SELECT * FROM dbo.Data1 d1
INNER JOIN dbo.Data2 d2
	ON d1.id = d2.id
OPTION(HASH JOIN)
GO

CREATE UNIQUE NONCLUSTERED INDEX IX_c1 ON dbo.Data1(c1) INCLUDE(c2) 
CREATE UNIQUE NONCLUSTERED INDEX IX_c1 ON dbo.Data2(c1) INCLUDE(c2) 


SELECT d1.id, d1.c1, d2.id, d2.c1 FROM dbo.Data1 d1
INNER JOIN dbo.Data2 d2
	ON d1.c1 = d2.c1;
GO

CREATE UNIQUE NONCLUSTERED INDEX IX_c1 ON dbo.Data1(c1) INCLUDE(c2) WITH(DROP_EXISTING=ON)
CREATE UNIQUE NONCLUSTERED INDEX IX_c1 ON dbo.Data2(c1) INCLUDE(c2) WITH(DROP_EXISTING=ON)

SELECT * FROM dbo.Data1 d1
INNER JOIN dbo.Data2 d2
	ON d1.c1 = d2.c1;

SELECT * FROM dbo.Data1
CROSS JOIN dbo.Data2;

USE AdventureWorks2019;

SELECT * FROM Person.Person p1
CROSS JOIN Person.Person p2;

SET SHOWPLAN_XML ON;

SELECT * FROM Person.Person;

SET SHOWPLAN_XML OFF;
