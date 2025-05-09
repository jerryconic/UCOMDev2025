USE db01;

DROP TABLE IF EXISTS dbo.Employee;
CREATE TABLE dbo.Employee
(
emp_id int IDENTITY(1, 1) CONSTRAINT PK_Employee PRIMARY KEY,
emp_name nvarchar(20) NOT NULL,
email nvarchar(50) CONSTRAINT UQ_Employee_email UNIQUE
);

TRUNCATE TABLE dbo.Employee;

INSERT INTO dbo.Employee(emp_name, email)
VALUES('John', 'john@uuu.com.tw');				-- O (1)

INSERT INTO dbo.Employee(emp_name, email)
VALUES('Peter', 'john@uuu.com.tw');				-- X (2)

INSERT INTO dbo.Employee(emp_name, email)
VALUES('Peter', 'peter@uuu.com.tw');            -- O (3)

INSERT INTO dbo.Employee(emp_name, email)
VALUES(NULL, 'alice@uuu.com.tw');               -- X (4)

INSERT INTO dbo.Employee(emp_name, email)
VALUES('Alice', NULL);                          -- O (5)

INSERT INTO dbo.Employee(emp_name, email)
VALUES('Nick', NULL);							-- X (6)

INSERT INTO dbo.Employee(emp_name, email)
VALUES('Nick', 'nick@uuu.com.tw');				-- O (7)

SELECT * FROM dbo.Employee;


SELECT SCHEMA_NAME(o.schema_id) +'.' + o.name AS table_name,
k.*
FROM sys.key_constraints k
INNER JOIN sys.objects o
	ON k.parent_object_id = o.object_id