-- =========================================
-- TASK 3: SQL QUERY WRITING
-- Author: Samuel Wanyua

-- 1.PROPERTIES WITH BELOW 80% OCCUPANCY RATE
-- Assumption: properties table included columns for occupied_units and total_units -> Original data lacks these two columns
SELECT p.name, l.name, .rent_per_unit,  ROUND((occupied_units/total_units * 100),2) AS occupancy_rate
FROM properties p
JOIN locations l ON p.location_id = l.id
WHERE ROUND((occupied_units/total_units * 100),2) < 80
ORDER BY ROUND((occupied_units/total_units * 100),2) DESC;

 

-- 2. TOTAL ARREARS PER LOCATION 
SELECT l.name, SUM(ls.arrears)
FROM leases ls
JOIN properties p ON ls.unit_id = p.id
JOIN locations l ON l.id = p.location_id
GROUP BY l.name
ORDER BY SUM(ls.arrears) DESC
LIMIT 2;

-- 3. TOP 3 PROPERTIES BY COLLECTION EFFICIENCY
--  SUM(m_rent-arr) /SUM(m_rent) * 100
SELECT p.name, 
ROUND(SUM(ls.rent_per_month - ls.arrears) / SUM(ls.rent_per_month)* 100,2) AS collection_efficiecy
FROM properties p
JOIN leases ls ON p.id = ls.unit_id
GROUP BY p.name
ORDER BY collection_efficiecy DESC
LIMIT 3;

-- 4. Find invalid leases
-- SELECT * FROM leases; 
SELECT * 
FROM leases
WHERE rent_per_month <0 OR end_date <= start_date;


-- 5. TENANTS WHO HAVE LEASED MORE THAN 2  PROPERTIES
SELECT t.name, COUNT(t.id) as units_leased
FROM tenants t
JOIN leases ls ON t.id = ls.tenant_id
GROUP BY t.name
HAVING units_leased >= 2;



