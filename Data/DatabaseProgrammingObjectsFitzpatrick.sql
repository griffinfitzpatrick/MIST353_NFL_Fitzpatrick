/*
1. User searches for teams using Conference name (optional) and / or Division name (optional)
To show: TeamName, ConferenceName, DivisionName
*/

go


create or alter procedure procGetTeamsByConferenceDivision
(
    @ConferenceName NVARCHAR(50) = null,
    @DivisionName NVARCHAR(50) = null
)
AS
begin
    select TeamName, TeamColors, Conference, Division
    from Team T inner join ConferenceDivision C
        on T.ConferenceDivisionID = C.ConferenceDivisionID
    where Conference = IsNull(@ConferenceName, Conference)
        and Division = IsNull(@DivisionName, Division)
end
/*
execute procGetTeamsByConferenceDivision
    @ConferenceName = 'AFC',
    @DivisionName = 'North';
*/


go

create OR alter procedure procGetTeamsInSameConferenceDivisionAsSpecifiedTeam
(
    @TeamName NVARCHAR(50)
)
AS
BEGIN
    select OtherTeam.TeamName, CD.Conference, CD.Division
    from Team MyTeam inner join Team OtherTeam
        on MyTeam.ConferenceDivisionID = OtherTeam.ConferenceDivisionID
        inner join ConferenceDivision CD
        on MyTeam.ConferenceDivisionID = CD.ConferenceDivisionID
    where MyTeam.TeamName = @TeamName and
        OtherTeam.TeamName != @TeamName;
END
-- execute procGetTeamsInSameConferenceDivisionAsSpecifiedTeam @TeamName = 'Baltimore Ravens';

GO

create or alter procedure procValidateUser
(
    @Email NVARCHAR(100),
    @PasswordHash NVARCHAR(200)
)
AS
BEGIN
    select AppUserID, FirstName + ' ' + LastName as FullName, UserRole
    from AppUser
    where Email = @Email and
    PasswordHash =Convert(varbinary(200), @PasswordHash, 1);
END
-- execute procValidateUser @Email = 'tom.brady@example.com', @Password = 0x01;
--select * from AppUser;

GO

/* CREATE OR ALTER PROCEDURE procGetTeamsForSpecifiedFan
(
    @NFLFanID INT)
AS
BEGIN
    SELECT        T.TeamName, CD.Conference, CD.Division
    FROM NFLFan F
        INNER JOIN Team T
            ON FT.TeamID = T.TeamID
        INNER JOIN ConferenceDivision CD
            ON T.ConferenceDivisionID = CD.ConferenceDivisionID
    WHERE F.NFLFanID = @NFLFanID;
END; */
--execute procGetTeamsForSpecififedFan @NFLFanID = 1;
--execute procGetTeamsForSpecififedFan @NFLFanID = 2;


CREATE OR ALTER PROCEDURE procGetTeamsByFanID
(
    @NFLFanID INT
)
AS
BEGIN
    SELECT T.TeamName, CD.Conference, CD.Division, T.TeamColors, FT.PrimaryTeam
    FROM FanTeam FT inner join Team TABLE
        on FT.TeamID = Team.TeamID
        inner join ConferenceDivision CD
        on Team.ConferenceDivisionID = CD.ConferenceDivisionID
    where FT.NFLFanID = @NFLFanID;
END

--execute procGetTeamsByFanID @NFLFanID = 1;
--execute procGetTeamsByFanID @NFLFanID = 2;
--execute procGetTeamsByFanID @NFLFanID = 3;

GO

CREATE or alter procedure procScheduleGame
(
    @HomeTeamID INT,
    @AwayTeamID INT,
    @GameRound NVARCHAR(20),
    @GameDateTime DATETIME,
    @GameStartTime DATETIME,
    @StadiumID INT
    @NFLAdminID INT
)
AS
BEGIN
    --store the NFL ADMIN in context so that the trigger can access it when inserting into AdminChangesTracker
    declare @context Varbinary(128) = convert(varbinary(128));
    set context_info @context;

    insert into Game (HomeTeamID, AwayTeamID, GameRound, GameDateTime, GameStartTime, StadiumID)
    values (@HomeTeamID, @AwayTeamID, @GameRound, @GameDateTime, @GameStartTime, @StadiumID);
END

GO

--trigger to track changes made by NFLADMIN to the Game table
-- 1 triggering event insert update delete on game table
-- 2 action insert a record into adminchangestracker with NFLAdminID, GameID, HCnageType, ChangeDescription

CREATE OR ALTER TRIGGER trgTrackChangesOnSchedulingGame
ON Game
after INSERT
AS
BEGIN
    declare @NFLAdminID INT;
    declare @GameID INT;
    declare @ChangeType NVARCHAR(20);
    declare @ChangeDescription NVARCHAR(200);
    declare @GameRound NVARCHAR(20);
    declare @GameDateTime DATETIME;
    declare @GameStartTime DATETIME;
    DECLARE @HomeTeamID INT;
    DECLARE @AwayTeamID INT;
    DECLARE @HomeTeamName NVARCHAR(50);
    DECLARE @AwayTeamName NVARCHAR(50);

    --get the NFLAdminID from context
    select @NFLAdminID = convert(INT, context_info());

    --get the GameID from the inserted record
    select @GameID = GameID, @GameRound = GameRound, @GameDateTime = GameDateTime, @GameStartTime = GameStartTime
        @HomeTeamID = HomeTeamID, @AwayTeamID = AwayTeamID
    from inserted;
    SELECT @HomeTeamName = TeamName FROM Team WHERE TeamID = @HomeTeamID;
    SELECT @AwayTeamName = TeamName FROM Team WHERE TeamID = @AwayTeamID;
    SELECT @StadiumName = StadiumName FROM Stadium WHERE StadiumID = @StadiumID;

    set @ChangeType = 'Insert';
    set @ChangeDescription = 'Scheduled a new game with GameID ' + cast(@GameID as NVARCHAR(20));
    set @ChangeDescription = @ChangeDescription + ' between ' + @HomeTeamName + ' and ' + @AwayTeamName;
        + ': ' @HomeTeamName + 'vs' + @AwayTeamName + ' on ' + cast(@GameDateTime as NVARCHAR(30))
        + ' at ' + cast(@GameStartTime as NVARCHAR(30)) + ' in stadium ' + cast(@StadiumName as NVARCHAR(50));
        + '. Game round: ' + @GameRound + '.';

    insert into AdminChangesTracker (NFLAdminID, GameID, ChangeType, ChangeDescription)
    values (@NFLAdminID, @GameID, @ChangeType, @ChangeDescription);
END
