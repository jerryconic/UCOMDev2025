USE master;

IF EXISTS(SELECT * FROM sys.databases WHERE name = 'db01')
BEGIN
	ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE db01;
END
GO
CREATE DATABASE db01;
GO
USE db01;

CREATE TABLE dbo.Employee
(
emp_id int PRIMARY KEY,
emp_name nvarchar(20)
);

GO
CREATE TRIGGER dbo.trg_Employee 
   ON  dbo.Employee
   AFTER INSERT,DELETE,UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM inserted;
	SELECT * FROM deleted;
END
GO

INSERT INTO dbo.Employee(emp_id, emp_name)
VALUES(1, 'John'), (2, 'Peter'), (3, 'Linda'), (4, 'Alice');

UPDATE dbo.Employee
SET emp_name = 'Nick'
WHERE emp_id = 3;

DELETE FROM dbo.Employee;
TRUNCATE TABLE dbo.Employee;

EXEC sp_helptext 'dbo.trg_Employee'
EXEC sp_help 'dbo.trg_Employee';


SELECT SCHEMA_NAME(o.schema_id) + '.' + o.name AS table_name, 
SCHEMA_NAME(o.schema_id) + '.' + t.name AS trigger_name, t.* FROM sys.triggers t
INNER JOIN sys.objects o
	ON t.parent_id = o.object_id

SELECT * FROM sys.server_triggers

USE AdventureWorks2019;
SELECT SCHEMA_NAME(o.schema_id) + '.' + o.name AS table_name, 
SCHEMA_NAME(o.schema_id) + '.' + t.name AS trigger_name, t.* FROM sys.triggers t
INNER JOIN sys.objects o
	ON t.parent_id = o.object_id

SELECT CONCAT('EXEC sp_helptext ''', 
SCHEMA_NAME(o.schema_id) + '.' + t.name ,'''') FROM sys.triggers t
INNER JOIN sys.objects o
	ON t.parent_id = o.object_id;

EXEC sp_helptext 'HumanResources.dEmployee'
EXEC sp_helptext 'Person.iuPerson'
EXEC sp_helptext 'Purchasing.iPurchaseOrderDetail'
EXEC sp_helptext 'Purchasing.uPurchaseOrderDetail'
EXEC sp_helptext 'Purchasing.uPurchaseOrderHeader'
EXEC sp_helptext 'Sales.iduSalesOrderDetail'
EXEC sp_helptext 'Sales.uSalesOrderHeader'
EXEC sp_helptext 'Purchasing.dVendor'
EXEC sp_helptext 'Production.iWorkOrder'
EXEC sp_helptext 'Production.uWorkOrder'

USE db01;


DISABLE TRIGGER dbo.trg_Employee ON dbo.Employee;
--ENABLE TRIGGER dbo.trg_Employee ON dbo.Employee;

--log history
DROP TABLE IF EXISTS dbo.EmployeeHistory

CREATE TABLE dbo.EmployeeHistory(
emp_id int,
emp_name nvarchar(20),
add_time datetime DEFAULT GETDATE()
);
GO

CREATE TRIGGER dbo.trg_LogHistory
   ON  dbo.Employee
   AFTER DELETE,UPDATE
AS 
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.EmployeeHistory(emp_id, emp_name)
	SELECT emp_id, emp_name FROM deleted;

END
GO


INSERT INTO dbo.Employee(emp_id, emp_name)
VALUES(1, 'John'), (2, 'Peter'), (3, 'Linda'), (4, 'Alice');

SELECT * FROM dbo.Employee;
SELECT * FROM dbo.EmployeeHistory;

UPDATE dbo.Employee
SET emp_name = 'Nick'
WHERE emp_id = 3;


SELECT * FROM dbo.Employee;
SELECT * FROM dbo.EmployeeHistory;


DELETE FROM dbo.Employee;

SELECT * FROM dbo.Employee;
SELECT * FROM dbo.EmployeeHistory;

--prohibit admin

DISABLE TRIGGER dbo.trg_LogHistory ON dbo.Employee;

GO

CREATE OR ALTER TRIGGER dbo.trg_ProhibitAdmin 
   ON  dbo.Employee
   AFTER INSERT, UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	IF EXISTS(SELECT * FROM inserted
		WHERE emp_name LIKE '%admin%')
		THROW 50000, 'Cannot insert ''admin'' in emp_name', 1;

END
GO


INSERT INTO dbo.Employee(emp_id, emp_name)
VALUES(1, 'John'), (2, 'Peter'), (3, 'Linda'), (4, 'Alice');

UPDATE dbo.Employee
SET emp_name = 'Nick'
WHERE emp_id = 3;

INSERT INTO dbo.Employee(emp_id, emp_name)
VALUES(5, 'admin');


INSERT INTO dbo.Employee(emp_id, emp_name)
VALUES(5, 'xxx'), (6, 'yyy'), (7, 'admin');

UPDATE dbo.Employee
SET emp_name = 'admin'
WHERE emp_id = 3;

SELECT * FROM dbo.Employee;

DISABLE TRIGGER dbo.trg_ProhibitAdmin ON dbo.Employee;

TRUNCATE TABLE dbo.Employee;
INSERT INTO dbo.Employee(emp_id, emp_name)
VALUES(1, 'John'), (2, 'Peter'), (3, 'Linda'), (4, 'Alice');

GO
CREATE TRIGGER dbo.trg_EmployeeInsteadOf
   ON  dbo.Employee
   INSTEAD OF INSERT,DELETE,UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM inserted;
	SELECT * FROM deleted;
END
GO

SELECT * FROM dbo.Employee;

INSERT INTO dbo.Employee(emp_id, emp_name)
VALUES(5, 'XXX'), (6, 'YYY'), (7, 'ZZZ');

SELECT * FROM dbo.Employee;

UPDATE dbo.Employee
SET emp_name = 'xxx';

SELECT * FROM dbo.Employee;

DELETE FROM dbo.Employee;

SELECT * FROM dbo.Employee;