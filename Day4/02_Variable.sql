USE Northwind;

DECLARE @n int;
SET @n = 50;
SELECT @n AS num;
GO

DECLARE @a int, @b int;
SELECT @a = 10, @b = 20;--Assign Value
SELECT @a AS num1, @b AS num2;--Data Retrieval
GO

DECLARE @count int;
SET @count = (SELECT COUNT(*)
	FROM dbo.Orders);
SELECT @count AS record_count;
GO

DECLARE @F_Name nvarchar(20), @L_Name nvarchar(20)
SELECT @F_Name = FirstName, @L_Name = LastName
FROM dbo.Employees
WHERE EmployeeID = 5;
PRINT @F_Name;
PRINT @L_Name;
GO

--Table Variable

DECLARE @tbl AS TABLE(
id int IDENTITY(1, 1) PRIMARY KEY,
name nvarchar(20)
);

INSERT INTO @tbl(name) VALUES('John'),('Peter'),('Linda'),('Alice');

SELECT * FROM @tbl;
GO
