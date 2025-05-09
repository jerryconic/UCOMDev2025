USE tempdb;

CREATE TABLE dbo.tmp
(
id int PRIMARY KEY,
data nvarchar(20)
);

INSERT INTO dbo.tmp(id, data)
VALUES(1, 'AAA');

SELECT * FROM dbo.tmp;