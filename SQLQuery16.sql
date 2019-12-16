CREATE FUNCTION Sales.Customer_RetunOrderCount

(

@CustomerID int,

@OrderDate date = NULL

)

RETURNS INT 

WITH RETURNS NULL ON NULL INPUT, --if all parametersNUL, return Null inmediately

SCHEMABINDING --make certain that the tables/columns referenced cannot change

AS

BEGIN 

DECLARE @OutputValue int

SELECT @OutputValue =COUNT (*)

FROM Sales.Orders

WHERE CustomerID = @CustomerID

AND (OrderDate = @OrderDate)

OR (@OrderDate IS NULL);

RETURN @OutputValue

END;

GO



SELECT Sales.Customer_RetunOrderCount(905, '2013-01-01');

GO



SELECT Sales.Customer_RetunOrderCount(905, DEFAULT);

GO



SELECT CustomerID, Sales.Customer_RetunOrderCount(CustomerID, DEFAULT) AS TotalOrders

FROM Sales.Customers;

GO



CREATE FUNCTION Sales.Orders_ReturnFormattedCPO

(

@CustomerPurchaseOrderNumber nvarchar (20)

)

RETURNS nvarchar(20)

WITH RETURNS NULL ON NULL INPUT,

SCHEMABINDING

AS

BEGIN RETURN (N'CPO' + RIGHT (N'00000000' + @CustomerPurchaseOrderNumber,8));

END;

GO

select Sales.Orders_ReturnFormattedCPO(CustomerPurchaseOrderNumber) as FormattedCPO
from Sales.Orders
go
select OrderId
From Sales.Orders
where Sales.Orders_ReturnFormattedCPO(CustomerPurchaseOrderNumber)= 'CP00019998';
go
select Sales.Orders_ReturnFormattedCPO(CustomerPurchaseOrderNumber)
from Sales.Orders;
go

create function Sales.Customers_ReturnOrderCountSetSimple
(
	@CustomerID int,
	@OrderDate date = null
)
returns table 
as
return (select count(*) as SalesCount,
case when max(backorderOrderId) is not null	then 1 else 0 end as HasBackorderFlag
from Sales.Orders
where CustomerID = @CustomerId
and (OrderDate = @Orderdate
or @OrderDate is null));
go
