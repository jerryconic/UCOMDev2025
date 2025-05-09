-- Step 1: DO NOT RUN THE WHOLE SCRIPT, RUN EACH STEP INDIVIDUALLY
-- Display the execution plan (CTRL-M or click the GUI button), then execute the steps SQL, 
-- point to the final Table Scan to show I/O cost is approx 57. 
-- Point to the Hash Match (Aggregate) step - show the estimate execution mode is ROW.

USE AdventureworksDW
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO

SELECT	ProductKey
		,SUM(UnitPrice) SumUnitPrice
		,AVG(UnitPrice) AvgUnitPrice
		,SUM(OrderQuantity) SumOrderQty
		,AVG(OrderQuantity) AvgOrderQty
		,SUM(TotalProductCost) SumTotalProductCost
		,AVG(TotalProductCost) AvgTotalProductCost
		,SUM(UnitPrice - TotalProductCost) ProductProfit
FROM dbo.FactInternetSales 
GROUP BY ProductKey
ORDER BY ProductKey
GO

SET STATISTICS IO OFF
GO

------------------ END OF STEP 1 ------------------
/*

SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

(158 rows affected)
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
Table 'Workfile'. Scan count 0, logical reads 0, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
Table 'FactInternetSales'. Scan count 9, logical reads 79630, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 610 ms,  elapsed time = 178 ms.

Completion time: 2025-05-07T13:47:05.5317940+08:00

*/
/*
SQL Server parse and compile time: 
   CPU time = 3 ms, elapsed time = 3 ms.

(158 rows affected)
Table 'FactInternetSales'. Scan count 1, logical reads 0, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 89, lob physical reads 0, lob page server reads 0, lob read-ahead reads 60, lob page server read-ahead reads 0.
Table 'FactInternetSales'. Segment reads 3, segment skipped 0.
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 20 ms.

Completion time: 2025-05-07T13:52:33.3770260+08:00
*/

-- Step 2: DO NOT RUN THE WHOLE SCRIPT, RUN EACH STEP INDIVIDUALLY
-- Look and record the data column - this is the space used by the index and table
-- Clustered Index Scan and the Hash Match (Aggregate)

-- Data space used: 615,584 KB
/*
name				rows		reserved		data		index_size		unused
FactInternetSales	1,932,736   1,796,336 KB	615,584 KB	1,178,144 KB	2608 KB

FactInternetSales	1,932,736     338,912 KB	 39,776 KB	  295,848 KB	3288 KB

SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

(158 rows affected)
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
Table 'Workfile'. Scan count 0, logical reads 0, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
Table 'FactInternetSales'. Scan count 7, logical reads 79630, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 610 ms,  elapsed time = 154 ms.
----------------------------------------------------------
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 2 ms.

(158 rows affected)
Table 'FactInternetSales'. Scan count 1, logical reads 0, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 91, lob physical reads 0, lob page server reads 0, lob read-ahead reads 72, lob page server read-ahead reads 0.
Table 'FactInternetSales'. Segment reads 3, segment skipped 0.
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 7 ms.

*/

sp_spaceused 'dbo.FactInternetSales'
GO

------------------ END OF STEP 2 ------------------


-- Step 3: Replace the rowstore index with a columnstore
-- Look and record the data column - this is the space used by the new index and table
-- Highlight the massive space savings on this table


ALTER TABLE [dbo].[FactInternetSalesReason] DROP CONSTRAINT [FK_FactInternetSalesReason_FactInternetSales]
GO

ALTER TABLE [dbo].[FactInternetSalesReason] DROP CONSTRAINT [PK_FactInternetSalesReason_SalesOrderNumber_SalesOrderLineNumber_SalesReasonKey]
GO

ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [PK_FactInternetSales_SalesOrderNumber_SalesOrderLineNumber]
GO

CREATE CLUSTERED COLUMNSTORE INDEX PK_FactInternetSales_SalesOrderNumber_SalesOrderLineNumber on [FactInternetSales] 
GO

------------------ END OF STEP 3 ------------------


-- Step 4: DO NOT RUN THE WHOLE SCRIPT, RUN EACH STEP INDIVIDUALLY
-- Look and record the data column - this is the space used by the index and table
-- Clustered Index Scan and the Hash Match (Aggregate)

-- Data space used (approximately): 39,928 KB (15x smaller than the rowstore table!)
sp_spaceused 'dbo.FactInternetSales'
GO
