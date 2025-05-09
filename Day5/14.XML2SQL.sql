USE Northwind;

DECLARE @idoc int, @doc xml;
SET @doc =N'<ROOT>  
<Customer CustomerID="VINET" ContactName="Paul Henriot">  
   <Order CustomerID="VINET" EmployeeID="5" OrderDate="1996-07-04T00:00:00">  
      <OrderDetail OrderID="10248" ProductID="11" Quantity="12"/>  
      <OrderDetail OrderID="10248" ProductID="42" Quantity="10"/>  
   </Order>  
</Customer>  
<Customer CustomerID="LILAS" ContactName="Carlos Gonzlez">  
   <Order CustomerID="LILAS" EmployeeID="3" OrderDate="1996-08-16T00:00:00">  
      <OrderDetail OrderID="10283" ProductID="72" Quantity="3"/>  
   </Order>  
</Customer>  
</ROOT>';  

SELECT @doc.query('/ROOT/Customer');

--Create an internal representation of the XML document.  
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc;  
-- Execute a SELECT statement that uses the OPENXML rowset provider.  
SELECT * 
FROM       OPENXML (@idoc, '/ROOT/Customer',1)  
            WITH (CustomerID  varchar(10),  
                  ContactName varchar(20));  

EXEC sp_xml_removedocument @idoc;
GO

--利用 XML 變數轉成Table
DECLARE @xml xml, @ixml int;
SET @xml = (SELECT CustomerID, CompanyName, Address, Phone, ContactName, ContactTitle FROM dbo.Customers AS Customers FOR XML AUTO, ROOT('ROOT'));
SELECT @xml 

--將結果複製到=> C:\Temp\Test.xml  編碼=>(Unicode)
       

--利用以下的語法將檔案轉為Table

GO
CREATE TABLE #Customer
(
CustomerID nchar(5) PRIMARY KEY,
CompanyName nvarchar(50), 
Address nvarchar(100)
);
GO
--TRUNCATE TABLE #Customer;

DECLARE @xml xml, @ixml int;

SELECT @xml = BulkColumn FROM OPENROWSET(  
   BULK 'C:\Temp\Test.xml',  
   SINGLE_BLOB) AS x; 

EXEC sp_xml_preparedocument @ixml OUTPUT, @xml; 

INSERT INTO #Customer(CustomerID, CompanyName, Address)
SELECT * FROM  OPENXML (@ixml, '/ROOT/Customers',1)  
WITH (CustomerID nchar(5), CompanyName nvarchar(50), Address nvarchar(100))

EXEC sp_xml_removedocument @ixml;
 
GO

SELECT * FROM #Customer;