
USE tempdb;

CREATE TABLE dbo.Document
(
id int PRIMARY KEY,
document xml
);

GO

CREATE PRIMARY XML INDEX PXI_document 
ON dbo.Document(document)
GO

CREATE XML INDEX SXI_document_PATH 
ON dbo.Document(document)
USING XML INDEX PXI_document FOR PATH 
GO

CREATE XML INDEX SXI_document_PROPERTY
ON dbo.Document(document)
USING XML INDEX PXI_document FOR PROPERTY
GO

CREATE XML INDEX SXI_document_VALUE
ON dbo.Document(document)
USING XML INDEX PXI_document FOR VALUE


