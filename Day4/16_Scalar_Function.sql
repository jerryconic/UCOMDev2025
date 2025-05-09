USE Northwind;

GO

CREATE FUNCTION dbo.Fact(@n tinyint)
RETURNS decimal(38, 0)
AS
BEGIN
	DECLARE @i tinyint = 1, @result decimal(38, 0) =1;
	WHILE @i <= @n
	BEGIN
		SET @result = @result * @i;
		SET @i = @i + 1;
	END
    RETURN @result;

END
GO

PRINT dbo.Fact(0)
PRINT dbo.Fact(1)
PRINT dbo.Fact(2)
PRINT dbo.Fact(3)
PRINT dbo.Fact(4)

DECLARE @i tinyint = 1;
WHILE @i <=33
BEGIN
	PRINT CONCAT(@i, '! = ', dbo.Fact(@i))
	SET @i = @i + 1;
END