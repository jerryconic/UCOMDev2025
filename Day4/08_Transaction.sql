USE master;

IF EXISTS(SELECT * FROM sys.databases WHERE name = 'db01')
BEGIN
	ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE db01;
END
GO


CREATE DATABASE db01;
GO

USE db01;
CREATE TABLE dbo.Ord
(
ord_id int CONSTRAINT PK_Ord PRIMARY KEY,
ord_date date,
cust_id int
);

CREATE TABLE dbo.OrdDetail
(
ord_id int,
prdt_id int,
qty int,
CONSTRAINT PK_OrdDetail PRIMARY KEY(ord_id, prdt_id)
);
GO
------------------------------------------------------------
BEGIN TRY
	INSERT INTO dbo.Ord(ord_id, ord_date, cust_id)	VALUES(1, GETDATE(), 1);

	INSERT INTO dbo.OrdDetail(ord_id, prdt_id, qty) VALUES(1, 1, 100);
		--ERROR: Duplicate Key(1, 1)
	INSERT INTO dbo.OrdDetail(ord_id, prdt_id, qty) VALUES(1, 1, 200);		
	INSERT INTO dbo.OrdDetail(ord_id, prdt_id, qty) VALUES(1, 3, 300);
END TRY
BEGIN CATCH
	THROW;
END CATCH
GO

SELECT * FROM dbo.Ord;
SELECT * FROM dbo.OrdDetail;

DELETE FROM dbo.OrdDetail;
DELETE FROM dbo.Ord;
GO



dbcc useroptions;
SET XACT_ABORT ON;
SELECT XACT_STATE();
/*
XACT_STATE()
0	�ثe���n�D�S������ϥΤ����ϥΪ̥���C
1	����i�椤, �i�HCOMMIT TRAN;��ROLLBACK TRAN;
-1	�������, �u��ROLLBACK TRAN;
*/

BEGIN TRY
	BEGIN TRAN;
	INSERT INTO dbo.Ord(ord_id, ord_date, cust_id)	VALUES(1, GETDATE(), 1);

	INSERT INTO dbo.OrdDetail(ord_id, prdt_id, qty) VALUES(1, 1, 100);
		--ERROR: Duplicate Key(1, 1)
	INSERT INTO dbo.OrdDetail(ord_id, prdt_id, qty) VALUES(1, 1, 200);		
	INSERT INTO dbo.OrdDetail(ord_id, prdt_id, qty) VALUES(1, 3, 300);
	COMMIT TRAN; --�{�i���
END TRY
BEGIN CATCH
	--ROLLBACK TRAN;  --�^�_���
	--THROW;
	SELECT 'Error';
END CATCH
GO

SELECT * FROM dbo.Ord;
SELECT * FROM dbo.OrdDetail;


SELECT @@TRANCOUNT;
BEGIN TRAN;
	SELECT @@TRANCOUNT;
	BEGIN TRAN;
		SELECT @@TRANCOUNT;
		BEGIN TRAN;
			SELECT @@TRANCOUNT;
			ROLLBACK TRAN;

		COMMIT TRAN;
		SELECT @@TRANCOUNT;
	COMMIT TRAN;
	SELECT @@TRANCOUNT;
COMMIT TRAN;
SELECT @@TRANCOUNT;