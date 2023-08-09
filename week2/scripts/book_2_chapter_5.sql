--Example Queries
-- Find employees who haven't made any sales and the name of the dealership they work at.
SELECT
    e.first_name,
    e.last_name,
    d.business_name,
    s.price
FROM employees e
INNER JOIN dealershipemployees de ON e.employee_id = de.employee_id
INNER JOIN dealerships d ON d.dealership_id = de.dealership_id
LEFT JOIN sales s ON s.employee_id = e.employee_id
WHERE s.price IS NULL;

-- Get all the departments in the database,
-- all the employees in the database and the floor price of any vehicle they have sold.
SELECT
    d.business_name,
    e.first_name,
    e.last_name,
    v.floor_price
FROM dealerships d
LEFT JOIN dealershipemployees de ON d.dealership_id = de.dealership_id
INNER JOIN employees e ON e.employee_id = de.employee_id
INNER JOIN sales s ON s.employee_id = e.employee_id
INNER JOIN vehicles v ON s.vehicle_id = v.vehicle_id;

-- Use a self join to list all sales that will be picked up on the same day,
-- including the full name of customer picking up the vehicle. .
SELECT 
    CONCAT  (c.first_name, ' ', c.last_name) AS last_name,
    s1.invoice_number,
    s1.pickup_date,
	s1.customer_id AS s1c, --Added customer id from sales 1 and sales 2 table. Better showing how the results are related.
	s2.customer_id AS s2c
FROM sales s1
INNER JOIN sales s2
    ON s1.sale_id <> s2.sale_id 
    AND s1.pickup_date = s2.pickup_date
INNER JOIN customers c
   ON c.customer_id = s1.customer_id
ORDER BY s1.pickup_date;
   
-- Get employees and customers who have interacted through a sale.
-- Include employees who may not have made a sale yet.
-- Include customers who may not have completed a purchase.
SELECT
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name
FROM employees e
FULL OUTER JOIN sales s ON e.employee_id = s.employee_id
FULL OUTER JOIN customers c ON s.customer_id = c.customer_id;

-- Get a list of all dealerships and which roles each of the employees hold.
SELECT
    d.business_name,
    et.employee_type_name
FROM dealerships d
LEFT JOIN dealershipemployees de ON d.dealership_id = de.dealership_id
INNER JOIN employees e ON de.employee_id = e.employee_id
RIGHT JOIN employeetypes et ON e.employee_type_id = et.employee_type_id;


--Practice: Sales Type by Dealership
--Produce a report that lists every dealership, the number of purchases done by each, and the number of leases done by each.
SELECT 
	d.business_name, 
	COUNT(s.sales_type_id), 
	st.sales_type_name
FROM sales AS s
	LEFT JOIN dealerships AS d USING (dealership_id)
	LEFT JOIN salestypes AS st USING (sales_type_id)
GROUP BY d.business_name, s.sales_type_id, st.sales_type_name
ORDER BY business_name
;

--Practice: Leased Types
--Produce a report that determines the most popular vehicle model that is leased.
SELECT 
	vt.model,
	COUNT(*) AS times_leased
FROM sales AS s
	LEFT JOIN vehicles AS v USING(vehicle_id)
	LEFT JOIN vehicletypes AS vt USING(vehicle_type_id)
	LEFT JOIN salestypes AS st USING(sales_type_id)
WHERE st.sales_type_name = 'Lease'
GROUP BY vt.model
ORDER BY times_leased DESC
LIMIT 1
;

--Who Sold What
--1. What is the most popular vehicle make in terms of number of sales?
	--If a sale is when a vehicle is PURCHASED, Nissan is the most popular maker.
SELECT 
	vt.make,
	COUNT(*) AS times_purchased
FROM sales AS s
	LEFT JOIN vehicles AS v USING(vehicle_id)
	LEFT JOIN vehicletypes AS vt USING(vehicle_type_id)
	LEFT JOIN salestypes AS st USING(sales_type_id)
WHERE st.sales_type_name = 'Purchase'
GROUP BY vt.make
ORDER BY times_purchased DESC
;

--2. Which employee type sold the most of that make?

SELECT
	employee_type_name,
	COUNT(*) sales_by_emp_type
FROM sales
	LEFT JOIN vehicles AS v USING(vehicle_id)
	LEFT JOIN vehicletypes AS vt USING(vehicle_type_id)
	LEFT JOIN salestypes AS st USING(sales_type_id)
	LEFT JOIN employees AS e USING(employee_id)
	LEFT JOIN employeetypes AS et USING(employee_type_id)
WHERE st.sales_type_name = 'Purchase' AND vt.make = 'Nissan'
GROUP BY et.employee_type_name
ORDER BY sales_by_emp_type DESC
;
