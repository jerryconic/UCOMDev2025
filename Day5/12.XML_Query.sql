

CREATE TABLE #tmp(
id int PRIMARY KEY,
doc xml
);
GO

USE Northwind;

DECLARE @doc xml;
SET @doc =
(SELECT CategoryName, ProductName, 
 UnitPrice
FROM dbo.Products Product
INNER JOIN dbo.Categories Category
	On Product.CategoryID = Category.CategoryID
ORDER BY Category.CategoryID, Product.UnitPrice DESC
FOR XML AUTO, ROOT('ROOT'));


INSERT INTO #tmp(id, doc)
VALUES(1, @doc);
GO

SELECT * FROM #tmp

SELECT doc.value('(/ROOT/Category/@CategoryName)[1]', 'varchar(max)') AS xpath_value
FROM #tmp WHERE id = 1;
SELECT doc.value('(/ROOT/Category/@CategoryName)[2]', 'varchar(max)') AS xpath_value
FROM #tmp WHERE id = 1;
SELECT doc.value('(/ROOT/Category/@CategoryName)[8]', 'varchar(max)') AS xpath_value
FROM #tmp WHERE id = 1;
SELECT doc.value('(/ROOT/Category/@CategoryName)[9]', 'varchar(max)') AS xpath_value
FROM #tmp WHERE id = 1;

SELECT doc.value('(//Category/@CategoryName)[1]', 'varchar(max)')
FROM #tmp WHERE id = 1;

SELECT doc.value('(/ROOT/Category/Product/@UnitPrice)[1]', 'varchar(max)')
FROM #tmp WHERE id = 1;

SELECT doc.value('(//Product/@ProductName)[1]', 'varchar(max)')
FROM #tmp WHERE id = 1;

SELECT doc.value('(//Product/@UnitPrice)[1]', 'varchar(max)')
FROM #tmp WHERE id = 1;

SELECT doc.query('<items>
{
for $i in //Product[@UnitPrice<=10]
	return $i
}
</items>')
FROM #tmp WHERE id = 1;


GO


DECLARE @doc xml;
SET @doc =
(SELECT CategoryName, ProductName, 
 UnitPrice
FROM dbo.Products Product
INNER JOIN dbo.Categories Category
	On Product.CategoryID = Category.CategoryID
ORDER BY Category.CategoryID, Product.UnitPrice DESC
FOR XML AUTO, ROOT('ROOT'), ELEMENTS);

INSERT INTO #tmp(id, doc)
VALUES(2, @doc);

SELECT * FROM #tmp
GO

SELECT doc.value('(.)[1]', 'varchar(max)') AS xpath_value
FROM #tmp WHERE id = 2;

SELECT doc.value('(//Category)[1]', 'varchar(max)')
FROM #tmp WHERE id = 2;

SELECT doc.value('(//Category/Product)[1]', 'varchar(max)')
FROM #tmp WHERE id = 2;

SELECT doc.value('(//Product)[1]', 'varchar(max)')
FROM #tmp WHERE id = 2;

SELECT doc.value('(//Category/Product/ProductName)[1]', 'varchar(max)')
FROM #tmp WHERE id = 2;

SELECT doc.value('(//Category/Product/UnitPrice)[1]', 'varchar(max)')
FROM #tmp WHERE id = 2;
GO

DECLARE @doc xml;
SET @doc =
(SELECT CategoryName, ProductName, 
 UnitPrice
FROM dbo.Products Product
INNER JOIN dbo.Categories Category
	On Product.CategoryID = Category.CategoryID
ORDER BY Category.CategoryID, Product.UnitPrice DESC
FOR XML AUTO, ROOT('ROOT'));

INSERT INTO #tmp(id, doc)
VALUES(3, @doc);


SELECT * FROM #tmp

GO
SELECT doc.query('/') AS result
FROM #tmp WHERE id = 3;

SELECT doc.query('/ROOT')
FROM #tmp WHERE id = 3;

SELECT doc.query('/ROOT/Category')
FROM #tmp WHERE id = 3;

SELECT doc.query('//Product')
FROM #tmp WHERE id = 3;

SELECT doc.query('/ROOT/Category/Product[@ProductName="Ipoh Coffee"]')
FROM #tmp WHERE id = 3;

SELECT doc.query('/ROOT/Category/Product[@UnitPrice<=10]')
FROM #tmp WHERE id = 3;

SELECT doc.query('/ROOT/Category/Product[contains(@ProductName,"Meat")]')
FROM #tmp WHERE id = 3;

GO


DECLARE @doc xml;
SELECT @doc = doc
FROM #tmp WHERE id = 3;

IF @doc.exist('/ROOT/Category/Product[@UnitPrice>1000]')=1
	PRINT 'YES'
ELSE
	PRINT 'NO'

GO
DECLARE @doc xml;
SET @doc =
(SELECT CategoryName, ProductName, 
 UnitPrice
FROM dbo.Products Product
INNER JOIN dbo.Categories Category
	On Product.CategoryID = Category.CategoryID
ORDER BY Category.CategoryID, Product.UnitPrice DESC
FOR XML AUTO, ROOT('ROOT'), ELEMENTS);

SELECT @doc;

SELECT @doc.query('/ROOT/Category/Product[../CategoryName="Beverages"]');
SELECT @doc.query('/ROOT/Category/Product[../CategoryName="Condiments"]');
SELECT @doc.query('/ROOT/Category[./CategoryName="Condiments"]');




SELECT *
FROM sys.fn_xe_file_target_read_file('C:\xe\*.xel', NULL, NULL, NULL)
WHERE object_name = 'xml_deadlock_report'

SELECT CAST(event_data AS xml)
FROM sys.fn_xe_file_target_read_file('C:\xe\*.xel', NULL, NULL, NULL)
WHERE object_name = 'xml_deadlock_report'

SELECT 
--CAST(event_data AS xml).query('//inputbuf'),
CAST(event_data AS xml).query('//victim-list'),
CAST(event_data AS xml).query('//process-list'),
CAST(event_data AS xml).query('//resource-list')

FROM sys.fn_xe_file_target_read_file('C:\xe\*.xel', NULL, NULL, NULL)
WHERE object_name = 'xml_deadlock_report'