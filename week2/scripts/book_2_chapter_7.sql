--Top 5 Dealerships
--1. For the top 5 dealerships, which employees made the most sales?
	-- Top 5 dealership has the greatest number of leases and purchases, combined.
	-- A sale is the PURCHASE of a vehicle.
with top_5 AS (SELECT 
					business_name,
			   		dealership_id,
					COUNT(*) AS total_transactions
			  FROM sales
					LEFT JOIN dealerships AS d USING (dealership_id)
			  GROUP BY d.business_name, dealership_id
			  ORDER BY total_transactions DESC
			  LIMIT 5)

SELECT 
	first_name,
	last_name,
	business_name,
	COUNT(*) AS num_sales
FROM sales
	LEFT JOIN employees USING(employee_id)
	LEFT JOIN top_5 USING(dealership_id)
WHERE dealership_id IN (SELECT dealership_id
					   FROM top_5) 
	AND sales_type_id = (SELECT sales_type_id
						FROM salestypes
						WHERE sales_type_name = 'Purchase')
GROUP BY first_name, last_name, business_name
ORDER BY num_sales DESC
;


--2. For the top 5 dealerships, which vehicle models were the most popular in sales?
with top_5 AS (SELECT 
					business_name,
			   		dealership_id,
					COUNT(*) AS total_transactions
			  FROM sales
					LEFT JOIN dealerships AS d USING (dealership_id)
			  GROUP BY d.business_name, dealership_id
			  ORDER BY total_transactions DESC
			  LIMIT 5)

SELECT 
	model,
	COUNT(*) AS sales
FROM sales
	LEFT JOIN vehicles USING(vehicle_id)
	LEFT JOIN vehicletypes USING(vehicle_type_id)
WHERE dealership_id IN (SELECT dealership_id
					   FROM top_5)
	AND sales_type_id = (SELECT sales_type_id
						FROM salestypes
						WHERE sales_type_name = 'Purchase')
GROUP BY model
ORDER BY sales DESC
;

--3. For the top 5 dealerships, were there more sales or leases?
with top_5 AS (SELECT 
					business_name,
			   		dealership_id,
					COUNT(*) AS total_transactions
			  FROM sales
					LEFT JOIN dealerships AS d USING (dealership_id)
			  GROUP BY d.business_name, dealership_id
			  ORDER BY total_transactions DESC
			  LIMIT 5)

SELECT 
	sales_type_name,
	COUNT(*)
FROM sales
	LEFT JOIN vehicles USING(vehicle_id)
	LEFT JOIN vehicletypes USING(vehicle_type_id)
	LEFT JOIN salestypes USING(sales_type_id)
WHERE dealership_id IN (SELECT dealership_id
					   FROM top_5)
GROUP BY sales_type_name
;

--Used Cars
--1. For all used cars, which states sold the most? The least?
with used_cars AS (SELECT *
				  FROM vehicles
				  WHERE is_new = 'false')
				  
SELECT 
	state,
	COUNT(*) AS num_sales
FROM sales
	LEFT JOIN dealerships USING (dealership_id)
WHERE vehicle_id IN (SELECT vehicle_id
					FROM used_cars)
GROUP BY state
ORDER BY num_sales DESC
;

--California sold the most used cars at 69. Missouri and Iowa have sold the least with 7.

--2. For all used cars, which model is greatest in the inventory? Which make is greatest inventory?
with used_cars AS (SELECT *
				  FROM vehicles
				  WHERE is_new = 'false')
				  
SELECT 
	model,
	COUNT(*)
FROM used_cars
	LEFT JOIN vehicletypes USING(vehicle_type_id)
GROUP BY model
ORDER BY COUNT(*) DESC
;
 -- The Nissan Titan Model appears most often in the used vehicle inventory.
 
 with used_cars AS (SELECT *
				  FROM vehicles
				  WHERE is_new = 'false')
				  
SELECT 
	make,
	COUNT(*)
FROM used_cars
	LEFT JOIN vehicletypes USING(vehicle_type_id)
GROUP BY make
ORDER BY COUNT(*) DESC
;

--Nissan is the most popular maker in the used car inventory.


--Practice
--Talk with your teammates and think of another scenario where you can use a CTE to answer multiple business questions about employees, inventory, sales, deealerships or customers.