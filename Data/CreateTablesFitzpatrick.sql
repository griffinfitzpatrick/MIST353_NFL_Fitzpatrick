-- create tables for first itterantion.

--use master;

--CREATE DATABASE MIST353_NFL_RDB_Fitzpatrick;


--Drop DATABASE NFL_RDB_Fitzpatrick;

use MIST353_NFL_Fitzpatrick

--Create tables for first iteration


if(OBJECT_ID('Team') IS NOT NULL)
    DROP TABLE Team;

if(OBJECT_ID('ConferenceDivision') IS NOT NULL)
    DROP TABLE ConferenceDivision;

GO

CREATE Table ConferenceDivision
(
    ConferenceDivisionID INT IDENTITY(1,1)
        CONSTRAINT PK_ConferenceDivision PRIMARY KEY,
    Conference NVARCHAR(50) NOT NULL
        CONSTRAINT CK_ConferenceNames CHECK (Conference IN ('AFC', 'NFC')),
    Division NVARCHAR(50) NOT NULL
        CONSTRAINT CK_DivisionNames CHECK (Division IN ('North', 'South', 'East', 'West')),
    CONSTRAINT UQ_ConferenceDivision UNIQUE (Conference, Division)

);


create TABLE Team
(
    TeamID INT identity(1,1) PRIMARY KEY
        CONSTRAINT PK_Team PRIMARY KEY,
    TeamName VARCHAR(50) NOT NULL,
    TeamCityState VARCHAR(50) NOT NULL,
    TeamColors VARCHAR(50) Not Null,
    ConferenceDivisionID INT NOT NULL
        constraint FK_Team_ConferenceDivision FOREIGN KEY REFERENCES ConferenceDivision(ConferenceDivisionID),
);


alter table CConferenceDivision
add constraint UQ_ConferenceDivision UNIQUE (Conference, Division);

/*ALTER TABLE ConferenceDivision
NOCHECK CONSTRAINT CK_ConferenceNames;

ALteR TABLE ConferenceDivision
CHECK CONSTRAINT CK_DivisionNames;*/







