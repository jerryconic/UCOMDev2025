USE db01;

DROP TABLE IF EXISTS dbo.Score;

CREATE TABLE dbo.Score
(
id int IDENTITY(1, 1) CONSTRAINT PK_Score PRIMARY KEY,
c1 smallint CONSTRAINT CK_Score_c1 CHECK(c1 BETWEEN 0 AND 100),
c2 smallint CONSTRAINT CK_Score_c2 CHECK(c2 BETWEEN 0 AND 100),
c3 smallint CONSTRAINT CK_Score_c3 CHECK(c3 BETWEEN 0 AND 100),
CONSTRAINT CK_Score_Total CHECK(c1 + c2 + c3 < 240)
)
GO

INSERT INTO dbo.Score(c1, c2, c3)
VALUES(60, 60, 60);

INSERT INTO dbo.Score(c1, c2, c3)
VALUES(101, NULL, NULL);

INSERT INTO dbo.Score(c1, c2, c3)
VALUES(NULL, 101, NULL);

INSERT INTO dbo.Score(c1, c2, c3)
VALUES(NULL, NULL, 103);

INSERT INTO dbo.Score(c1, c2, c3)
VALUES(NULL, NULL, NULL);

INSERT INTO dbo.Score(c1, c2, c3)
VALUES(90, 90, 90);


INSERT INTO dbo.Score(c1, c2, c3)
VALUES(50, 60, 90);

SELECT * FROM dbo.Score;

ALTER TABLE dbo.Score NOCHECK CONSTRAINT ALL

ALTER TABLE dbo.Score WITH CHECK CHECK CONSTRAINT ALL

ALTER TABLE dbo.Score WITH NOCHECK CHECK CONSTRAINT ALL


SELECT SCHEMA_NAME(o.schema_id) +'.' + o.name AS table_name,
k.*
FROM sys.check_constraints k
INNER JOIN sys.objects o
	ON k.parent_object_id = o.object_id