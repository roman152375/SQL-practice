CREATE TABLE Examples.SimpleTable
(
	SimpleTableId int not null identity (1,1) primary key,
	Value1 varchar (20) not null,
	Value2 varchar (20) not null
	);

CREATE PROCEDURE Examples.SimpleTable_Insert
@Value1 varchar(20),
@Value2 varchar (20)
as
	INSERT INTO Examples.SimpleTable (Value1, Value2)
	Values (@Value1, @Value2);
	go

EXEC Examples.SimpleTable_Insert 'MY VALUE 1', 'MY VALUE 2';
SELECT * FROM Examples.SimpleTable;
--CREATE STORED PROCEDURES FOR UPDATE AND DELETE
CREATE PROCEDURE Examples.SimpleTable_Update
	@SimpleTableId int,
	@Value1 varchar (20),
	@VAlue2 varchar (20)
AS
	UPDATE Examples.SimpleTable
	SET Value1 = @Value1,
		VAlue2 = @Value2 
		where SimpleTableId = @SimpleTableId
go
EXEC Examples.SimpleTAble_Update 1, 'NEW VALUE 1', 'NEW VALUE 2';
--PARAMETERS???

create procedure Examples.SimpleTable_Delete
	@SimpleTableId int
AS
	delete from Examples.SimpleTable
	where SimpleTableId = @SimpleTableId
GO
EXEC Examples.SimpleTable_Delete 1
--PARAMETERS?

CREATE PROCEDURE Examples.SimpleTableId_Select
as
	select SimpleTableid, Value1, Value2
	from examples.simpleTable
	order by Value1; 

CREATE PROCEDURE Examples.SimpleTable_SelectValueStartWithQorZ
as
	SELECT *
	from Examples.SimpleTable
	where Value1 like 'Q%'
	order by Value1;
	
	select * from Examples.SimpleTable
	where Value1 like 'Z%'
	order by Value1;
go

INSERT INTO Examples.SimpleTable
values ('ZEBRA', 'ALPHA'),('CHARLIE', 'TANGO'),('QUEBEC','BETA');

EXEC Examples.SimpleTable_SelectValueStartWithQorZ;