SELECT NEWID();

USE db01;

DROP TABLE IF EXISTS dbo.TestGUID

CREATE TABLE dbo.TestGUID
(
id0 int IDENTITY(1, 1),
id1 uniqueidentifier DEFAULT NEWID(),
id2 uniqueidentifier DEFAULT NEWSEQUENTIALID(),
data nvarchar(20)
);

GO

INSERT INTO dbo.TestGUID(data) VALUES('aaa'), ('bbb'), ('ccc');
GO 10

SELECT * FROM dbo.TestGUID
ORDER BY id1;

SELECT * FROM dbo.TestGUID
ORDER BY id2;
