-- Maritime Voyage Fuel Analytics (SQL Case Study)
-- Author: Rajabudeen Ahamed M
-- Database: MySQL 8.0

-- Ensure local_infile is enabled
-- SHOW VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE 'data/ships.csv'
INTO TABLE ships
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ship_id, ship_name, ship_type, build_year, capacity_tons);

LOAD DATA LOCAL INFILE 'data/routes.csv'
INTO TABLE routes
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(route_id, origin_port, destination_port, distance_nm);

LOAD DATA LOCAL INFILE 'data/voyages.csv'
INTO TABLE voyages
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(voyage_id, ship_id, route_id, voyage_date, fuel_consumed, co2_emissions);
