GO

insert into ConferenceDivision (Conference, Division)
values ('AFC', 'North'),
       ('AFC', 'South'),
       ('AFC', 'East'),
       ('AFC', 'West'),
       ('NFC', 'North'),
       ('NFC', 'South'),
       ('NFC', 'East'),
       ('NFC', 'West');

GO
--select * from ConferenceDivision order by ConferenceDivisionID;

GO
insert into Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
VALUES
('Baltimore Ravens', 'Baltimore, MD', 'Purple, Black, Metallic Gold', 1),
('Cincinnati Bengals', 'Cincinnati, OH', 'Black, Orange, White', 1),
('Cleveland Browns', 'Cleveland, OH', 'Brown, Orange, White', 1),
('Pittsburgh Steelers', 'Pittsburgh, PA', 'Black, Gold, White', 1),

('Houston Texans', 'Houston, TX', 'Deep Steel Blue, Battle Red, Liberty White', 2),
('Indianapolis Colts', 'Indianapolis, IN', 'Speed Blue, White', 2),
('Jacksonville Jaguars', 'Jacksonville, FL', 'Teal, Black, Gold, White', 2),
('Tennessee Titans', 'Nashville, TN', 'Titans Navy, Titans Blue, Red, Silver', 2),

('Buffalo Bills', 'Buffalo, NY', 'Royal Blue, Red, White', 3),
('Miami Dolphins', 'Miami, FL', 'Aqua Green, Orange, White', 3),
('New England Patriots', 'Foxborough, MA', 'Navy Blue, Red, Silver, White', 3),
('New York Jets', 'East Rutherford, NJ', 'Gotham Green, Spotlight White, Stealth Black', 3),

('Denver Broncos', 'Denver, CO', 'Broncos Orange, Navy Blue, White', 4),
('Kansas City Chiefs', 'Kansas City, MO', 'Red, Gold, White', 4),
('Las Vegas Raiders', 'Las Vegas, NV', 'Silver and Black', 4),
('Los Angeles Chargers', 'Los Angeles, CA', 'Powder Blue, Sunshine Gold, White', 4),

('Chicago Bears', 'Chicago, IL', 'Navy Blue, Orange, White', 5),
('Detroit Lions', 'Detroit, MI', 'Honolulu Blue, Silver, White', 5),
('Green Bay Packers', 'Green Bay, WI', 'Dark Green, Gold, White', 5),
('Minnesota Vikings', 'Minneapolis, MN', 'Purple, Gold, White', 5),

('Atlanta Falcons', 'Atlanta, GA', 'Red, Black, Silver, White', 6),
('Carolina Panthers', 'Charlotte, NC', 'Black, Panther Blue, Silver, White', 6),
('New Orleans Saints', 'New Orleans, LA', 'Old Gold, Black, White', 6),
('Tampa Bay Buccaneers', 'Tampa Bay, FL', 'Red, Pewter, Black, Orange, White', 6),

('Dallas Cowboys', 'Dallas, TX', 'Navy Blue, Metallic Silver, White', 7),
('New York Giants', 'East Rutherford, NJ', 'Royal Blue, Red, White', 7),
('Philadelphia Eagles', 'Philadelphia, PA', 'Midnight Green, Silver Metallic, Black Metallic, White', 7),
('Washington Commanders', 'Washington D.C.', 'Burgundy, Gold', 7),

('Arizona Cardinals', 'Phoenix, AZ', 'Red, Black, White', 8),
('Los Angeles Rams', 'Los Angeles, CA', 'Royal Blue, Silver, Gold', 8),
('San Francisco 49ers', 'San Francisco, CA', 'Scarlet, Gold', 8),
('Seattle Seahawks', 'Seattle, WA', 'College Navy, Action Green', 8);

--select * from Team order by TeamID;

GO

insert into AppUser (Firstname, Lastname, Email, Phone, PasswordHash, UserRole)
VALUES
('Tom', 'Brady', 'tom.brady@example.com', '555-1234', 0x01, N'NFLFan'),
('Aaron', 'Rodgers', 'aaron.rodgers@example.com', '555-9012', 0x01, N'NFLFan'),
('Drew', 'Brees', 'drew.brees@example.com', '555-2222', 0x01, N'NFLFan'),
('Patrick', 'Mahomes', 'patrick.mahomes@example.com', '555-7890', 0x01, N'NFLFan'),

('Bill', 'Belichick', 'bill.belichick@example.com', '555-5678', 0x01, N'NFLAdmin'),
('Sean', 'McVay', 'sean.mcay@example.com', '555-3456', 0x01, N'NFLAdmin'),
('Mike', 'Tomlin', 'mike.tomlin@example.com', '555-1111', 0x01, N'NFLAdmin'),
('Andy', 'Reid', 'andy.reid@example.com', '555-3333', 0x01, N'NFLAdmin');

GO

insert into NFLFan (NFLFanID)
VALUES
(1),
(2),
(3),
(4);

GO

insert into NFLAdmin (NFLAdminID)
VALUES
(5),
(6),
(7),
(8);

GO

insert into FanTeam (NFLFanID, TeamID, PrimaryTeam)
VALUES
(1, 11, 1),
(1, 24, 0), -- Tom Brady is a fan of New England Patriots and Tampa Bay Buccaneers, but Patriots is his primary team
(2, 19, 1), 
(2, 12, 0),
(2, 4, 0),-- Aaron Rodgers is a fan of Green Bay Packers, New York Jets, and Pittsburgh Steelers, but Packers is his primary team
(3, 3, 1), -- Drew Brees is a fan New Orleans Saints (primary) and Los Angeles Chargers
(3, 16, 0),
(4, 14, 1); -- Patrick Mahomes is a fan of Kansas City Chiefs (primary)

GO

Insert Into Stadium (StadiumName, Location, Capacity) VALUES
('M&T Bank Stadium', 'Baltimore, MD', 71008),
('Paul Brown Stadium', 'Cincinnati, OH', 65535),
('FirstEnergy Stadium', 'Cleveland, OH', 67394),
('Heinz Field', 'Pittsburgh, PA', 68400),
('NRG Stadium', 'Houston, TX', 71018),
('Lucas Oil Stadium', 'Indianapolis, IN', 67000),
('TIAA Bank Field', 'Jacksonville, FL', 67500),
('Nissan Stadium', 'Nashville, TN', 69143),
('Highmark Stadium', 'Buffalo, NY', 71608),
('Hard Rock Stadium', 'Miami, FL', 65326),
('Gillette Stadium', 'Foxborough, MA', 65878),
('MetLife Stadium', 'East Rutherford, NJ', 82500),
('Empower Field at Mile High', 'Denver, CO', 76125),
('Arrowhead Stadium', 'Kansas City, MO', 76416),
('Allegiant Stadium', 'Las Vegas, NV', 65000),
('SoFi Stadium', 'Los Angeles, CA', 70000),
('Soldier Field', 'Chicago, IL', 61500),
('Ford Field', 'Detroit, MI', 65000),
('Lambeau Field', 'Green Bay, WI', 81441),
('U.S. Bank Stadium', 'Minneapolis, MN', 66620),
('Mercedes-Benz Stadium', 'Atlanta, GA', 71000),
('Bank of America Stadium', 'Charlotte, NC', 75000),
('Caesars Superdome', 'New Orleans, LA', 73000),
('Raymond James Stadium', 'Tampa Bay, FL', 65890),
('AT&T Stadium', 'Dallas, TX', 80000),
('Lincoln Financial Field', 'Philadelphia, PA', 69000),
('FedExField','Washington D.C.',82000), 
('State Farm Stadium','Glendale, AZ' ,63500), 
('SoFi Stadium','Inglewood, CA' ,70000), 
('Levi Stadium','Santa Clara, CA' ,68500), 
('Lumen Field','Seattle, WA' ,68000);



--select * from Stadium order by StadiumID;

Insert Into TeamStadium
(TeamID, StadiumID, StartYear, EndYear)
VALUES
-- Baltimore Ravens
(1, 1, 1998, NULL),
-- Cincinnati Bengals
(2, 2, 2000, NULL),
-- Cleveland Browns
(3, 3, 1999, NULL),
-- Pittsburgh Steelers
(4, 4, 2001, NULL),
-- Houston Texans
(5, 5, 2002, NULL),
-- Indianapolis Colts
(6, 6, 2008, NULL),
-- Jacksonville Jaguars
(7, 7, 1995, NULL),
-- Tennessee Titans
(8, 8, 1999, NULL),
-- Buffalo Bills
(9, 9, 1973, NULL),
-- Miami Dolphins
(10, 10, 1987, NULL),
-- New England Patriots
(11, 11, 2002, NULL),
-- New York Jets
(12, 12, 2010, NULL),
-- Denver Broncos
(13, 13, 2001, NULL),
-- Kansas City Chiefs
(14, 14, 1972, NULL),
-- Las Vegas Raiders
(15, 15, 2020, NULL),
-- Los Angeles Chargers
(16, 16, 2020, NULL),
-- Chicago Bears
(17, 17, 1971, NULL),
-- Detroit Lions
(18, 18, 2002, NULL),
-- Green Bay Packers
(19, 19, 1957, NULL),
-- Minnesota Vikings
(20, 20, 2016, NULL),
-- Atlanta Falcons
(21, 21, 2017, NULL),
-- Carolina Panthers
(22, 22, 2014, NULL),
-- New Orleans Saints
(23, 23, 1975, NULL),
-- Tampa Bay Buccaneers
(24, 24, 1998, NULL),
-- Dallas Cowboys
(25, 25, 2009, NULL),
-- New York Giants
(26, 12, 2010, NULL),
-- Philadelphia Eagles
(27, 27, 2003, NULL),
-- Washington Commanders
(28, 28, 1997, NULL),
-- Arizona Cardinals
(29, 29, 2006, NULL),
-- Los Angeles Rams
(30, 30, 2020, NULL),
-- San Francisco 49ers
(31, 31, 2014, NULL),
-- Seattle Seahawks
(32, 32, 2002, NULL);









GO

--select * from AdminChangesTracker
--select * from Game
--select N.NFLAdminID, U.Firstname, U.Lastname, from NFLAdmin N inner join AppUser U on N.NFLAdminID = U.AppUserID

/*
--======================
-- WILD CARD ROUND (January 10-12, 2026)
--======================

--Satuday, January 10, 2026 (5) LA Rams at (4) Dallas Cowboys
--Rams win 34-31
Gameround: 'Wild Card', HomeTeamID: 22, AwayTeamID: 30, GameDate: '2026-01-10', GameStartTime: '16:30', StadiumID: 22,
NFLADMIN for scheduling: 5 (Bill Belichick)

