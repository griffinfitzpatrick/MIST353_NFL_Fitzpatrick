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
        CONSTRAINT PK_Stadium PRIMARY KEY,
    StadiumName NVARCHAR(100) NOT NULL,
    StadiumCityState NVARCHAR(50) NOT NULL,
    Capacity INT NOT NULL
);

GO

CREATE TABLE TeamStadium(
    TeamStadiumID INT identity(1,1)
        CONSTRAINT PK_TeamStadium PRIMARY KEY,
    TeamID INT NOT NULL
        CONSTRAINT FK_TeamStadium_Team FOREIGN KEY REFERENCES Team(TeamID),
    StadiumID INT NOT NULL
        CONSTRAINT FK_TeamStadium_Stadium FOREIGN KEY REFERENCES Stadium(StadiumID),
    StartYear INT NOT NULL,
    EndYear INT NULL,
    CONSTRAINT UK_TeamStadium UNIQUE (TeamID, StadiumID, StartYear)
);

GO

CREATE TABLE Game(
    GameID INT identity(1,1)
        CONSTRAINT PK_Game PRIMARY KEY,
    GameRound NVARCHAR(50) NOT NULL
        constraint CK_GameRound CHECK (GameRound IN ('Preseason', 'Regular Season', 'Playoffs', 'Super Bowl')),
    GameDate DATE NOT NULL,
    GameStartTime TIME NOT NULL,
    HomeTeamID INT NOT NULL
        CONSTRAINT FK_Game_HomeTeam FOREIGN KEY REFERENCES Team(TeamID),
    AwayTeamID INT NOT NULL
        CONSTRAINT FK_Game_AwayTeam FOREIGN KEY REFERENCES Team(TeamID),
    StadiumID INT NOT NULL
        CONSTRAINT FK_Game_Stadium FOREIGN KEY REFERENCES Stadium(StadiumID)
    HomeTeamScore INT NULL,
    AwayTeamScore INT NULL
    WinningTeamID INT NULL
        CONSTRAINT FK_Game_WinningTeam FOREIGN KEY REFERENCES Team(TeamID)
    CONSTRAINT CK_HomeAwayTeams CHECK (HomeTeamID != AwayTeamID)
    CONSTRAINT UK_Game UNIQUE (GameDate, HomeTeamID, AwayTeamID)
);

GO

CREATE TABLE AdminChangesTracker(
    AdminChangesTrackerID INT identity(1,1)
        CONSTRAINT PK_AdminChangesTracker PRIMARY KEY,
    NFLAdminID INT NOT NULL
        CONSTRAINT FK_AdminChangesTracker_NFLAdmin FOREIGN KEY REFERENCES NFLAdmin(NFLAdminID),
    GamdID INT NULL
        CONSTRAINT FK_AdminChangesTracker_Game FOREIGN KEY REFERENCES Game(GameID),
    ChangeDateTime DATETIME NOT NULL DEFAULT GETDATE(),
    ChnageType NVARCHAR(50) NOT NULL
        constraint CK_ChangeType CHECK (ChangeType IN ('Create', 'Update', 'Delete')),
    ChangeDescription NVARCHAR(500) NOT NULL
);
