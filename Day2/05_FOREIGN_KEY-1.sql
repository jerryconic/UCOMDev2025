USE db01;

DROP TABLE IF EXISTS dbo.Ord;
DROP TABLE IF EXISTS dbo.Emp;

CREATE TABLE dbo.Emp
(
emp_id int CONSTRAINT PK_Emp PRIMARY KEY,
emp_name nvarchar(20)
);

CREATE TABLE dbo.Ord
(
ord_id int CONSTRAINT PK_Ord PRIMARY KEY,
emp_id int,
amount int
);

INSERT INTO dbo.Emp(emp_id, emp_name)
VALUES(1, 'John'), (2, 'Peter'), (3, 'Alice');

INSERT INTO dbo.Ord(ord_id, emp_id, amount)
VALUES(1, 1, 3000),(2, 2, 4000), (3, 2, 5000), (4, 3, 6000);

SELECT * FROM dbo.Emp;
SELECT * FROM dbo.Ord;
GO


SELECT * FROM dbo.Emp e INNER JOIN dbo.Ord o
	ON e.emp_id = o.emp_id

	
SELECT e.emp_id, e.emp_name, SUM(o.amount) AS total FROM dbo.Emp e INNER JOIN dbo.Ord o
	ON e.emp_id = o.emp_id
GROUP BY e.emp_id, e.emp_name;
GO


INSERT INTO dbo.Emp(emp_id, emp_name) VALUES(4, 'Rookie');
GO

INSERT INTO dbo.Ord(ord_id, emp_id, amount) VALUES(9, 99, 9999);

GO
SELECT * FROM dbo.Emp;
SELECT * FROM dbo.Ord;

SELECT * FROM dbo.Emp e INNER JOIN dbo.Ord o
	ON e.emp_id = o.emp_id

	
SELECT e.emp_id, e.emp_name, SUM(o.amount) AS total FROM dbo.Emp e INNER JOIN dbo.Ord o
	ON e.emp_id = o.emp_id
GROUP BY e.emp_id, e.emp_name;
GO
SELECT SUM(total)
FROM 
(
SELECT e.emp_id, e.emp_name, SUM(o.amount) AS total FROM dbo.Emp e INNER JOIN dbo.Ord o
	ON e.emp_id = o.emp_id
GROUP BY e.emp_id, e.emp_name
) o;
GO

SELECT SUM(amount) FROM dbo.Ord;
GO

UPDATE dbo.Emp SET emp_id = 11 WHERE emp_id = 1;

DELETE FROM dbo.Emp WHERE emp_id = 2;

SELECT * FROM dbo.Emp;
SELECT * FROM dbo.Ord;
GO


SELECT * FROM dbo.Emp e INNER JOIN dbo.Ord o
	ON e.emp_id = o.emp_id

	
SELECT e.emp_id, e.emp_name, SUM(o.amount) AS total FROM dbo.Emp e INNER JOIN dbo.Ord o
	ON e.emp_id = o.emp_id
GROUP BY e.emp_id, e.emp_name;
GO

SELECT SUM(total)
FROM 
(
SELECT e.emp_id, e.emp_name, SUM(o.amount) AS total FROM dbo.Emp e INNER JOIN dbo.Ord o
	ON e.emp_id = o.emp_id
GROUP BY e.emp_id, e.emp_name
) o;
GO


SELECT SUM(amount) FROM dbo.Ord;
GO