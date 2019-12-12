CREATE TABLE Examples.Parameter
(
	ParameterId int not null identity(1,1) primary key,
	Value1 varchar(20) not null,
	Value2 varchar(20) not null
);
--Let's see how to use Parameters

CREATE PROCEDURE Examples.Parameter_Insert
	@VAlue1 varchar(20) = 'No entry given',
	@Value2 varchar(20) = 'No entry given'
AS
	set nocount on;
	insert into Examples.Parameter(Value1,Value2)
	values (@Value1, @Value2);
go
--using all defaults
exec Examples.parameter_Insert;

--by posoition, @value1 parameter only
exec Examples.Parameter_Insert 'Some Entry';
--both columns by position
exec Examples.Parameter_Insert 'More Entry', 'More Entry';

exec Examples.Parameter_Insert @Value1 = 'Other Entry';

ALTER PROCEDURE Examples.Parameter_Insert
	@Value1 varchar(20) = 'No entry given',
	@Value2 varchar(20) = 'No entry given' output,
	@NewParameterId int = null output
AS
	set nocount on;
	set @Value1 = UPPER(@Value1);
	set @Value2 = LOWER(@Value2);

	INSERT INTO Examples.Parameter(Value1, Value2)
	values (@Value1, @Value2);
	set @NewParameterId = SCOPE_IDENTITY();
GO
declare @Value1 varchar(20) = 'Test',
		@Value2 varchar(20) = 'Test',
		@NewParameterId int = -200;
exec Examples.Parameter_Insert @Value1 = @Value1,
								@Value2 = @Value2 output,
								@NewParameterId = @NewParameterId output;
select @Value1 as Val1, @Value2 as Val2, @NewParameterId as NewParmId;

select * from Examples.Parameter
where ParameterId = @NewParameterId;

CREATE PROCEDURE SimpleReturnValue
as
	declare @NoOp int;

declare @ReturnCode int;
exec @ReturnCode = SimpleReturnValue;
select @ReturnCode as DefaultReturnCode;

CREATE PROCEDURE DoOperation

	@Value int


--Procedure returns via return code:
--1- successful execution, with 0 entered
-- -1 - invalid, null input
as
	if @Value = 0
	return 1;
	else if @Value is null
	return -1;
	else return 0;
go
declare @ReturnCode int;
exec @ReturnCode = DoOperation null;
select @ReturnCode;

declare @ReturnCode int;
exec @ReturnCode = DoOperation 10;
select @ReturnCode;

declare @ReturnCode int;
exec @ReturnCode = DoOperation 0;
select @ReturnCode;





