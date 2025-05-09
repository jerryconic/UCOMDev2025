USE master;
IF EXISTS(SELECT * FROM sys.databases WHERE name = 'db01')
BEGIN
	ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE db01;
END
GO

CREATE DATABASE [db01]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db01', FILENAME = N'C:\SQLData\db01.mdf' , SIZE = 8192KB , FILEGROWTH = 4096KB )
 LOG ON 
( NAME = N'db01_log', FILENAME = N'C:\SQLData\db01_log.ldf' , SIZE = 8192KB , FILEGROWTH = 4096KB )
GO

USE db01;

CREATE TABLE dbo.BigTable
(
id int IDENTITY(1, 1) PRIMARY KEY,
big_data nchar(4000)
);
GO
--Ctrl + Shift + R
INSERT INTO dbo.BigTable DEFAULT VALUES;
GO 4096

dbcc ind('db01', 'dbo.BigTable', -1);

dbcc traceon(3604)

dbcc page('db01', 1, 288, 3)

UPDATE dbo.BigTable SET big_data = '';

SET STATISTICS IO ON;
SELECT * FROM dbo.BigTable

USE [db01]
ALTER TABLE [dbo].[BigTable] REBUILD PARTITION = ALL
WITH(DATA_COMPRESSION = ROW) --NONE/ROW/PAGE

dbcc ind('db01', 'dbo.BigTable', -1);

dbcc page('db01', 1, 4600, 1);
SELECT * FROM dbo.BigTable

SELECT * FROM dbo.BigTable
WHERE id = 1000;

INSERT INTO dbo.BigTable DEFAULT VALUES;
GO 4096

dbcc shrinkdatabase('db01')

ALTER TABLE [dbo].[BigTable] REBUILD PARTITION = ALL
WITH(DATA_COMPRESSION = NONE) --NONE/ROW/PAGE
