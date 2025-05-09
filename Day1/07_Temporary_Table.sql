USE db01;

CREATE TABLE #tmp
(
id int PRIMARY KEY,
data nvarchar(20)
);

INSERT INTO #tmp(id, data)
VALUES(1, 'AAA');

SELECT * FROM #tmp;