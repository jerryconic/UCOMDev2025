-- Step 1 - Open a new query window to the tempdb database

SELECT SUSER_NAME() AS [Login], USER_NAME() AS [User];

SELECT * FROM sys.login_token;
SELECT * FROM sys.user_token;

USE tempdb;
GO
CREATE USER SecureUser WITHOUT LOGIN;
GO

-- Step 2 - Create a stored procedure that queries sys.login_token and sys.user_token

CREATE PROC dbo.DisplayExecutionContext
AS
SET NOCOUNT ON;
BEGIN
  SELECT * FROM sys.login_token;
  SELECT * FROM sys.user_token;
END
GO

-- Step 3 - Execute the stored procedure and review the rowsets returned

EXEC dbo.DisplayExecutionContext;
GO

-- Step 4 - Use the EXECUTE AS statement to change context
--Impersonate(¿¿∫A)
EXECUTE AS User = 'SecureUser';
GO
SELECT SUSER_NAME() AS [Login], USER_NAME() AS [User];

-- Step 5 - Try to execute the procedure. Why does it not it work?

EXEC dbo.DisplayExecutionContext;
GO

-- Step 6 - Revert to the previous security context

REVERT;
GO
SELECT SUSER_NAME() AS [Login], USER_NAME() AS [User];

-- Step 7 - Grant permission to SecureUser to execute the procedure

GRANT EXECUTE ON dbo.DisplayExecutionContext TO SecureUser;
GO

-- Step 8 - Now try again and note the output

EXECUTE AS User = 'SecureUser';
GO
SELECT SUSER_NAME() AS [Login], USER_NAME() AS [User];

EXEC dbo.DisplayExecutionContext;
GO

REVERT;
GO

-- Step 9 - Alter the procedure to execute as owner

ALTER PROC dbo.DisplayExecutionContext
WITH EXECUTE AS OWNER
AS
SET NOCOUNT ON;
BEGIN
  SELECT * FROM sys.login_token;
  SELECT * FROM sys.user_token;
END
GO

-- Step 10 - Execute as SecureUser again and note the difference

EXECUTE AS User = 'SecureUser';
GO

EXEC dbo.DisplayExecutionContext;
GO

REVERT;
GO

DROP USER SecureUser;
-- Step 11 - Drop the procedure

DROP PROC dbo.DisplayExecutionContext;
GO