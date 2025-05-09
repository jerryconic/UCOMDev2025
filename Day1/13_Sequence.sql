USE [db01]

GO

CREATE SEQUENCE [dbo].[Seq01] 
 AS [smallint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -5
 MAXVALUE 10
 CYCLE 

GO

SELECT NEXT VALUE FOR dbo.Seq01;

GO

CREATE TABLE dbo.AutoNumber2
(
id int IDENTITY(1, 1) PRIMARY KEY,
data nvarchar(20),
auto_no smallint DEFAULT NEXT VALUE FOR dbo.Seq01
)
GO

ALTER SEQUENCE dbo.Seq01 RESTART;
GO

INSERT INTO dbo.AutoNumber2(data)
VALUES('AAA'), ('BBB'), ('CCC'), ('DDD');
GO 10

SELECT * FROM dbo.AutoNumber2;