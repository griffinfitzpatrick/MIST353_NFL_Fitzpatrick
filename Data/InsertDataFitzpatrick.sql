
use MIST353_NFL_Fitzpatrick;

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
('Baltimore Ravens', 'Baltimore, MD', 'Purple, Black', 1001),
('Cincinnati Bengals', 'Cincinnati, OH', 'Orange, Black', 1001),
('Cleveland Browns', 'Cleveland, OH', 'Brown, Orange', 1001),
('Pittsburgh Steelers', 'Pittsburgh, PA', 'Black, Gold', 1001);

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
VALUES
('Houston Texans', 'Houston, TX', 'Deep Steel Blue, Battle Red, Liberty White', 1002),
('Indianapolis Colts', 'Indianapolis, IN', 'Speed Blue, White', 1002),
('Jacksonville Jaguars', 'Jacksonville, FL', 'Teal, Black, Gold, White', 1002),
('Tennessee Titans', 'Nashville, TN', 'Titans Navy, Titans Light Blue, Titans Red, Titans Silver', 1002);

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
VALUES
('Buffalo Bills', 'Buffalo, NY', 'Royal Blue, Red, White', 1003),
('Miami Dolphins', 'Miami, FL', 'Aqua, Orange, White', 1003),
('New England Patriots', 'Foxborough, MA', 'Navy Blue, Red, Silver, White', 1003),
('New York Jets', 'East Rutherford, NJ', 'Gotham Green, Spotlight White, Stealth Black', 1003);

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
VALUES
('Denver Broncos', 'Denver, CO', 'Broncos Orange, Navy Blue, White', 1004),
('Kansas City Chiefs', 'Kansas City, MO', 'Red, Gold, White', 1004),
('Las Vegas Raiders', 'Las Vegas, NV', 'Silver, Black', 1004),
('Los Angeles Chargers', 'Los Angeles, CA', 'Powder Blue, Sunshine Gold, White', 1004);

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
VALUES
('Chicago Bears', 'Chicago, IL', 'Navy Blue, Orange, White', 1005),
('Detroit Lions', 'Detroit, MI', 'Honolulu Blue, Silver, White', 1005),
('Green Bay Packers', 'Green Bay, WI', 'Dark Green, Gold, White', 1005),
('Minnesota Vikings', 'Minneapolis, MN', 'Purple, Gold, White', 1005);

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
VALUES
('Atlanta Falcons', 'Atlanta, GA', 'Red, Black, White', 1006),
('Carolina Panthers', 'Charlotte, NC', 'Panther Black, Panther Blue, Panther Silver, White', 1006),
('New Orleans Saints', 'New Orleans, LA', 'Old Gold, Black, White', 1006),
('Tampa Bay Buccaneers', 'Tampa, FL', 'Red, Pewter, Orange, White', 1006);

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
VALUES
('Dallas Cowboys', 'Arlington, TX', 'Navy Blue, Metallic Silver, White', 1007),
('New York Giants', 'East Rutherford, NJ', 'Royal Blue, Red, White', 1007),
('Philadelphia Eagles', 'Philadelphia, PA', 'Midnight Green, Silver, Black, White', 1007),
('Washington Commanders', 'Landover, MD', 'Burgundy, Gold, White', 1007);

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
VALUES
('Arizona Cardinals', 'Phoenix, AZ', 'Cardinals Red, White, Black', 1008),
('Los Angeles Rams', 'Los Angeles, CA', 'Rams Royal Blue, Rams Sol, Rams Yellow, White', 1008),
('San Francisco 49ers', 'San Francisco, CA', '49ers Red, 49ers Gold, White', 1008),
('Seattle Seahawks', 'Seattle, WA', 'College Navy, Action Green, Wolf Grey, White', 1008);


GO

SELECT * FROM ConferenceDivision;
GO

-- three quires one for confdiv, one for team, one for join

SELECT 
    cd.ConferenceDivisionID,
    cd.ConferenceName,
    cd.DivisionName,
    t.TeamName,
    t.TeamCityState,
    t.TeamColors
FROM ConferenceDivision cd
INNER JOIN Team t
    ON cd.ConferenceDivisionID = t.ConferenceDivisionID
ORDER BY cd.ConferenceDivisionID, t.TeamName;

SELECT 
    TeamID,
    TeamName,
    TeamCityState,
    TeamColors,
    ConferenceDivisionID
FROM Team
ORDER BY TeamName;

SELECT 
    ConferenceDivisionID,
    ConferenceName,
    DivisionName
FROM ConferenceDivision
ORDER BY ConferenceDivisionID;


SELECT 
    cd.ConferenceName,
    cd.DivisionName,
    t.TeamName,
    t.TeamCityState,
    t.TeamColors
FROM Team t
INNER JOIN ConferenceDivision cd
    ON t.ConferenceDivisionID = cd.ConferenceDivisionID
ORDER BY cd.ConferenceDivisionID, t.TeamName;
