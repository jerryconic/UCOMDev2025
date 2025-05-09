USE db01;



SELECT * FROM dbo.Test;  --會被Lock

SELECT * FROM dbo.Test WITH(NOLOCK);

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

dbcc useroptions;

SELECT * FROM dbo.Test;  --不會被Lock
