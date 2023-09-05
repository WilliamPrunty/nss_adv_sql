-- Group Project
-- Employee Reports
	-- Best Sellers
		
-- 1. Who are the top 5 employees for generating sales income?

SELECT 
	first_name || ' ' || last_name AS emp_name,
	SUM(price) AS total_purchase_sales
FROM sales
	LEFT JOIN employees USING (employee_id)
GROUP BY first_name, last_name
ORDER BY total_purchase_sales DESC
LIMIT 5;

-- 2. Who are the top 5 dealerships for generating sales income?

SELECT
	business_name,
	SUM(price) AS dealership_sales
FROM sales
	LEFT JOIN dealerships USING (dealership_id)
GROUP BY business_name
ORDER BY dealership_sales DESC
LIMIT 5;

-- 3. Which vehicle model generated the most sales income?

SELECT
	model,
	SUM(price) AS model_sales
FROM sales
	LEFT JOIN vehicles USING (vehicle_id)
	LEFT JOIN vehicletypes USING (vehicle_type_id)
GROUP BY model
ORDER BY model_sales DESC
LIMIT 1;

---Maxima generated the most sales income across all dealerships with a total amount of $16988002.86
	
	
	-- Top Performance

-- 1. Which employees generate the most income per dealership?

WITH dealership_emp_sales AS

(
SELECT
	business_name,
	first_name || ' ' || last_name AS emp_name,
	SUM(price) AS total_sales,
	RANK() OVER (PARTITION BY business_name ORDER BY SUM(price) DESC) AS sales_rank
FROM sales
	LEFT JOIN employees USING (employee_id)
	LEFT JOIN dealerships USING (dealership_id)
GROUP BY business_name, first_name, last_name
ORDER BY business_name, total_sales DESC
)

SELECT 
	business_name,
	emp_name,
	total_sales
FROM dealership_emp_sales
WHERE sales_rank = 1;

-- Vehicle Reports
	-- Inventory

-- 1. In our vehicle inventory, show the count of each model that is in stock.

SELECT 
	model,
	COUNT(*) AS inventory
FROM vehicles
	LEFT JOIN vehicletypes USING (vehicle_type_id)
WHERE is_sold = 'false'
GROUP BY model
ORDER BY inventory DESC;

-- 2. In our vehicle inventory, show the count of each make that is in stock.

SELECT 
	make,
	COUNT(*) AS inventory
FROM vehicles
	LEFT JOIN vehicletypes USING (vehicle_type_id)
WHERE is_sold = 'false'
GROUP BY make
ORDER BY inventory DESC;

-- 3. In our vehicle inventory, show the count of each bodytype that is in stock.

SELECT 
	body_type,
	COUNT(*) AS inventory
FROM vehicles
	LEFT JOIN vehicletypes USING (vehicle_type_id)
WHERE is_sold = 'false'
GROUP BY body_type
ORDER BY inventory DESC;

	-- Purchasing Power

-- 1. Which US state's customers have the highest average purchase price for a vehicle?

SELECT 
	state,
	ROUND(AVG(price), 2) AS avg_price
FROM sales
	LEFT JOIN customers USING (customer_id)
	LEFT JOIN salestypes USING (sales_type_id)
WHERE sales_type_name = 'Purchase'
GROUP BY state
ORDER BY avg_price DESC
LIMIT 1;

-- 2. Now using the data determined above, which 5 states have the customers with the highest average purchase price for a vehicle?

SELECT 
	state,
	ROUND(AVG(price), 2) AS avg_price
FROM sales
	LEFT JOIN customers USING (customer_id)
	LEFT JOIN salestypes USING (sales_type_id)
WHERE sales_type_name = 'Purchase'
GROUP BY state
ORDER BY avg_price DESC
LIMIT 5;