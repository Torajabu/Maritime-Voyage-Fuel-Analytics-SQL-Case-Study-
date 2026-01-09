-- Maritime Voyage Fuel Analytics (SQL Case Study)
-- Author: Rajabudeen Ahamed M
-- Database: MySQL 8.0

DROP TABLE IF EXISTS voyages;
DROP TABLE IF EXISTS routes;
DROP TABLE IF EXISTS ships;

CREATE TABLE ships (
    ship_id INT PRIMARY KEY,
    ship_name VARCHAR(100) NOT NULL,
    ship_type VARCHAR(50) NOT NULL,
    build_year INT NOT NULL,
    capacity_tons INT NOT NULL
);

CREATE TABLE routes (
    route_id INT PRIMARY KEY,
    origin_port VARCHAR(100) NOT NULL,
    destination_port VARCHAR(100) NOT NULL,
    distance_nm INT NOT NULL
);

CREATE TABLE voyages (
    voyage_id INT PRIMARY KEY,
    ship_id INT NOT NULL,
    route_id INT NOT NULL,
    voyage_date DATE NOT NULL,
    fuel_consumed DECIMAL(10,2) NOT NULL,
    co2_emissions DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (ship_id) REFERENCES ships(ship_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id)
);
