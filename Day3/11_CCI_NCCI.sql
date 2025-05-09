USE AdventureWorks2019

GO

DROP INDEX NCCI_Person ON Person.Person
GO
CREATE NONCLUSTERED COLUMNSTORE INDEX NCCI_Person ON Person.Person
(
	BusinessEntityID,
	PersonType,
	Title,
	Suffix,
	EmailPromotion,
	ModifiedDate
)WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)

GO

EXEC sp_spaceused 'Person.Person'

/*
name	rows	reserved	data		index_size	unused
Person	19972   86696 KB	30520 KB	52944 KB	3232 KB
Person	19972   86960 KB	30520 KB	53072 KB	3368 KB

*/


GO
USE db01


EXEC sp_spaceused 'dbo.Person'
GO

CREATE CLUSTERED COLUMNSTORE INDEX CCI_Person ON dbo.Person 
GO


/*
name	rows	reserved	data		index_size	unused
Person	19972   22024 KB	21968 KB	8 KB		48 KB
Person	19972     648 KB	  552 KB	0 KB	    96 KB
*/

SELECT * FROM dbo.Person;

SET STATISTICS IO ON;
SELECT * FROM dbo.Person
WHERE FirstName= 'Ken';
