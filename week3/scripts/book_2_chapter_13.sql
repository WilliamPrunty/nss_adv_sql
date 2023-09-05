-- Creating views
-- Carnival

-- Example query

CREATE VIEW employee_dealership_names AS
  SELECT 
    e.first_name,
    e.last_name,
    d.business_name
  FROM employees e
  INNER JOIN dealershipemployees de ON e.employee_id = de.employee_id
  INNER JOIN dealerships d ON d.dealership_id = de.dealership_id;
  
SELECT *
FROM employee_dealership_names;

-- 1. Create a view that lists all vehicle body types, makes and models.

CREATE VIEW vehicle_information AS
	SELECT 
		body_type,
		make,
		model
	FROM vehicletypes;
	
SELECT *
FROM vehicle_information;

-- 2. Create a view that shows the total number of employees for each employee type.

CREATE VIEW employee_counts AS
	SELECT 
		employee_type_name,
		COUNT(*)
	FROM employees
		LEFT JOIN employeetypes USING (employee_type_id)
	GROUP BY employee_type_name;
	
SELECT *
FROM employee_counts;

-- 3. Create a view that lists all customers without exposing their emails, phone numbers and street address.

CREATE VIEW customers_smpl AS
	SELECT
		customer_id,
		first_name,
		last_name,
		company_name
	FROM customers;
	
SELECT *
FROM customers_smpl;

-- 4. Create a view named sales2018 that shows the total number of sales for each sales type for the year 2018.

CREATE VIEW sales2018 AS
	SELECT 
		sales_type_name,
		SUM(price) AS total_sales_values,
		COUNT(*) AS total_sales
	FROM sales
		LEFT JOIN salestypes USING (sales_type_id)
	WHERE EXTRACT(YEAR FROM purchase_date) = 2018
	GROUP BY sales_type_name;
	
SELECT * 
FROM sales2018;

-- 5. Create a view that shows the employee at each dealership with the most number of sales.

CREATE VIEW top_employees AS
	
	WITH employee_sales AS
	
	(
	SELECT 
		business_name,
		first_name || ' ' || last_name AS employee_name,
		COUNT (*) AS num_sales,
		RANK() OVER (PARTITION BY business_name ORDER BY COUNT(*) DESC)
	FROM sales
		LEFT JOIN employees USING (employee_id)
		LEFT JOIN dealerships USING (dealership_id)
	GROUP BY business_name, first_name, last_name
	)
	
	SELECT business_name, employee_name, num_sales
	FROM employee_sales
	WHERE rank = 1;
	
SELECT *
FROM top_employees;
