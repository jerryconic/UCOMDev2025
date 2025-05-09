-- Demonstration 1

-- Step 1: Open a query window to the AdventureWorks database

USE AdventureWorks2019;
GO

-- Step 2: Query the index physical stats DMV
--         Note that in the query below, the three NULL values are the 
--         object, the index, and the partition. In this case, we are 
--         showing all of these

SELECT SCHEMA_NAME(obj.schema_id) + '.' + obj.name AS table_name,
ix.name AS index_name,
phys.* FROM sys.dm_db_index_physical_stats(DB_ID(),NULL,NULL,NULL,'LIMITED') as phys
JOIN sys.objects as obj on obj.object_id = phys.object_id
JOIN sys.indexes ix ON phys.object_id = ix.object_id AND phys.index_id = ix.index_id
ORDER BY avg_fragmentation_in_percent DESC;

SELECT SCHEMA_NAME(obj.schema_id) + '.' + obj.name AS table_name,
ix.name AS index_name,
phys.* FROM sys.dm_db_index_physical_stats(DB_ID(),NULL,NULL,NULL,'LIMITED') as phys
JOIN sys.objects as obj on obj.object_id = phys.object_id
JOIN sys.indexes ix ON phys.object_id = ix.object_id AND phys.index_id = ix.index_id
ORDER BY phys.object_id, phys.index_id;



SELECT * FROM sys.indexes
-- Step 3: Note the avg_fragmentation_in_percent returned

-- Step 4: Note that there are choices on the level of detail returned
--         The next choice is SAMPLED.

SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(),NULL,NULL,NULL,'SAMPLED')
ORDER BY avg_fragmentation_in_percent DESC;

-- Step 5: The final choice is DETAILED.
--         Warning: this option can take a long time on large databases

SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(),NULL,NULL,NULL,'DETAILED')
ORDER BY avg_fragmentation_in_percent DESC;


SELECT SCHEMA_NAME(o.schema_id) + '.' + o.name as table_name, i.name as index_name, p.index_level,
p.index_type_desc ,p.alloc_unit_type_desc,
p.* FROM sys.indexes i
INNER JOIN sys.objects o
	ON i.object_id = o.object_id
INNER JOIN sys.dm_db_index_physical_stats(DB_ID(),NULL,NULL,NULL,'DETAILED') p
	ON p.index_id = i.index_id AND p.object_id = i.object_id
ORDER BY table_name, i.name, p.index_level;


SELECT SCHEMA_NAME(o.schema_id) + '.' + o.name as table_name, i.name as index_name, p.index_level,
p.index_type_desc ,p.alloc_unit_type_desc,
p.* FROM sys.indexes i
INNER JOIN sys.objects o
	ON i.object_id = o.object_id
INNER JOIN sys.dm_db_index_physical_stats(DB_ID(),NULL,NULL,NULL,'DETAILED') p
	ON p.index_id = i.index_id AND p.object_id = i.object_id
ORDER BY p.avg_fragmentation_in_percent DESC