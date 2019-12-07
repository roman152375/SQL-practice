DROP TABLE IF EXISTS Examples.Widget;

CREATE TABLE Examples.Widget
(
WidgetId int CONSTRAINT PKWidget2 PRIMARY KEY,
RowLastModifiedTime DATETIME2(0) NOT NULL
);

INSERT INTO Examples.Widget (WidgetId) VALUES (2);
SELECT * FROM Examples.Widget

ALTER TABLE Examples.Widget 
ADD CONSTRAINT DFLT_Widget_RowLastModifiedTime
DEFAULT (SYSDATETIME()) FOR RowLastModifiedTime;

INSERT INTO 
