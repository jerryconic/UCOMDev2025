
USE db01;

DROP TABLE IF EXISTS dbo.Employee;
DROP TABLE IF EXISTS dbo.EmployeeHistory;

CREATE TABLE dbo.Employee
(
emp_id int PRIMARY KEY IDENTITY(1,1),
emp_name nvarchar(50),
address nvarchar(200),
phone nvarchar(100)
);



CREATE TABLE dbo.EmployeeHistory
(

new_emp_id int,
new_emp_name nvarchar(50),
new_address nvarchar(200),
new_phone nvarchar(100),
org_emp_id int,
org_emp_name nvarchar(50),
org_address nvarchar(200),
org_phone nvarchar(100),
add_time datetime DEFAULT GETDATE()
);


GO

CREATE OR ALTER TRIGGER trgEmployeeLog
ON dbo.Employee
AFTER INSERT, UPDATE, DELETE
AS
SET NOCOUNT ON
INSERT INTO dbo.EmployeeHistory(new_emp_id, new_emp_name, new_address, new_phone, 
	org_emp_id, org_emp_name, org_address, org_phone)
SELECT ins.emp_id, ins.emp_name, ins.address, ins.phone, 
del.emp_id, del.emp_name, del.address, del.phone
FROM inserted ins
FULL JOIN deleted del
	ON ins.emp_id = del.emp_id
GO
---------------------------------------------------
INSERT INTO dbo.Employee(emp_name, address, phone)
VALUES(N'AAA', N'Taipei', N'999-9999'), 
(N'BBB', N'Taipei', N'888-8888'),
(N'CCC', N'Kaoshong', N'777-7777');

SELECT * FROM dbo.EmployeeHistory
SELECT * FROM dbo.Employee

SELECT CASE WHEN new_emp_id IS NOT NULL AND org_emp_id IS NULL THEN 'INSERT' 
WHEN new_emp_id IS NOT NULL AND org_emp_id IS NOT NULL THEN 'UPDATE' 
WHEN new_emp_id IS NULL AND org_emp_id IS NOT NULL THEN 'DELETE' END,
* FROM dbo.EmployeeHistory
GO
UPDATE dbo.Employee
SET emp_name = N'XYZ'

SELECT * FROM dbo.Employee
SELECT CASE WHEN new_emp_id IS NOT NULL AND org_emp_id IS NULL THEN 'INSERT' 
WHEN new_emp_id IS NOT NULL AND org_emp_id IS NOT NULL THEN 'UPDATE' 
WHEN new_emp_id IS NULL AND org_emp_id IS NOT NULL THEN 'DELETE' END,
* FROM dbo.EmployeeHistory
ORDER BY add_time DESC;
GO

DELETE FROM dbo.Employee;

SELECT * FROM dbo.Employee
SELECT CASE WHEN new_emp_id IS NOT NULL AND org_emp_id IS NULL THEN 'INSERT' 
WHEN new_emp_id IS NOT NULL AND org_emp_id IS NOT NULL THEN 'UPDATE' 
WHEN new_emp_id IS NULL AND org_emp_id IS NOT NULL THEN 'DELETE' END,
* FROM dbo.EmployeeHistory
ORDER BY add_time DESC;
GO
SELECT CASE WHEN new_emp_id IS NOT NULL AND org_emp_id IS NULL THEN 'INSERT' 
WHEN new_emp_id IS NOT NULL AND org_emp_id IS NOT NULL THEN 'UPDATE' 
WHEN new_emp_id IS NULL AND org_emp_id IS NOT NULL THEN 'DELETE' END,* FROM dbo.EmployeeHistory
WHERE new_emp_id = 1 OR org_emp_id = 1
ORDER BY add_time DESC;