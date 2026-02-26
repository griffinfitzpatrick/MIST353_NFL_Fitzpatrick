
--use master;
--GO


-- Use the correct database





USE MIST353_NFL_Fitzpatrick;
GO

-- Drop tables if they already exist
IF OBJECT_ID('Team', 'U') IS NOT NULL DROP TABLE Team;
IF OBJECT_ID('ConferenceDivision', 'U') IS NOT NULL DROP TABLE ConferenceDivision;
GO

-- Create ConferenceDivision table
CREATE TABLE ConferenceDivision
(
    ConferenceDivisionID INT IDENTITY(1001,1)
        CONSTRAINT PK_ConferenceDivision PRIMARY KEY,
    Conference NVARCHAR(50) NOT NULL
        CONSTRAINT CK_Conference CHECK (Conference IN ('AFC', 'NFC')),
    Division NVARCHAR(50) NOT NULL
        CONSTRAINT CK_Division CHECK (Division IN ('North', 'South', 'East', 'West')),
    CONSTRAINT UQ_ConferenceDivision UNIQUE (Conference, Division)
);
GO

-- Create Team table
CREATE TABLE Team
(
    TeamID INT IDENTITY(1,1)
        CONSTRAINT PK_Team PRIMARY KEY,
    TeamName VARCHAR(50) NOT NULL,
    TeamCityState VARCHAR(50) NOT NULL,
    TeamColors VARCHAR(100) NOT NULL,  -- increased size to fix truncation
    ConferenceDivisionID INT NOT NULL
        CONSTRAINT FK_Team_ConferenceDivision FOREIGN KEY REFERENCES ConferenceDivision(ConferenceDivisionID)
);
GO






