DROP TABLE IF EXISTS #tmp;
--Step 1
CREATE TABLE #tmp(query nvarchar(1000), result nvarchar(max));
DECLARE @jsonInfo NVARCHAR(MAX)=
N'{
   "info": {
      "type": 1,
      "address": {
         "town": "Bristol",
         "county": "Avon",
         "country": "England"
		},
      "tags": ["Sport", "Water polo"]
   },
   "type": "Basic"
}';

--SELECT 'JSON_QUERY=>$', JSON_QUERY(@jsonInfo,'$');
INSERT INTO #tmp(query, result)
SELECT 'JSON_QUERY=>$', JSON_QUERY(@jsonInfo,'$');

INSERT INTO #tmp(query, result)
SELECT 'JSON_QUERY=>$.info', JSON_QUERY(@jsonInfo,'$.info');

INSERT INTO #tmp(query, result)
SELECT 'JSON_QUERY=>$.info.address', JSON_QUERY(@jsonInfo,'$.info.address');

INSERT INTO #tmp(query, result)
SELECT 'JSON_QUERY=>$.info.address.town', JSON_QUERY(@jsonInfo,'$.info.address.town');

INSERT INTO #tmp(query, result)
SELECT 'JSON_VALUE=>$.info.address.town', JSON_VALUE(@jsonInfo,'$.info.address.town');

SELECT * FROM #tmp;

INSERT INTO #tmp(query, result)
SELECT 'JSON_VALUE=>$.info.type', JSON_VALUE(@jsonInfo,'$.info.type');
INSERT INTO #tmp(query, result)
SELECT 'JSON_VALUE=>$.info.address.town', JSON_VALUE(@jsonInfo,'$.info.address.town');
INSERT INTO #tmp(query, result)
SELECT 'JSON_VALUE=>$.info.address.county', JSON_VALUE(@jsonInfo,'$.info.address.county');
INSERT INTO #tmp(query, result)
SELECT 'JSON_VALUE=>$.info.address.country', JSON_VALUE(@jsonInfo,'$.info.address.country');
INSERT INTO #tmp(query, result)
SELECT 'JSON_VALUE=>$.info.tags[0]', JSON_VALUE(@jsonInfo,'$.info.tags[0]');
INSERT INTO #tmp(query, result)
SELECT 'JSON_VALUE=>$.info.tags[1]', JSON_VALUE(@jsonInfo,'$.info.tags[1]');
INSERT INTO #tmp(query, result)
SELECT 'JSON_VALUE=>$.info.tags[2]', JSON_VALUE(@jsonInfo,'$.info.tags[2]');
SELECT * FROM #tmp;
GO
SELECT* FROM #tmp;
-----------------------------------------------------
--Step 2
DECLARE @jsonInfo NVARCHAR(MAX)

SET @jsonInfo=N'{  
     "info":{    
       "type":1,  
       "address":{    
         "town":"Bristol",  
         "county":"Avon",  
         "country":"England"  
       },  
       "tags":["Sport", "Water polo"]  
    },  
    "type":"Basic"  
 }'  
SELECT JSON_VALUE(@jsonInfo,'$.info.address.town')

GO

DECLARE @jsonInfo nvarchar(max);
SET @jsonInfo=
N'{
	"info":	{
		"address":[	{"town":"Paris"}, {"town":"London"}	]
		}
  }';
SELECT JSON_VALUE(@jsonInfo,'$.info.address[0].town'); -- Paris
SELECT JSON_VALUE(@jsonInfo,'$.info.address[1].town'); -- London
GO




DECLARE @json NVARCHAR(MAX);
SET @json =   
  N'[  
       {  
         "Order": {  
           "Number":"SO43659",  
           "Date":"2011-05-31T00:00:00"  
         },  
         "AccountNumber":"AW29825",  
         "Item": {  
           "Price":2024.9940,  
           "Quantity":1  
         }  
       },  
       {  
         "Order": {  
           "Number":"SO43661",  
           "Date":"2011-06-01T00:00:00"  
         },  
         "AccountNumber":"AW73565",  
         "Item": {  
           "Price":2024.9940,  
           "Quantity":3  
         }  
      }  
 ]';  
   
SELECT * FROM  
 OPENJSON ( @json )  
WITH (   
              order_no   varchar(200) '$.Order.Number' ,  
              order_date     datetime     '$.Order.Date',  
              customer_id varchar(200) '$.AccountNumber',  
              Quantity int          '$.Item.Quantity'  
 );

GO


DECLARE @json VARCHAR(MAX) = '
[
  {
    "name": "horse",
     "age": 18
  },
  {
    "name": "Otis",
    "age": 18
  }
]
';

SELECT *
FROM OPENJSON(@json)
WITH (name  VARCHAR(100)  '$.name',
      age   INT           '$.age')
GO
USE Northwind;

SELECT EmployeeID, FirstName, LastName, Title
FROM dbo.Employees
FOR JSON AUTO;
GO

DECLARE @JsonInfo nvarchar(max);
SET @JsonInfo = N'
[
	{
	"EmployeeID":1,
	"FirstName":"Nancy",
	"LastName":"Davolio",
	"Title":"Sales Representative"
	},
	{
	"EmployeeID":2,
	"FirstName":"Andrew",
	"LastName":"Fuller",
	"Title":"Vice President, Sales"
	},
	{
	"EmployeeID":3,
	"FirstName":"Janet",
	"LastName":"Leverling",
	"Title":"Sales Representative"
	},
	{
	"EmployeeID":4,
	"FirstName":"Margaret",
	"LastName":"Peacock",
	"Title":"Sales Representative"
	},
	{
	"EmployeeID":5,
	"FirstName":"Steven",
	"LastName":"Buchanan",
	"Title":"Sales Manager"
	},
	{
	"EmployeeID":6,
	"FirstName":"Michael",
	"LastName":"Suyama",
	"Title":"Sales Representative"
	},
	{
	"EmployeeID":7,
	"FirstName":"Robert",
	"LastName":"King",
	"Title":"Sales Representative"
	},
	{
	"EmployeeID":8,
	"FirstName":"Laura",
	"LastName":"Callahan",
	"Title":"Inside Sales Coordinator"
	},
	{
	"EmployeeID":9,
	"FirstName":"Anne",
	"LastName":"Dodsworth",
	"Title":"Sales Representative"
	}
]';

SELECT * FROM  
 OPENJSON ( @JsonInfo )  
WITH (   
              EmployeeID	int			'$.EmployeeID' ,  
              FirstName		nvarchar(20)'$.FirstName',  
              LastName		nvarchar(20)'$.LastName',  
              Title			nvarchar(20)'$.Title'  
 ) 

 GO
 
DECLARE @JsonInfo nvarchar(max);

SELECT @JsonInfo = BulkColumn FROM OPENROWSET(  
   BULK 'C:\Temp\Test.json',  
   SINGLE_NCLOB) AS x; 

SELECT * FROM  
 OPENJSON ( @JsonInfo )  
WITH (   
              EmployeeID	int			'$.EmployeeID' ,  
              FirstName		nvarchar(20)'$.FirstName',  
              LastName		nvarchar(20)'$.LastName',  
              Title			nvarchar(20)'$.Title'  
 ) 
GO
DROP TABLE IF EXISTS #tmp;
CREATE TABLE #tmp
(
EmployeeID	int PRIMARY KEY,  
FirstName	nvarchar(20),  
LastName	nvarchar(20),  
Title	nvarchar(20)
);
GO
DECLARE @JsonInfo nvarchar(max);

SELECT @JsonInfo = BulkColumn FROM OPENROWSET(  
   BULK 'C:\Temp\Test.json',  
   SINGLE_NCLOB) AS x; 

INSERT INTO #tmp(EmployeeID, FirstName, LastName, Title)
SELECT * FROM  
 OPENJSON ( @JsonInfo )  
WITH (   
              EmployeeID	int			'$.EmployeeID' ,  
              FirstName		nvarchar(20)'$.FirstName',  
              LastName		nvarchar(20)'$.LastName',  
              Title			nvarchar(20)'$.Title'  
 ) 
GO


SELECT * FROM #tmp;

 SELECT * FROM #tmp;
 
USE Northwind;

-----------------------------SQL Server 2016 新增------------------
SELECT EmployeeID, FirstName, LastName, Title
FROM dbo.Employees
FOR JSON AUTO;

 ----------------------------SQL Server 2022 新增------------------
SELECT JSON_ARRAY();
 SELECT JSON_ARRAY('a', 1, 'b', 2)
 SELECT JSON_ARRAY('a', 1, 'b', NULL)
SELECT JSON_ARRAY('a', JSON_OBJECT('name':'value', 'type':1))
GO
DECLARE @id_value nvarchar(64) = NEWID();
SELECT JSON_ARRAY(1, @id_value, (SELECT @@SPID));
GO

SELECT s.session_id, JSON_ARRAY(s.host_name, s.program_name, s.client_interface_name)
FROM sys.dm_exec_sessions AS s
WHERE s.is_user_process = 1;

SELECT JSON_OBJECT();

SELECT JSON_OBJECT('name':'value', 'type':1)

SELECT s.session_id, JSON_OBJECT('security_id':s.security_id, 'login':s.login_name, 'status':s.status) as info
FROM sys.dm_exec_sessions AS s
WHERE s.is_user_process = 1;
