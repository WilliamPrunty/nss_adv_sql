-- Carnival Customers

-- States With Most Customers

-- 1. What are the top 5 US states with the most customers who have purchased a vehicle from a dealership participating in the Carnival platform?

SELECT 
	state,
	COUNT(DISTINCT customer_id) AS num_customers
FROM sales
	LEFT JOIN customers USING (customer_id)
	LEFT JOIN salestypes USING (sales_type_id)
WHERE sales_type_name = 'Purchase'
GROUP BY state
ORDER BY num_customers DESC
LIMIT 5;

--TX, CA, FL, NY, and OH have the most customers purchasing vehicles.

-- 2. What are the top 5 US zipcodes with the most customers who have purchased a vehicle form a dealership participating in the Carnival platform?

SELECT 
	customers.zipcode,
	COUNT(DISTINCT customer_id) AS num_customers
FROM sales
	LEFT JOIN customers USING (customer_id)
	LEFT JOIN salestypes USING (sales_type_id)
WHERE sales_type_name = 'Purchase'
GROUP BY customers.zipcode
ORDER BY num_customers DESC
LIMIT 5;

-- 3. What are the top 5 dealerships with the most customers?

SELECT 
	business_name,
	COUNT(DISTINCT customer_id) AS num_customers
FROM sales
	LEFT JOIN customers USING (customer_id)
	LEFT JOIN dealerships USING (dealership_id)
GROUP BY business_name
ORDER BY num_customers DESC
LIMIT 5;