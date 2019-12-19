use master;
go

drop database if exists Tournments_CA_Roman;
go

create database Tournaments_CA_Roman;
go

Use Tournaments_CA_Roman;
go

Create Schema Tournaments;
go

create table Tournaments.Participants
(
	ParticipantID int not null primary key,
	ParticipantName varchar(50) not null,
	BirthDate date not null,
	EmailAddress varchar(20) not null,
	Passwords varchar(20)
);
go
select * from Tournaments.Participants

create table Tournaments.Tournaments
(
	EventId int not null primary key,
	EventName varchar(80) not null,
	EventDescription varchar(500) not null,
	Address1 varchar(250),
	DateofEvent date,
	RegistrationCost money,
	SportType varchar(200),
	RegistrationCloseDate date
);
go
select * from Tournaments.Tournaments

create table Tournaments.Registration
(
	ParticipantID int not null,
	EventID int not null,
	AmountPaid money,
	PaymentDate date
);
go
select * from Tournaments.Registration

alter table Tournaments.Participants_Registration
	add constraint FKParticipantID
	foreign key (ParticipantID) references Tournaments.Participants(ParticipantID);
go

alter table Tournaments.Event_Registration
	add constraint FKEventID
	foreign key (EventID) references Tournaments.Tournaments(EventID);
go

alter table Tournaments.Registration
add constraint DFLT_Payment_Date
default (Sysdatetime()) for PaymentDate;
go

alter table Tournaments.Participants
add constraint Birth_Date check (BirthDate >= '12/03/2003');
go

create procedure Tournaments.Tournaments_Update 
	@EventID int,
	@EventName varchar(80)
AS
	Update Tournaments.Tournaments
	set EventName = @EventName
where EventID = @EventID;
go

Create procedure Tournaments.Participants_Delete
	@ParticipantID int,
	@ParticipantName varchar(50)
AS
	delete Tournaments.Participants
	where ParticipantID = @ParticipantID;
go
