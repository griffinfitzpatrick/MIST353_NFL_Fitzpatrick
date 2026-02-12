-- create tables for first itterantion.

--use master;

--CREATE DATABASE MIST353_NFL_RDB_Fitzpatrick;


--Drop DATABASE NFL_RDB_Fitzpatrick;

use MIST353_NFL_Fitzpatrick

--Create tables for first iteration


CREATE Table ConferenceDivision
(
    ConferenceDivisionID INT IDENTITY(1,1)
        CONSTRAINT PK_ConferenceDivision PRIMARY KEY,
    Conference NVARCHAR(50) NOT NULL
        CONSTRAINT CK_ConferenceNames CHECK (Conference IN ('AFC', 'NFC')),
    Division NVARCHAR(50) NOT NULL
        CONSTRAINT CK_DivisionNames CHECK (Division IN ('North', 'South', 'East', 'West')),
);


create TABLE Team
(
    TeamID INT identity(1,1) PRIMARY KEY
        CONSTRAINT PK_Team PRIMARY KEY,
    TeamName VARCHAR(50) NOT NULL,
    TeamCityState VARCHAR(50) NOT NULL,
    TeamColors VARCHAR(50) Not Null,
    ConferenceDivisionID INT NOT NULL
        constraint FK_Team_ConferenceDivision FOREIGN KEY REFERENCES Conference,
);

--Insert data
--INSERT ALL CONFDIV DATA (8rows)
--Insert TEam DATA for FC NORTH 4 rows






