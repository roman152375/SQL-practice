CREATE TABLE Examples.Gadget
(
	GadgetId int NOT NULL CONSTRAINT PKGadget PRIMARY KEY,
	GadgetNumber char(8) NOT NULL CONSTRAINT AKGadget UNIQUE,
	GadgetType varchar(10) NOT NULL
);
GO

INSERT INTO Examples.Gadget(GadgetId, GadgetNumber, GadgetType)
VALUES (1,'00000001','Electronic'),
		(2,'00000002','Manual'),
		(3,'00000003','Manual');
GO
CREATE VIEW Examples.ElectronicGadget
AS
	SELECT GadgetId, GadgetNumber, GadgetType,
		UPPER(GadgetType) AS UpperGadgetType
	FROM Examples.Gadget
	WHERE GadgetType = 'Electronic';
	GO
	--COMPARISONS
	-- LIKE ( E.G. GADGET TYPE LIKE 'Elec%)
	-- = MEANS EQUAL
	-- < LESSER THAN
	-- > GREATER THAN
	-- <> or != BOTH MEAN 'NOT EQUAL'

	SELECT * FROM Examples.Gadget
	SELECT * FROM Examples.ElectronicGadget

	SELECT ElectronicGadget.GadgetNumber as FromView,
		Gadget.gadgetNumber as FromTable,
		Gadget.GadgetType, ElectronicGadget.UpperGadgetType
	FROM Examples.electronicGadget
		FULL OUTER JOIN Examples.Gadget
		ON ElectronicGadget.GadgetId = Gadget.GadgetId;
GO
INSERT INTO Examples.ElectronicGadget(GadgetId, GadgetNumber, GadgetType)
VALUES (4,'00000004','Electronic'),
		(5,'00000005','Manual');

--Update the row we could  see to values that could not be seen
UPDATE Examples.ElectronicGadget
SET GadgetType = 'Manual'
WHERE GadgetNumber = '00000004';
GO
--Update the row we could NOT see to values that could actually seen
UPDATE Examples.ElectronicGadget
SET GadgetType = 'Electronic'
WHERE GadgetNumber = '00000005';
GO
--Limiting what data can be added to a table through a view through DDL
ALTER VIEW Examples.ElectronicGadget
AS
	SELECT GadgetId, GadgetNumber, GadgetType,
		UPPER(GadgetType) AS UpperGadgetType
	FROM Examples.Gadget
	WHERE GadgetType = 'Electronic'
	WITH CHECK OPTION;
GO

INSERT INTO Examples.ElectronicGadget(GadgetId, GadgetNumber, GadgetType)
VALUES ( 6,'00000006','electronic');
GO




