CREATE DATABASE MyNewDatabase;
GO

CREATE SCHEMA MyCategory1;
GO

CREATE TABLE MyCategory1.NewTableName (
	MyTableId int PRIMARY KEY,
	SomeTextvalue varchar (100) NOT NULL,
	SomeIntvalue int NULL
	)
GO

ALTER TABLE MyCategory1.NewtableName (
	ADD NewValue varchar(100) NOT NULL
)
GO
-- CREATE INDEX
-- CREATE VIEWS

SELECT * FROM Mycategory1.NewTablename;