USE db01;

EXEC sp_spaceused 'dbo.Person'

CREATE UNIQUE CLUSTERED INDEX CX_Person
ON dbo.Person(BusinessEntityID);

EXEC sp_spaceused 'dbo.Person'

CREATE NONCLUSTERED INDEX IX_FirstName_LastName
ON dbo.Person(FirstName, LastName)

EXEC sp_spaceused 'dbo.Person'

GO

CREATE NONCLUSTERED INDEX IX_FirstName_Coverying 
ON dbo.Person(FirstName)
INCLUDE(PersonType,NameStyle,Title,MiddleName,LastName,Suffix,EmailPromotion,AdditionalContactInfo,
Demographics,rowguid,ModifiedDate) 


GO

EXEC sp_spaceused 'dbo.Person'



/*
name	rows	reserved	data		index_size	     unused
Person	19972   22024 KB	21968 KB	    8 KB		  48 KB   --RAW Data
Person	19972   22936 KB	22032 KB	  136 KB		 768 KB   --Clustered Index
Person	19972   24096 KB	22032 KB	 1016 KB		1048 KB   --Non-Clustered Index(FirstName, LastName)
Person	19972   47672 KB	22032 KB	23376 KB	    2264 KB   --Coverying Index
*/


GO

ALTER INDEX [CX_Person] ON [dbo].[Person] 
REBUILD PARTITION = ALL 
WITH (PAD_INDEX = OFF, FILLFACTOR = 90)

GO

