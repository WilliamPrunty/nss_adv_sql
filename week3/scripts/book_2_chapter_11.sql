-- Carnival Sales Reps

-- Employee Reports
-- 1. How many employees are there for each role?

SELECT 
	employee_type_name,
	COUNT(*) AS no_employees
FROM employees
	LEFT JOIN employeetypes USING (employee_type_id)
GROUP BY employee_type_name;

-- 2. How many finance managers work at each dealership?

SELECT 
	business_name,
	COUNT(*) AS num_finance_mgrs
FROM dealershipemployees
	LEFT JOIN employees USING (employee_id)
	LEFT JOIN employeetypes USING (employee_type_id)
	LEFT JOIN dealerships USING (dealership_id)
WHERE employee_type_name = 'Finance Manager'
GROUP BY business_name;

-- 3. Get the names of the top 3 employees who work shifts at the most dealerships?
WITH ranked AS

(
SELECT 
	first_name || ' ' || last_name AS employee_name, 
	COUNT(DISTINCT dealership_id) AS num_dealerships,
	RANK() OVER(ORDER BY COUNT(DISTINCT dealership_id) DESC) AS ranking
FROM dealershipemployees
	LEFT JOIN employees USING (employee_id)
GROUP BY first_name, last_name
ORDER BY COUNT(DISTINCT dealership_id) DESC
)

SELECT *
FROM ranked
WHERE ranking <= 3;

-- 4. Get a report on the top two employees who have made the most sales through leasing vehicles.

SELECT 
	first_name || ' ' || last_name AS emp_name,
	SUM(price) AS total_lease_sales
FROM sales
	LEFT JOIN salestypes USING (sales_type_id)
	LEFT JOIN employees USING (employee_id)
WHERE sales_type_name = 'Lease'
GROUP BY first_name, last_name
ORDER BY total_lease_sales DESC
;