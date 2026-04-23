if(OBJECT_ID('AdminChangesTracker') is not null)
    drop TABLE AdminChangesTracker
if(OBJECT_ID('TeamStadium') is not null)
    drop TABLE TeamStadium
if(OBJECT_ID('Game') is not null)
    drop TABLE Game
if(OBJECT_ID('Stadium') is not null)
    drop TABLE Stadium;

if(OBJECT_ID('FanTeam') is not null)
    drop table FanTeam;
if(OBJECT_ID('NFLFan') is not null)
    drop table NFLFan;
if(OBJECT_ID('NFLAdmin') is not null)
    drop table NFLAdmin;
if(OBJECT_ID('Team') is not null)
    drop table Team;
if(OBJECT_ID('ConferenceDivision') is not null)
    drop table ConferenceDivision;
if(OBJECT_ID('AppUser') is not null)
    drop table AppUser;

go

create TABLE ConferenceDivision ( 
    ConferenceDivisionID INT identity(1,1) 
        constraint PK_ConferenceDivision PRIMARY KEY,
    Conference NVARCHAR(50) NOT NULL
        constraint CK_ConferenceNames CHECK (Conference IN ('AFC', 'NFC')),
    Division NVARCHAR(50) NOT NULL
        constraint CK_DivisionNames CHECK (Division IN ('East', 'North', 'South', 'West')),
    constraint UK_ConferenceDivision UNIQUE (Conference, Division)
);

go

create TABLE Team ( 
    TeamID INT identity(1,1) 
        constraint PK_Team PRIMARY KEY,
    TeamName NVARCHAR(50) NOT NULL,
    TeamCityState NVARCHAR(50) NOT NULL,
    TeamColors NVARCHAR(100) NOT NULL,
    ConferenceDivisionID INT NOT NULL
        constraint FK_Team_ConferenceDivision FOREIGN KEY REFERENCES ConferenceDivision(ConferenceDivisionID)
);

GO

create table AppUser(
    AppUserID INT identity(1,1) 
        constraint PK_AppUser PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,   
    Email NVARCHAR(100) NOT NULL,
        CONSTRAINT UK_AppUserEmail UNIQUE,
    PasswordHash VARBINARY(200) NOT NULL,
    PhoneNumber NVARCHAR(20) NULL,
    UserRole NVARCHAR(20) NOT NULL
        constraint CK_AppUserRole CHECK (UserRole IN (N'NFLAdmin', N'NFLFan'))
);

GO

create table NFLFan(
    NFLFanID INT identity(1,1) 
        constraint PK_NFLFan PRIMARY KEY,
        constraint FK_NFLFan_AppUser FOREIGN KEY REFERENCES AppUser(AppUserID),
);

GO

CREATE TABLE NFLAdmin(
    NFLAdminID INT
        constraint PK_NFLAdmin PRIMARY KEY,
        constraint FK_NFLAdmin_AppUser FOREIGN KEY REFERENCES AppUser(AppUserID),
);

GO

create table FanTeam(
    FanTeamID INT identity(1,1) 
        constraint PK_FanTeam PRIMARY KEY,
    NFLFanID INT NOT NULL
        constraint FK_FanTeam_NFLFan FOREIGN KEY REFERENCES NFLFan(NFLFanID),
    TeamID INT NOT NULL
        constraint FK_FanTeam_Team FOREIGN KEY REFERENCES Team(TeamID)
    CONSTRAINT UK_FanTeam Unique (NFLFanID, TeamID),
    PrimaryTeam BIT NOT NULL
);

GO

Create table Stadium(
    StadiumID int identity (1,1)
        CONSTRAINT PK_Stadium 

)