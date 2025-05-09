USE AdventureWorksDW


EXEC sp_spaceused 'dbo.FactProductInventory'
GO

CREATE NONCLUSTERED COLUMNSTORE INDEX NCCI_FactProductInventory ON dbo.FactProductInventory
(
	ProductKey,
	DateKey,
	MovementDate,
	UnitCost,
	UnitsIn,
	UnitsOut,
	UnitsBalance
)WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)

GO

/*
name					rows	reserved	data		index_size	unused
FactProductInventory	776286  49512 KB	45552 KB	536 KB		3424 KB
FactProductInventory	776286  53680 KB	45552 KB	4600 KB		3528 KB

*/
EXEC sp_spaceused 'dbo.FactProductInventory'