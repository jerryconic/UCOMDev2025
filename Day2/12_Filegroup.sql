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
( NAME = N'db01', FILENAME = N'C:\SQLData\db01.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB ), 
 FILEGROUP [YR_2006] 
( NAME = N'db01_2006', FILENAME = N'C:\SQLData\db01_2006.ndf' , SIZE = 8192KB , FILEGROWTH = 4096KB ), 
 FILEGROUP [YR_2007] 
( NAME = N'db01_2007', FILENAME = N'C:\SQLData\db01_2007.ndf' , SIZE = 8192KB , FILEGROWTH = 4096KB ), 
 FILEGROUP [YR_2008] 
( NAME = N'db01_2008', FILENAME = N'C:\SQLData\db01_2008.ndf' , SIZE = 8192KB , FILEGROWTH = 4096KB ), 
 FILEGROUP [YR_BEFORE] 
( NAME = N'db01_before', FILENAME = N'C:\SQLData\db01_before.ndf' , SIZE = 8192KB , FILEGROWTH = 4096KB )
 LOG ON 
( NAME = N'db01_log', FILENAME = N'C:\SQLData\db01_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )

GO
USE db01;

CREATE TABLE dbo.OrdBefore
(
id int IDENTITY(1, 1) PRIMARY KEY,
big_data nchar(4000)
) ON YR_BEFORE;

CREATE TABLE dbo.Ord2006
(
id int IDENTITY(1, 1) PRIMARY KEY,
big_data nchar(4000)
) ON YR_2006;

CREATE TABLE dbo.Ord2007
(
id int IDENTITY(1, 1) PRIMARY KEY,
big_data nchar(4000)
) ON YR_2007;


CREATE TABLE dbo.Ord2008
(
id int IDENTITY(1, 1) PRIMARY KEY,
big_data nchar(4000)
) ON YR_2008;
GO
--------------------------------------------------
INSERT INTO dbo.OrdBefore DEFAULT VALUES;
GO 4096

INSERT INTO dbo.Ord2006 DEFAULT VALUES;
GO 8192


INSERT INTO dbo.Ord2008 DEFAULT VALUES;
GO 2048
