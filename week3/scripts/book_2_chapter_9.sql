-- Purchase Income by Dealership
-- 1. Write a query that shows the total purchase sales income per dealership.

SELECT
	dealerships.business_name,
	SUM(price) as total_purchase_sales
FROM sales
	LEFT JOIN dealerships USING (dealership_id)
	LEFT JOIN salestypes USING (sales_type_id)
WHERE sales_type_name = 'Purchase'
GROUP BY business_name;

-- 2. Write a query that shows the purchase sales income per dealership for July of 2020.

SELECT
	dealerships.business_name,
	SUM(price) as total_sales_july_2020
FROM sales
	LEFT JOIN dealerships USING (dealership_id)
	LEFT JOIN salestypes USING (sales_type_id)
WHERE sales_type_name = 'Purchase' AND EXTRACT(YEAR FROM purchase_date) = 2020 AND EXTRACT(MONTH FROM purchase_date) = 07
GROUP BY business_name;

-- 3. Write a query that shows the purchase sales income per dealership for all of 2020.

SELECT
	dealerships.business_name,
	SUM(price) as total_sales_2020
FROM sales
	LEFT JOIN dealerships USING (dealership_id)
	LEFT JOIN salestypes USING (sales_type_id)
WHERE sales_type_name = 'Purchase' AND EXTRACT(YEAR FROM purchase_date) = 2020
GROUP BY business_name;

-- Lease Income by Dealership
-- 1. Write a query that shows the total lease income per dealership.

SELECT
	dealerships.business_name,
	SUM(price) as total_purchase_sales
FROM sales
	LEFT JOIN dealerships USING (dealership_id)
	LEFT JOIN salestypes USING (sales_type_id)
WHERE sales_type_name = 'Lease'
GROUP BY business_name;

-- 2. Write a query that shows the lease income per dealership for Jan of 2020.

SELECT
	dealerships.business_name,
	SUM(price) as total_lease_value_jan_2020
FROM sales
	LEFT JOIN dealerships USING (dealership_id)
	LEFT JOIN salestypes USING (sales_type_id)
WHERE sales_type_name = 'Lease' AND EXTRACT(YEAR FROM purchase_date) = 2020 AND EXTRACT(MONTH FROM purchase_date) = 01
GROUP BY business_name;

-- 3. Write a query that shows the lease income per dealership for all of 2019.

SELECT
	dealerships.business_name,
	SUM(price) as total_lease_value_2019
FROM sales
	LEFT JOIN dealerships USING (dealership_id)
	LEFT JOIN salestypes USING (sales_type_id)
WHERE sales_type_name = 'Lease' AND EXTRACT(YEAR FROM purchase_date) = 2019
GROUP BY business_name;

-- Total Income by Employee
-- 1. Write a query that shows the total income (purchase and lease) per employee.

SELECT
	first_name || ' ' || last_name AS employee_name,
	SUM(price) AS total_emp_income
FROM sales
	LEFT JOIN employees USING (employee_id)
GROUP BY first_name, last_name;

