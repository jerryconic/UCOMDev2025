USE Northwind;

DECLARE @n int;
SET @n = 50;
IF @n < 60
	PRINT 'small';
ELSE IF @n >= 60
	PRINT 'big';
ELSE
	PRINT 'unknown';
GO

DECLARE @name nvarchar(20);
--SET @name= N'Nancy';
SET @name= N'John';
IF EXISTS(SELECT * FROM dbo.Employees 
	WHERE FirstName=@name)
	PRINT CONCAT('Yes,', @name, ' is here!');
ELSE
	PRINT CONCAT('No,', @name, ' is not here!');
GO

DECLARE @name nvarchar(20);
SET @name= N'db01';
IF EXISTS(SELECT * FROM sys.databases
	WHERE name=@name)
	PRINT CONCAT('DROP DATABASE ', @name);
ELSE
	PRINT CONCAT( @name, ' is not here!');
GO



DECLARE @n int, @result nvarchar(20);
SET @n = 8;
IF @n < 5
	SET @result = N'Less than 5';
ELSE IF @n BETWEEN 5 AND 10
	SET @result = N'Between 5 and 10';
ELSE IF @n > 10
	SET @result = N'Greater than 10';
ELSE
	SEt @result = N'Unknown';
SELECT @n AS num, @result AS result;
GO

DECLARE @n int, @result nvarchar(20);
SET @n = 8;
SET @result = CASE 
WHEN @n < 5 THEN N'Less than 5'
WHEN @n BETWEEN 5 AND 10 THEN N'Between 5 and 10'
WHEN @n > 10 THEN N'Greater than 10'
ELSE N'Unknown'
END;
SELECT @n AS num, @result AS result;
GO

--IIF, CHOOSE