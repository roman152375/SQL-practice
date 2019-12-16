CREATE PROCEDURE Examples.Handlingerrors1

AS

DECLARE @NoOp int = 0;

THROW 50000, 'An error has occurred!', 1

GO



CREATE PROCEDURE Examples.StopBatchError1

AS

DECLARE @NoOp int = 100;

THROW 50000, 'Batche Stopped!', 1;

SELECT @NoOp, SYSDATETIME();

GO



CREATE PROCEDURE Examples.ContinueBatchError1

AS

DECLARE @NoOp int = 100;

RAISERROR ('Batch Continued!', 16, 1);

SELECT @NoOp, SYSDATETIME();

GO



EXEC Examples.StopBatchError1

EXEC Examples.ContinueBatchError1



CREATE TABLE Examples.Worker

(

WorkerId int NOT NULL IDENTITY(1,1) CONSTRAINT PKWorker PRIMARY KEY,

WorkerName nvarchar (50) NOT NULL CONSTRAINT AKWorker UNIQUE

);

CREATE TABLE Examples.WorkerAssignment

(

WorkerAssigment int IDENTITY(1,1) CONSTRAINT PKWorkerAssignment PRIMARY KEY,

WorkerId int NOT NULL,

CompanyName nvarchar(50) NOT NULL

CONSTRAINT CHKWorkerAssignment_CompayName

CHECK (CompanyName <> 'Contoso, Ltd'),

CONSTRAINT AKWorkerAssignment UNIQUE (WorkerId, CompanyName)

);

GO



DROP CREATE PROCEDURE Examples.Worker_AddWithAssignment



CREATE PROCEDURE Examples.Worker_AddWithAssignment

@WorkerName nvarchar(50),

@CompanyName nvarchar(50)

AS

SET NOCOUNT ON;

--do any non-data testind before starting the transaction

IF @WorkerName IS NULL or @CompanyName IS NULL

THROW 50000, 'Both parameters must be not null',1;



DECLARE @Location nvarchar(30), @NewWorkerId int;

BEGIN TRY

BEGIN TRANSACTION;



SET @Location = 'Creating Worker Row';

INSERT INTO Examples.Worker(WorkerName)

VALUES (@WorkerName);



SELECT @NewWorkerId = SCOPE_IDENTITY(),

@Location = 'Creating WorkAssignment row';



INSERT INTO Examples.WorkerAssignment(WorkerId, CompanyName)

VALUES (@NewWorkerId, @CompanyName);



COMMIT TRANSACTION;

END TRY

BEGIN CATCH

--at the end of the call, we want the transaction rolled back

--rollback the transaction first, so it definitely occurs as the THROW

--statement would keep it from happneing

IF XACT_STATE() <> 0 --if the is a transaction in effec

--comitable or not

ROLLBACK TRANSACTION;



--format a message that tells the error and the throw it.

DECLARE @ErrorMeassage nvarchar(4000);

SET @ErrorMeassage = CONCAT ('Error occurred during: ''',@Location,'''','System Error:',ERROR_NUMBER(),':', ERROR_MESSAGE());



THROW 50000, @ErrorMessage, 1;

END CATCH;

GO