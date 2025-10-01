-- ===============================
-- Load Data from CSV Files
-- ===============================

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'E:/Sql Practice/Ship Fuel Efficiency/ships.csv'
INTO TABLE ships
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'E:/Sql Practice/Ship Fuel Efficiency/routes.csv'
INTO TABLE routes
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'E:/Sql Practice/Ship Fuel Efficiency/voyages.csv'
INTO TABLE voyages
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;