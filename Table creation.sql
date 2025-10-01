-- ==============================================================
--  SQL Shipping Project Schema with 5 Years Data (2020–2024)
-- ==============================================================

-- ===============================
-- Drop old tables if they exist
-- ===============================

DROP TABLE IF EXISTS voyages;
DROP TABLE IF EXISTS routes;
DROP TABLE IF EXISTS ships;

-- ===============================
-- Create Tables
-- ===============================

CREATE TABLE ships (
    ship_id INT PRIMARY KEY,
    ship_name VARCHAR(100),
    ship_type VARCHAR(50),
    build_year INT,
    capacity_tons INT
);

CREATE TABLE routes (
    route_id INT PRIMARY KEY,
    origin_port VARCHAR(100),
    destination_port VARCHAR(100),
    distance_nm INT
);

CREATE TABLE voyages (
    voyage_id INT PRIMARY KEY,
    ship_id INT,
    route_id INT,
    voyage_date DATE,
    fuel_consumed DECIMAL(10,2),
    co2_emissions DECIMAL(12,2),
    FOREIGN KEY (ship_id) REFERENCES ships(ship_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id)
);