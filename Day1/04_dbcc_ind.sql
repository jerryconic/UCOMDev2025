USE AdventureWorks2019;

SELECT * FROM Person.Person;

dbcc ind('AdventureWorks2019', 'Person.Person', -1);

dbcc traceon(3604)
dbcc page('AdventureWorks2019', 1, 1176, 0) --Header Only
dbcc page('AdventureWorks2019', 1, 1176, 1) --Dump by row
dbcc page('AdventureWorks2019', 1, 1176, 2) --Dump by page
dbcc page('AdventureWorks2019', 1, 1176, 3) --Dump Detail