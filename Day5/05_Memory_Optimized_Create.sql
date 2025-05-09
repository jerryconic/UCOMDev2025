
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
ALTER DATABASE [db01] ADD FILEGROUP [mod] CONTAINS MEMORY_OPTIMIZED_DATA 
ALTER DATABASE [db01] ADD FILE ( NAME = N'db01_mod', FILENAME = N'C:\SQLData\db01_mod' ) TO FILEGROUP [mod]
GO
CREATE TABLE dbo.MemTest
(
	emp_id int,
	emp_name nvarchar(20)

   CONSTRAINT PK_MemTest PRIMARY KEY NONCLUSTERED (emp_id),
   -- See SQL Server Books Online for guidelines on determining appropriate bucket count for the index
   INDEX hash_emp_id HASH (emp_id) WITH (BUCKET_COUNT = 100000)
) WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA)
GO

ALTER TABLE dbo.MemTest
	ADD INDEX ix_emp_name NONCLUSTERED (emp_name)
GO

ALTER TABLE dbo.MemTest
	ADD INDEX hash_emp_name HASH (emp_name) WITH (BUCKET_COUNT = 100000)
