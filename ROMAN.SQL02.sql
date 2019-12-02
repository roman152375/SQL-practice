SELECT * FROM Sales.Orders
SELECT *
FROM Sales.CustomerTransactions
WHERE PaymentMethodID = 4;
SELECT CustomerID, OrderID, OrderDate, ExpectedDeliveryDate
FROM Sales.Orders
WHERE CustomerPurchaseOrderNumber ='16374'
SELECT SalespersonPersonId, OrderDate
FROM Sales.orders
ORDER BY SalespersonPersonID ASC, OrderDate DESC;
CREATE INDEX SalespersonPersonID_OrderDate1 ON sales.Orders
(SalespersonPersonID ASC, OrderDate DESC);
SELECT Orders.ContactPersonID, People.PreferredName
FROM sales.Orders
	JOIN Application.People
		ON People.PersonID = Orders.ContactPersonID
WHERE PreferredName= 'Aakriti';
CREATE NONCLUSTERED INDEX ContactPersonID_Include_Orderdate_expectedDeliveryDate
ON Sales.Orders ( ContactPersonID)
INCLUDE (Orderdate, ExpectedDeliveryDate)
ON USERDATA;
GO

