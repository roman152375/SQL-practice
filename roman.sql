CREATE SCHEMA Examples;
GO

CREATE TABLE Examples.UniquenessConstraint
(
	PrimaryUniqueValue int NOT NULL,
	AlternateuniqueValue1 int NULL,
	AlternateUniqueValue2 int NULL
	);

ALTER TABLE Examples.UniquenessConstraint
	ADD CONSTRAINT PKUniquenessConstraint PRIMARY KEY
	(PrimaryUniqueValue);
	
CREATE TABLE Examples.Invoice
(
	InvoiceId int NOT NULL CONSTRAINT PKInvoice PRIMARY KEY,
	);
CREATE TABLE Examples.DiscountType
(
	DiscountTypeId int NOT NULL CONSTRAINT PKDiscountType PRIMARY KEY,
	--other columns omitted
	)
CREATE TABLE Examples.InvoiceLineItem
(
	InvoicelineItemId int NOT NULL CONSTRAINT PKInvoiceLineItem PRIMARY KEY,
	InvoiceId int NOT NULL
		CONSTRAINT PKInvoiceLineItem$Ref$Invoice
			REFERENCES Examples.Invoice (InvoiceId),
		DiscountTypeId int NOT NULL
			CONSTRAINT PKInvoicelineItem$Ref$DiscountType
				REFERENCES Examples.discountType (DiscountTypeId)
		--other columns omitted
	);
	CREATE INDEX InvoiceId ON Examples.InvoiceLineItem (InvoiceId);

