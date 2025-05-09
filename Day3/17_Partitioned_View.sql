

USE db01;

CREATE TABLE dbo.Ord2006
(
ord_id int CONSTRAINT PK_Ord2006 PRIMARY KEY,
ord_date date
);

CREATE TABLE dbo.Ord2007
(
ord_id int CONSTRAINT PK_Ord2007 PRIMARY KEY,
ord_date date
);

CREATE TABLE dbo.Ord2008
(
ord_id int CONSTRAINT PK_Ord2008 PRIMARY KEY,
ord_date date
);

GO
-----------------------------------------------------------------
CREATE VIEW dbo.OrdAll
AS
SELECT * FROM dbo.Ord2006
UNION ALL
SELECT * FROM dbo.Ord2007
UNION ALL
SELECT * FROM dbo.Ord2008
GO

SELECT * FROM dbo.OrdAll;

SELECT * FROM dbo.OrdAll
WHERE ord_date BETWEEN '2006-1-1' AND '2006-1-31'

GO

ALTER TABLE dbo.Ord2006
ADD CONSTRAINT CK_Ord2006_ord_date
 CHECK(ord_date BETWEEN '2006-1-1' AND '2006-12-31');

 
ALTER TABLE dbo.Ord2007
ADD CONSTRAINT CK_Ord2007_ord_date
 CHECK(ord_date BETWEEN '2007-1-1' AND '2007-12-31');

 
ALTER TABLE dbo.Ord2008
ADD CONSTRAINT CK_Ord2008_ord_date
 CHECK(ord_date BETWEEN '2008-1-1' AND '2008-12-31');

GO
SELECT * FROM dbo.OrdAll

SELECT * FROM dbo.OrdAll
WHERE ord_date BETWEEN '2006-1-1' AND '2006-1-31'


SELECT * FROM dbo.OrdAll
WHERE ord_date BETWEEN '2006-12-1' AND '2007-1-31'



SELECT * FROM dbo.OrdAll
WHERE YEAR(ord_date) = 2006

EXEC sp_spaceused 'dbo.OrdAll';