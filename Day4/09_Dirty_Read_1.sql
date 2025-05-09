USE db01;

DROP TABLE IF EXISTS dbo.Test;
CREATE TABLE dbo.Test(id int PRIMARY KEY)
GO

BEGIN TRAN;
	INSERT INTO dbo.Test(id) VALUES(1);

	SELECT * FROM dbo.Test;
--ROLLBACK TRAN;

dbcc useroptions;
