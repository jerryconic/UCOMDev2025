USE master;
IF EXISTS(SELECT * FROM sys.databases WHERE name = 'db01')
BEGIN
	ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE db01;
END
GO

CREATE DATABASE [db01]
GO

USE db01;

GO  
CREATE TABLE dbo.Balance
(
    customer_id int PRIMARY KEY,
    last_name nvarchar(20),
    first_name nvarchar(20),
    balance decimal(10, 2)
)
WITH 
(
 SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.BalanceHistory),
 LEDGER = ON
);

GO
SELECT 
ts.[name] + '.' + t.[name] AS [ledger_table_name]
, hs.[name] + '.' + h.[name] AS [history_table_name]
, vs.[name] + '.' + v.[name] AS [ledger_view_name]
FROM sys.tables AS t
JOIN sys.tables AS h ON (h.[object_id] = t.[history_table_id])
JOIN sys.views v ON (v.[object_id] = t.[ledger_view_id])
JOIN sys.schemas ts ON (ts.[schema_id] = t.[schema_id])
JOIN sys.schemas hs ON (hs.[schema_id] = h.[schema_id])
JOIN sys.schemas vs ON (vs.[schema_id] = v.[schema_id])
WHERE t.[name] = 'Balance';
GO

INSERT INTO dbo.Balance(customer_id, last_name, first_name, balance)
VALUES (1, 'Jones', 'Nick', 50);

WAITFOR DELAY '0:0:10';

INSERT INTO dbo.Balance(customer_id, last_name, first_name, balance)
VALUES (2, 'Smith', 'John', 500),
(3, 'Smith', 'Joe', 30),
(4, 'Michaels', 'Mary', 200);

SELECT customer_id, last_name, first_name, balance,
   ledger_start_transaction_id
   ,ledger_end_transaction_id
   ,ledger_start_sequence_number
   ,ledger_end_sequence_number
 FROM dbo.Balance; 


WAITFOR DELAY '0:0:10';

UPDATE dbo.Balance SET balance = 100
WHERE customer_id = 1;

SELECT
 t.commit_time
 , t.principal_name
 , l.customer_id
 , l.last_name
 , l.first_name
 , l.balance
 , l.ledger_operation_type_desc
 FROM dbo.Balance_Ledger l
 JOIN sys.database_ledger_transactions t
 ON t.transaction_id = l.ledger_transaction_id
 ORDER BY t.commit_time DESC;

 SELECT
 t.commit_time
 , t.principal_name
 , l.customer_id
 , l.last_name
 , l.first_name
 , l.balance
 , l.ledger_operation_type_desc
 FROM dbo.Balance_Ledger l
 JOIN sys.database_ledger_transactions t
 ON t.transaction_id = l.ledger_transaction_id
 WHERE l.customer_id = 1
 ORDER BY t.commit_time DESC;


 DROP TABLE dbo.Balance;
