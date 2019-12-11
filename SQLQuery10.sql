CREATE TABLE Examples.Parent
(
	ParentId int NOT NULL CONSTRAINT PKParent PRIMARY KEY
);
CREATE TABLE Examples.Child
(
	ChildId int NOT NULL CONSTRAINT PKChild PRIMARY KEY,
	ParentId int NULL
);

ALTER TABLE Examples.Child
	ADD CONSTRAINT FKChild_Ref_ExamplesParent
	FOREIGN KEY (ParentId) references Examples.Parent(ParentId);

INSERT INTO Examples.Parent VALUES (10);
INSERT INTO Examples.Child values (1, 10);


	SELECT * from Examples.Child;
	SELECT * From Examples.Parent;

	CREATE TABLE Examples.TwoPartKey
(
		KeyColumn1 int NOT NULL,
		KeyColumn2 int NOT NULL,
		CONSTRAINT PFTwoPartKey PRIMARY KEY (KeyColumn1, KeyColumn2)
);

INSERT INTO Examples.TwoPartKey values (10, 10); --ID = 1010

select * from Examples.TwoPartKey;

CREATE TABLE Examples.TwoPartKeyReference
(
	KeyColumn1 int NULL,
	KeyColumn2 int NULL,
	CONSTRAINT FKTwoPartKeyReference_Ref_ExamplesTwoPartKey
	FOREIGN KEY (KeyColumn1, KeyColumn2)
		references Examples.TwoPartKEy (KeyColumn1, KeyColumn2)
);
INSERT INTO Examples.TwoPartKeyReference values (10, 10);
INSERT INTO Examples.TwoPartKeyReference values (null, null);

select * from Examples.TwoPartKeyReference;

drop table if exists Examples.Invoice;
CREATE TABLE Examples.Invoice
(
	InvoiceId int not null constraint PKInvoice PRIMARY KEY
);
CREATE TABLE Examples.InvoiceLineItem
(
	InvoiceLineItemId int not null constraint PKInvoiceLineItem PRIMARY KEY,
	InvoiceLineNumber smallint not null,
	InvoiceId int not null
	constraint FKInvoiceLineItem_Ref_ExamplesInvoice
		references Examples.invoice(InvoiceId)
		On delete cascade
		on update no action,
		constraint AKInvoiceLineItem Unique (InvoiceId, InvoiceLineNumber)
);
INSERT INTO Examples.Invoice(InvoiceId)
values (1), (2), (3);
INSERT INTO Examples.InvoiceLineItem (InvoiceLineItemId, InvoiceId, InvoiceLineNumber)
values (1,1,1),(2,1,2),(3,2,1);
delete Examples.Invoice
WHERE InvoiceId = 1;

SELECT Invoice.InvoiceId, InvoiceLineItem.InvoiceLineItemId
from Examples.Invoice	
full outer join Examples.invoiceLineItem
on Invoice.InvoiceID = InvoiceLineItem.InvoiceId;

select * from Examples.InvoiceLineItem

CREATE TABLE Examples.Code
(
	Code varchar(10) not null constraint PKCode Primary key
);
CREATE TABLE Examples.CodeItem
(
	Code varchar(10) not null
	constraint FKCodeItem_Ref_ExampleCode
	references Examples.Code (Code)
	on update cascade
	);
INSERT INTO Examples.Code (Code)
VALUES ('Blake');
INSERT INTO Examples.CodeItem (Code)
Values ('Blake')
SELECT Code.Code, CodeItem.Code as CodeItemCode
from Examples.Code
	full outer join Examples.codeItem
	on Code.Code = CodeItem.Code;
	update Examples.Code
	set Code = 'Black';

select * from Examples.CodeItem;

CREATE TABLE Examples.Attendee
(
	ShirtSize varchar(10) null
);
drop table Examples.Attendee;
alter table Examples.Attendee
	ADD constraint CHKAttendee_ShirtSizeDomain
	CHECK (ShirtSize in ('S','M','L','XL','XXL'));
CREATE TABLE Examples.ShirtSize
(
ShirtSize varchar(10) not null constraint PKShirtSize PRIMARY KEY
);
INSERT INTO Examples.ShirtSize(ShirtSize)
values ('S'),('M'),('L'),('XL'),('XXL');

SELECT * FROM Examples.ShirtSize;

alter table examples.Attendee
drop constraint CHKAttendee_ShirtSizeDomain;

alter table Examples.Attendee
add constraint FKAttendee_Ref_ExamplesShirtSize
Foreign key (ShirtSize) references Examples.ShirtSize(ShirtSize);

insert into Examples.Attendee
values ('S');
select * from Examples.Attendee;
insert into examples.Attendee (ShirtSize)
values ('XS');