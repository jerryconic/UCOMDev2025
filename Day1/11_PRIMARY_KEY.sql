USE master;
IF EXISTS(SELECT * FROM sys.databases WHERE name = 'db01')
BEGIN
	ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE db01;
END



CREATE DATABASE db01;
GO

USE db01;

CREATE TABLE dbo.PK01
(
id int PRIMARY KEY,
data nvarchar(20)
);



CREATE TABLE dbo.PK02
(
id int CONSTRAINT PK_PK02 PRIMARY KEY,
data nvarchar(20)
);

CREATE TABLE dbo.PK03
(
id int,
data nvarchar(20),
PRIMARY KEY(id)
);

CREATE TABLE dbo.PK04
(
id int,
data nvarchar(20),
CONSTRAINT PK_PK04 PRIMARY KEY(id)
);


CREATE TABLE dbo.PK05
(
id int NOT NULL,
data nvarchar(20)
);

ALTER TABLE dbo.PK05
ADD CONSTRAINT PK_PK05 PRIMARY KEY(id);
GO

SELECT * FROM sys.key_constraints

SELECT object_id('PK_PK05')
SELECT object_name(1045578763);

SELECT schema_name(1);
SELECT schema_id('dbo');

SELECT * FROM sys.objects;

SELECT SCHEMA_NAME(o.schema_id) +'.' + o.name AS table_name,
k.*
FROM sys.key_constraints k
INNER JOIN sys.objects o
	ON k.parent_object_id = o.object_id

EXEC sp_help 'dbo.PK01';
EXEC sp_help 'dbo.PK02';
EXEC sp_help 'dbo.PK03';
EXEC sp_help 'dbo.PK04';
EXEC sp_help 'dbo.PK05';