USE db01
GO
DROP TABLE IF EXISTS dbo.AutoNumber1;
GO

CREATE TABLE dbo.AutoNumber1(
	id int IDENTITY(1,1) NOT NULL,
	data nvarchar(50) NULL
)
GO

GO

INSERT INTO dbo.AutoNumber1(data) VALUES('aaa'), ('bbb'), ('ccc');

SELECT * FROM dbo.AutoNumber1;
GO

DELETE FROM dbo.AutoNumber1;
TRUNCATE TABLE dbo.AutoNumber1;

INSERT INTO dbo.AutoNumber1(data) VALUES('aaa'), ('bbb'), ('ccc');

SELECT * FROM dbo.AutoNumber1;

TRUNCATE TABLE dbo.AutoNumber1;

GO

INSERT INTO dbo.AutoNumber1(id, data) VALUES(100, 'aaa');

SET IDENTITY_INSERT dbo.AutoNumber1 ON;

INSERT INTO dbo.AutoNumber1(id, data) VALUES(100, 'aaa');

SET IDENTITY_INSERT dbo.AutoNumber1 OFF;

SELECT * FROM dbo.AutoNumber1;
GO

INSERT INTO dbo.AutoNumber1(data) VALUES('xxx'), ('yyy'), ('zzz');

SELECT * FROM dbo.AutoNumber1;
GO

DELETE FROM dbo.AutoNumber1;

INSERT INTO dbo.AutoNumber1(data) VALUES('aaa'), ('bbb'), ('ccc');

SELECT * FROM dbo.AutoNumber1;

SELECT IDENT_CURRENT('dbo.AutoNumber1');
SELECT SCOPE_IDENTITY();

GO



