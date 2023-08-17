-- Carnival Inventory
-- Available Models
-- 1. Which model of vehicle has the lowest current inventory? This will help dealerships know which models to purchase from manufacturers.

SELECT 
	model,
	COUNT(*) AS avail_inventory
FROM vehicles
	LEFT JOIN vehicletypes USING (vehicle_type_id)
WHERE is_sold = 'false'
GROUP BY model
ORDER BY COUNT(*);

-- 2. Which model of vehicle has the highest current inventory? This will help dealerships know which models are, perhaps, not selling.

SELECT 
	model,
	COUNT(*) AS avail_inventory
FROM vehicles
	LEFT JOIN vehicletypes USING (vehicle_type_id)
WHERE is_sold = 'false'
GROUP BY model
ORDER BY COUNT(*) DESC;

-- Diverse Dealerships
-- 1. Which dealerships are currently selling the least number of vehicle models? This will let dealerships market vehicle models more effectively per region.

SELECT 
	business_name,
	COUNT(DISTINCT model) AS unique_models
FROM vehicles
	LEFT JOIN dealerships ON vehicles.dealership_location_id = dealerships.dealership_id
	LEFT JOIN vehicletypes USING (vehicle_type_id)
WHERE is_sold = 'false'
GROUP BY business_name
ORDER BY unique_models;

-- 2. Which dealerships are currently selling the highest number of vehicle models? This will let dealerships know which regions have either a high population or less brand loyalty.

SELECT 
	business_name,
	COUNT(DISTINCT model) AS unique_models
FROM vehicles
	LEFT JOIN dealerships ON vehicles.dealership_location_id = dealerships.dealership_id
	LEFT JOIN vehicletypes USING (vehicle_type_id)
WHERE is_sold = 'false'
GROUP BY business_name
ORDER BY unique_models DESC;