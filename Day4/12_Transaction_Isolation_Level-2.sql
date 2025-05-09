USE db01;

INSERT INTO dbo.Test(id) VALUES(1);

UPDATE dbo.Test SET id=10 WHERE id=1;

DELETE FROM dbo.Test WHERE id = 10;