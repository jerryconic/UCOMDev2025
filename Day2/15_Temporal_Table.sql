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


--Create system-versioned temporal table. It must have primary key and two datetime2 columns that are part of SYSTEM_TIME period definition
CREATE TABLE dbo.Employee
(
	emp_id int CONSTRAINT PK_Employee PRIMARY KEY,
	emp_name nvarchar(20),
    s_time datetime2 GENERATED ALWAYS AS ROW START,
    e_time datetime2 GENERATED ALWAYS AS ROW END,
    PERIOD FOR SYSTEM_TIME(s_time, e_time),
)
WITH
(SYSTEM_VERSIONING = ON(HISTORY_TABLE = dbo.EmployeeHistory))
GO

INSERT INTO dbo.Employee(emp_id, emp_name)
VALUES(1, 'John'), (2, 'Peter'), (3, 'Linda'), (4, 'Alice');

WAITFOR DELAY '0:0:10';

UPDATE dbo.Employee
SET emp_name = 'Nick' 
WHERE emp_id = 3;

WAITFOR DELAY '0:0:10';

DELETE FROM dbo.Employee
WHERE emp_id = 4;

SELECT * FROM dbo.Employee;
SELECT * FROM dbo.EmployeeHistory;

SELECT emp_id, emp_name, SWITCHOFFSET(s_time, '+08:00') AS s_time, e_time FROM dbo.Employee;
SELECT emp_id, emp_name, SWITCHOFFSET(s_time, '+08:00') AS s_time, SWITCHOFFSET(e_time, '+08:00') AS e_time FROM dbo.EmployeeHistory;


SELECT * FROM dbo.Employee;
SELECT * FROM dbo.EmployeeHistory;

/*
@t1 = '2025-05-06 05:52:58.0630232' INSERT 'John', 'Peter', 'Linda', 'Alice'
@t2 = '2025-05-06 05:53:24.2508839' UPDATE 'Linda' => 'Nick'
@t3 = '2025-05-06 05:53:38.0528762' DELETE 'Alice'

*/

SELECT * FROM dbo.Employee
FOR SYSTEM_TIME AS OF '2025-05-06 05:52:58.0630232'  --@t1

SELECT * FROM dbo.Employee
FOR SYSTEM_TIME AS OF '2025-05-06 05:53:24.2508839'  --@t2

SELECT * FROM dbo.Employee
FOR SYSTEM_TIME AS OF '2025-05-06 05:53:38.0528762'  --@t3

DROP TABLE dbo.Employee
DROP TABLE dbo.EmployeeHistory

DELETE FROM dbo.EmployeeHistory

TRUNCATE TABLE dbo.Employee
TRUNCATE TABLE dbo.EmployeeHistory

ALTER TABLE dbo.Employee
SET (SYSTEM_VERSIONING=OFF);

ALTER TABLE dbo.Employee
SET (SYSTEM_VERSIONING=ON(HISTORY_TABLE=dbo.EmployeeHistory));


SELECT * FROM dbo.Employee
FOR SYSTEM_TIME ALL

SELECT * FROM dbo.Employee
FOR SYSTEM_TIME FROM '2025-05-06 05:52:58.0630232' TO '2025-05-06 05:53:24.2508839'  --FROM @t1 AND @t2

SELECT * FROM dbo.Employee
FOR SYSTEM_TIME BETWEEN '2025-05-06 05:52:58.0630232' AND '2025-05-06 05:53:24.2508839' --BETWEEN @t1 AND @t2

SELECT * FROM dbo.Employee
FOR SYSTEM_TIME CONTAINED IN('2025-05-06 05:52:58.0630232', '2025-05-06 05:53:24.2508839') --CONTAINED(@t1, @t2)
