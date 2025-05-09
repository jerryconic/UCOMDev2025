USE db01;

DROP TABLE IF EXISTS dbo.Score;
GO

CREATE TABLE dbo.Score
(
id int PRIMARY KEY,
c1 smallint,
c2 smallint,
c3 smallint
);

/*
ALTER TABLE dbo.Score
ADD total smallint
GO
*/

ALTER TABLE dbo.Score
ADD total AS c1 + c2 + c3 PERSISTED;


INSERT INTO dbo.Score(id, c1, c2, c3)
VALUES(1, 90, 80, 80),
(2, 100, 56, 72),
(3, 95, 85, 60),
(4, 80, 45, 55);


SELECT * FROM dbo.Score


--UPDATE dbo.Score SET total = c1 + c2 + c3;

UPDATE dbo.Score SET c3 = 100

SELECT * FROM dbo.Score

