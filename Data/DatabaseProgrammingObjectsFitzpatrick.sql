
USE MIST353_NFL_Fitzpatrick;
GO
-- three quires one for confdiv, one for team, one for join

--sort by conference division id, then team name
SELECT 
    cd.ConferenceDivisionID,
    cd.Conference,
    cd.Division,
    t.TeamName,
    t.TeamCityState,
    t.TeamColors
FROM ConferenceDivision cd
INNER JOIN Team t
    ON cd.ConferenceDivisionID = t.ConferenceDivisionID
ORDER BY cd.ConferenceDivisionID, t.TeamName;

--sort teams alphabetically by team name, then by conference division id
SELECT 
    TeamID,
    TeamName,
    TeamCityState,
    TeamColors,
    ConferenceDivisionID
FROM Team
ORDER BY TeamName;

--sort by ID number, then by team name
SELECT 
    ConferenceDivisionID,
    Conference,
    Division
FROM ConferenceDivision
ORDER BY ConferenceDivisionID;

--join the two tables together and sort by conference division id, then team name
SELECT 
    cd.Conference,
    cd.Division,
    t.TeamName,
    t.TeamCityState,
    t.TeamColors
FROM Team t
INNER JOIN ConferenceDivision cd
    ON t.ConferenceDivisionID = cd.ConferenceDivisionID
ORDER BY cd.ConferenceDivisionID, t.TeamName;


SELECT TeamName, TeamColors, Conference, Division
FROM Team t
INNER JOIN ConferenceDivision cd
    ON t.ConferenceDivisionID = cd.ConferenceDivisionID
Where Conference = 'AFC' AND Division = 'North';