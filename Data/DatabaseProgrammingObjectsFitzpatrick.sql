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