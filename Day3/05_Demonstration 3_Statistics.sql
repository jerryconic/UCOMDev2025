USE tempdb;
DROP TABLE IF EXISTS dbo.Test
CREATE TABLE dbo.Test
(
id int IDENTITY(1, 1) PRIMARY KEY,
name nvarchar(20),
phone nvarchar(20),
address nvarchar(100)
);

GO

CREATE NONCLUSTERED INDEX IX_name
ON dbo.Test(name);
GO

INSERT INTO dbo.Test(name)
VALUES('John'),('Peter'),('Linda'),('Alice');
GO 10000

SELECT COUNT(*) FROM dbo.Test;
SELECT SQRT(40000*1000)--6324.55532033676
GO
SELECT * FROM dbo.Test
WHERE name = 'John'

SELECT * FROM dbo.Test
WHERE name = 'Nick'

GO
INSERT INTO dbo.Test(name)
VALUES('Nick')
GO 6000

SET STATISTICS IO ON;


SELECT * FROM dbo.Test
WHERE name = 'Nick'

SELECT * FROM dbo.Test WITH(INDEX(0))
WHERE name = 'Nick'

EXEC sp_updatestats;

UPDATE STATISTICS dbo.Test;

UPDATE STATISTICS dbo.Test IX_name;


SELECT * FROM dbo.Test
WHERE name = 'Nick'
