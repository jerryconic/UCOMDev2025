select 
	CONCAT(SCHEMA_NAME(tbl.schema_id) , '.', tbl.name)
		 as TableName,
    prop.value as Descs,
    col.name as ColumnName,
	sep.value as Descs,
	CASE 
	WHEN typ.name IN ('char','varchar','binary','varbinary') THEN 
		CONCAT(typ.name, '(', IIF(col.max_length=-1, 'MAX', CAST(col.max_length as varchar)), ')')
	WHEN typ.name IN ('nchar','nvarchar') THEN 
		CONCAT(typ.name, '(', IIF(col.max_length=-1, 'MAX', CAST(col.max_length/2 as varchar)), ')')	
	WHEN typ.name IN ('decimal', 'numeric') THEN
		CONCAT(typ.name, '(', col.Precision, ',', col.scale, ')')
	ELSE
		typ.name
	END as DataType	
FROM sys.tables tbl
INNER JOIN sys.columns col 
    ON col.object_id = tbl.object_id
INNER JOIN sys.types typ  
	on col.user_type_id = typ.user_type_id
LEFT JOIN sys.extended_properties prop 
    ON prop.major_id = tbl.object_id
    AND prop.minor_id = 0
    AND prop.name = 'MS_Description' 
left join sys.extended_properties sep on tbl.object_id =  sep.major_id
                                         and col.column_id = sep.minor_id
                                         and sep.name = 'MS_Description'
WHERE tbl.type = 'U'
ORDER BY tbl.object_id, col.column_id
