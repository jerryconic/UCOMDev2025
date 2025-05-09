USE db01;

DROP TABLE IF EXISTS dbo.Employee;

CREATE TABLE dbo.Employee
(
emp_id int PRIMARY KEY,
emp_name varchar(20) COLLATE Latin1_General_CI_AS,
emp_name_ch varchar(20) COLLATE Chinese_Taiwan_Stroke_CI_AS
);

USE [master]
GO
ALTER DATABASE [db01] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
ALTER DATABASE [db01] COLLATE Latin1_General_CI_AS
ALTER DATABASE [db01] SET MULTI_USER 
GO

SELECT COLLATIONPROPERTY('Latin1_General_CI_AS', 'codepage');
SELECT COLLATIONPROPERTY('Chinese_Taiwan_Stroke_CI_AS', 'codepage');

USE db01;
GO

SELECT '林小明'
SELECT N'林小明'

INSERT INTO dbo.Employee(emp_id, emp_name, emp_name_ch)
VALUES(1, 'John', N'林小明');
INSERT INTO dbo.Employee(emp_id, emp_name, emp_name_ch)
VALUES(2, 'Peter', 'Peter');

INSERT INTO dbo.Employee(emp_id, emp_name, emp_name_ch)
VALUES(3, 'Linda', 'Linda');

SELECT * FROM dbo.Employee

INSERT INTO dbo.Employee(emp_id, emp_name, emp_name_ch)
VALUES(4, N'林小明', 'Linda');


SELECT * FROM dbo.Employee


GO
DROP TABLE IF EXISTS dbo.Employee;

CREATE TABLE dbo.Employee
(
emp_id int PRIMARY KEY,
emp_name nvarchar(20) COLLATE Latin1_General_CI_AS,
emp_name_ch nvarchar(20) COLLATE Chinese_Taiwan_Stroke_CI_AS
);


INSERT INTO dbo.Employee(emp_id, emp_name, emp_name_ch)
VALUES(1, 'John', N'林小明');
INSERT INTO dbo.Employee(emp_id, emp_name, emp_name_ch)
VALUES(2, 'Peter', 'Peter');

INSERT INTO dbo.Employee(emp_id, emp_name, emp_name_ch)
VALUES(3, 'Linda', 'Linda');


INSERT INTO dbo.Employee(emp_id, emp_name, emp_name_ch)
VALUES(4, N'林小明', 'Linda');

SELECT * FROM dbo.Employee

SELECT * FROM dbo.Employee
WHERE emp_name = emp_name_ch

SELECT * FROM dbo.Employee
WHERE emp_name = emp_name_ch COLLATE Chinese_Taiwan_Stroke_CI_AS


