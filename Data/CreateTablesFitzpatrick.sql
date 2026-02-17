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
        constraint FK_Team_ConferenceDivision FOREIGN KEY REFERENCES Conference,
);

INSERT INTO ConferenceDivision (Conference, Division)
VALUES
('AFC', 'North'),   -- 1001
('AFC', 'South'),   -- 1002
('AFC', 'East'),    -- 1003
('AFC', 'West'),    -- 1004
('NFC', 'North'),   -- 1005
('NFC', 'South'),   -- 1006
('NFC', 'East'),    -- 1007
('NFC', 'West');    -- 1008

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
VALUES
('Baltimore Ravens', 'Baltimore, MD', 'Purple/Black', 1001),
('Cincinnati Bengals', 'Cincinnati, OH', 'Orange/Black', 1001),
('Cleveland Browns', 'Cleveland, OH', 'Brown/Orange', 1001),
('Pittsburgh Steelers', 'Pittsburgh, PA', 'Black/Gold', 1001);

alter table CConferenceDivision
add constraint UQ_ConferenceDivision UNIQUE (Conference, Division);

/*ALTER TABLE ConferenceDivision
NOCHECK CONSTRAINT CK_ConferenceNames;

ALteR TABLE ConferenceDivision
CHECK CONSTRAINT CK_DivisionNames;*/







