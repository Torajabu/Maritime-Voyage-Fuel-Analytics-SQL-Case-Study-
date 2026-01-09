-- Maritime Voyage Fuel Analytics (SQL Case Study)
-- Analytical Queries (Read-Only)

-- Q1. Ships built after 2010
SELECT * FROM ships WHERE build_year > 2010;

-- Q2. Top 10 ships by capacity
SELECT * FROM ships ORDER BY capacity_tons DESC LIMIT 10;

-- Q3. Ships with names starting with 'Ship_1'
SELECT * FROM ships WHERE ship_name LIKE 'Ship_1%';

-- Q4. Average fuel consumed per voyage
SELECT AVG(fuel_consumed) AS avg_fuel FROM voyages;

-- Q5. Total voyages per ship
SELECT ship_id, COUNT(*) AS total_voyages
FROM voyages
GROUP BY ship_id;

-- Q6. Voyage details with ship and route info
SELECT v.voyage_id, s.ship_name, r.origin_port, r.destination_port, v.voyage_date
FROM voyages v
JOIN ships s ON v.ship_id = s.ship_id
JOIN routes r ON v.route_id = r.route_id;

-- Q7. Voyages in 2022
SELECT COUNT(*) AS voyages_2022
FROM voyages
WHERE YEAR(voyage_date) = 2022;

-- Q8. Top 5 longest routes
SELECT * FROM routes ORDER BY distance_nm DESC LIMIT 5;

-- Q9. Ship(s) with maximum capacity
SELECT *
FROM ships
WHERE capacity_tons = (SELECT MAX(capacity_tons) FROM ships);

-- Q10. Ships with more than 100 voyages
SELECT ship_id, COUNT(*) AS total_voyages
FROM voyages
GROUP BY ship_id
HAVING COUNT(*) > 100;

-- Q11. Distinct origin ports
SELECT DISTINCT origin_port FROM routes;

-- Q12. Total CO2 emissions by ship type
SELECT s.ship_type, SUM(v.co2_emissions) AS total_emissions
FROM voyages v
JOIN ships s ON v.ship_id = s.ship_id
GROUP BY s.ship_type;

-- Q13. Voyages with fuel consumption between 1000 and 2000
SELECT * FROM voyages
WHERE fuel_consumed BETWEEN 1000 AND 2000;

-- Q14. Monthly voyage count for 2023
SELECT MONTH(voyage_date) AS month, COUNT(*) AS voyages_count
FROM voyages
WHERE YEAR(voyage_date) = 2023
GROUP BY MONTH(voyage_date)
ORDER BY month;

-- Q15. Voyage sequence per ship
SELECT voyage_id, ship_id, voyage_date,
ROW_NUMBER() OVER (PARTITION BY ship_id ORDER BY voyage_date) AS voyage_seq
FROM voyages;

-- Q16. Rank ships by total fuel consumption
SELECT ship_id,
       SUM(fuel_consumed) AS total_fuel,
       RANK() OVER (ORDER BY SUM(fuel_consumed) DESC) AS fuel_rank
FROM voyages
GROUP BY ship_id;

-- Q17. Average route distance for Tankers
SELECT AVG(r.distance_nm) AS avg_distance
FROM voyages v
JOIN ships s ON v.ship_id = s.ship_id
JOIN routes r ON v.route_id = r.route_id
WHERE s.ship_type = 'Tanker';

-- Q18. Voyage distance categorization
SELECT v.voyage_id,
       CASE
           WHEN r.distance_nm < 2000 THEN 'Short'
           WHEN r.distance_nm BETWEEN 2000 AND 8000 THEN 'Medium'
           ELSE 'Long'
       END AS voyage_category
FROM voyages v
JOIN routes r ON v.route_id = r.route_id;

-- Q19. Routes with reciprocal ports
SELECT r1.*
FROM routes r1
JOIN routes r2
  ON r1.origin_port = r2.destination_port;

-- Q20. Ships with voyages in 2024
SELECT DISTINCT s.ship_id, s.ship_name
FROM ships s
WHERE EXISTS (
    SELECT 1
    FROM voyages v
    WHERE v.ship_id = s.ship_id
      AND YEAR(v.voyage_date) = 2024
);

-- Q21. Voyages above ship average fuel consumption
SELECT v.*
FROM voyages v
WHERE v.fuel_consumed >
      (SELECT AVG(fuel_consumed)
       FROM voyages
       WHERE ship_id = v.ship_id);

-- Q22. First voyage date per ship
SELECT ship_id, MIN(voyage_date) AS first_voyage
FROM voyages
GROUP BY ship_id;

-- Q23. Yearly voyages and emissions by ship type
SELECT YEAR(v.voyage_date) AS year,
       s.ship_type,
       COUNT(*) AS total_voyages,
       SUM(v.co2_emissions) AS total_emissions
FROM voyages v
JOIN ships s ON v.ship_id = s.ship_id
GROUP BY YEAR(v.voyage_date), s.ship_type;
