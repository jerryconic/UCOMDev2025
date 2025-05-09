USE Northwind;

EXEC sp_help 'dbo.Employees';
EXEC sp_helptext 'dbo.[Current Product List]';
EXEC sp_help 'dbo.P1';
EXEC sp_helptext 'dbo.P1';
EXEC sp_help 'dbo.P2';
EXEC sp_helptext 'dbo.P2';
EXEC sp_help 'dbo.P3';
EXEC sp_helptext 'dbo.P3';



EXEC sp_databases;
EXEC sp_tables  @table_owner='dbo';
EXEC sp_columns @table_owner='dbo', @table_name='%';
EXEC sp_columns @table_owner='dbo', @table_name='Employees';

EXEC sp_configure;

EXEC sp_refreshview 'dbo.[Current Product List]';

EXEC sp_updatestats;