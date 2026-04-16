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

CREATE OR ALTER PROCEDURE procGetTeamsForSpecifiedFan
(
    @NFLFanID INT
)
AS
BEGIN
    SELECT 
        T.TeamName, CD.Conference, CD.Division
    FROM NFLFan F
        INNER JOIN FanTeam FT
            ON F.NFLFanID = FT.NFLFanID
        INNER JOIN Team T
            ON FT.TeamID = T.TeamID
        INNER JOIN ConferenceDivision CD
            ON T.ConferenceDivisionID = CD.ConferenceDivisionID
    WHERE F.NFLFanID = @NFLFanID;
END;

--execute procGetTeamsForSpecififedFan @NFLFanID = 1;
--execute procGetTeamsForSpecififedFan @NFLFanID = 2;

create or alter PROCEDURE procGetTeamsByFanID
(
    @FanID INT
)

AS
BEGIN
    SELECT T.TeamName, CD.Conference, CD.Division
    FROM Team T
        INNER JOIN ConferenceDivision CD
            ON T.ConferenceDivisionID = CD.ConferenceDivisionID
        INNER JOIN FanTeam FT
            ON T.TeamID = FT.TeamID
        INNER JOIN NFLFan F
            ON FT.NFLFanID = F.NFLFanID
    WHERE F.NFLFanID = @FanID;
END