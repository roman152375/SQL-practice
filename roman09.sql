DROP TABLE If exists Examples.gadget;


CREATE TABLE Examples.Gadget
(
	GadgetId int IDENTITY(1,1) NOT NULL CONSTRAINT PKGadget PRIMARY KEY,
	GadgetCode varchar(10) NOT NULL
);

INSERT INTO Examples.Gadget (GadgetCode)
VALUES ('LENOVO-101');

DELETE FROM Examples.Gadget WHERE GadgetId in (2,3);

ALTER TABLE Examples.Gadget ADD CONSTRAINT AKGadget UNIQUE (GadgetCode);

SELECT * FROM Examples.Gadget;



CREATE TABLE Examples.GroceryItem
(
	ItemId int IDENTITY(1,1) PRIMARY KEY,
	ItemDescr varchar(200) NOT NULL,
	ItemCost smallmoney NULL,
	CONSTRAINT CHKGroceryItem_ItemCostRange CHECK (ItemCost > 0 AND ItemCost <1000)
);
SELECT * FROM Examples.GroceryItem; 


CREATE TABLE Examples.Message
(
	MessageTag char(5) NOT NULL,
	Comment nvarchar(MAX) NULL
);

ALTER TABLE Examples.Message
	ADD CONSTRAINT CHKMessage_MessageTagformat
	CHECK (MessageTag LIKE '[A-Z]-[0-9][0-9][0-9]');

ALTER TABLE Examples.Message
ADD CONSTRAINT CHKMessage_CommentNotempty
CHECK (LEN(Comment) >0);

INSERT INTO Examples.Message (MessageTag, Comment)
VALUES ('A-001', 'This is a comment');

Select * from Examples.Message;
