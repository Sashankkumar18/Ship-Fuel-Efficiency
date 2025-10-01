-- ============================================
-- Shipping Fuel Efficiency Project - SQL Queries
-- ============================================

-- Q1. List all ships built after the year 2010
SELECT * FROM ships WHERE build_year > 2010;

-- Q2. Show the top 10 ships with the largest capacity (tons)
SELECT * FROM ships ORDER BY capacity_tons DESC LIMIT 10;

-- Q3. Find all ships whose name starts with "Ship_1"
SELECT * FROM ships WHERE ship_name LIKE 'Ship_1%';

-- Q4. Calculate the average fuel consumed per voyage
SELECT AVG(fuel_consumed) AS avg_fuel FROM voyages;

-- Q5. Find the number of voyages completed by each ship
SELECT ship_id, COUNT(*) AS total_voyages
FROM voyages
GROUP BY ship_id;

-- Q6. Retrieve voyage details along with ship name and route origin-destination
SELECT v.voyage_id, s.ship_name, r.origin_port, r.destination_port, v.voyage_date
FROM voyages v
JOIN ships s ON v.ship_id = s.ship_id
JOIN routes r ON v.route_id = r.route_id;

-- Q7. Count voyages that happened in the year 2022
SELECT COUNT(*) AS voyages_2022
FROM voyages
WHERE YEAR(voyage_date) = 2022;

-- Q8. Show the top 5 routes with the longest distance
SELECT * FROM routes ORDER BY distance_nm DESC LIMIT 5;

-- Q9. Find the ship(s) that have the maximum capacity among all ships
SELECT * FROM ships
WHERE capacity_tons = (SELECT MAX(capacity_tons) FROM ships);

-- Q10. Find ships that have completed more than 100 voyages
SELECT ship_id, COUNT(*) AS total_voyages
FROM voyages
GROUP BY ship_id
HAVING COUNT(*) > 100;

-- Q11. List all distinct origin ports from the routes table
SELECT DISTINCT origin_port FROM routes;

-- Q12. Find the total CO2 emissions for each ship type
SELECT s.ship_type, SUM(v.co2_emissions) AS total_emissions
FROM voyages v
JOIN ships s ON v.ship_id = s.ship_id
GROUP BY s.ship_type;

-- Q13. Show voyages that consumed between 1,000 and 2,000 fuel units
SELECT * FROM voyages
WHERE fuel_consumed BETWEEN 1000 AND 2000;

-- Q14. Get the number of voyages per month in the year 2023
SELECT MONTH(voyage_date) AS month, COUNT(*) AS voyages_count
FROM voyages
WHERE YEAR(voyage_date) = 2023
GROUP BY MONTH(voyage_date)
ORDER BY MONTH;

-- Q15. For each ship, assign a row number to its voyages ordered by voyage_date
SELECT voyage_id, ship_id, voyage_date,
ROW_NUMBER() OVER (PARTITION BY ship_id ORDER BY voyage_date) AS row_num
FROM voyages;

-- Q16. Rank ships by their total fuel consumption across all voyages
SELECT ship_id, SUM(fuel_consumed) AS total_fuel,
RANK() OVER (ORDER BY SUM(fuel_consumed) DESC) AS rank_order
FROM voyages
GROUP BY ship_id;

-- Q17. Find the average distance traveled by ships of type "Tanker"
SELECT AVG(r.distance_nm) AS avg_distance
FROM voyages v
JOIN ships s ON v.ship_id = s.ship_id
JOIN routes r ON v.route_id = r.route_id
WHERE s.ship_type = 'Tanker';

-- Q18. Categorize voyages as 'Short', 'Medium', or 'Long' based on distance
SELECT v.voyage_id, v.route_id,
       CASE
           WHEN r.distance_nm < 2000 THEN 'Short'
           WHEN r.distance_nm BETWEEN 2000 AND 8000 THEN 'Medium'
           ELSE 'Long'
       END AS voyage_category
FROM voyages v
JOIN routes r ON v.route_id = r.route_id;

-- Q19. Find routes where both origin and destination exist as destinations in other routes
SELECT r1.*
FROM routes r1
JOIN routes r2 ON r1.origin_port = r2.destination_port;

-- Q20. Find ships that have at least one voyage in 2024
SELECT DISTINCT s.ship_id, s.ship_name
FROM ships s
WHERE EXISTS (
    SELECT 1 FROM voyages v
    WHERE v.ship_id = s.ship_id
      AND YEAR(v.voyage_date) = 2024
);

-- Q21. Find voyages where the fuel consumption is greater than the average for that ship
SELECT v.*
FROM voyages v
WHERE v.fuel_consumed >
      (SELECT AVG(fuel_consumed)
       FROM voyages
       WHERE ship_id = v.ship_id);

-- Q22. Find the earliest voyage date for each ship
SELECT ship_id, MIN(voyage_date) AS first_voyage
FROM voyages
GROUP BY ship_id;

-- Q23. Find total voyages and total CO2 emissions grouped by year and ship_type
SELECT YEAR(v.voyage_date) AS year, s.ship_type,
       COUNT(*) AS total_voyages, SUM(v.co2_emissions) AS total_emissions
FROM voyages v
JOIN ships s ON v.ship_id = s.ship_id
GROUP BY YEAR(v.voyage_date), s.ship_type;

-- Q24. Delete voyages where fuel consumption is less than 150 (test cleanup)
DELETE FROM voyages
WHERE fuel_consumed < 150;

-- Q25. Update the capacity of all ships built before 1990 by reducing 10%
UPDATE ships
SET capacity_tons = capacity_tons * 0.9
WHERE build_year < 1990;