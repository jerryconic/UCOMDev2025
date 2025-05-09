SELECT 1;
SELECT 2;
SELECT 3/0;
SELECT 4;
SELECT 5;

SELECT * FROM sys.sysmessages
WHERE error=8134;

SELECT * FROM sys.syslanguages;

SET LANGUAGE N'¡c≈È§§§Â';
SET LANGUAGE N'us_english';

SELECT 3/0;
SELECT @@ERROR;
GO

SELECT 1;
IF @@ERROR <> 0 GOTO errHandler;

SELECT 2;
IF @@ERROR <> 0 GOTO errHandler;

SELECT 3/0;
IF @@ERROR <> 0 GOTO errHandler;

SELECT 4;
IF @@ERROR <> 0 GOTO errHandler;

SELECT 5;
IF @@ERROR <> 0 GOTO errHandler;


RETURN;

errHandler:
SELECT 'Error';

GO

--SQL 2005
BEGIN TRY
	SELECT 1;
	THROW 50000, 'self-defined error', 1;
	SELECT 2;
	SELECT 3/0;
	SELECT 4;
	SELECT 5;
END TRY
BEGIN CATCH
	THROW;
	
	SELECT ERROR_NUMBER() AS err_no, 
		ERROR_LINE() AS err_line,
		ERROR_MESSAGE() AS err_msg,
		ERROR_PROCEDURE() AS err_proc,
		ERROR_SEVERITY() AS err_level,
		ERROR_STATE() AS err_state
	
END CATCH