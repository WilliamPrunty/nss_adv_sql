--Practice: Carnival
--1. Get a list of the sales that were made for each sales type.
SELECT *
FROM sales AS s
	LEFT JOIN salestypes AS st USING (sales_type_id);

--2. Get a list of sales with the VIN of the vehicle, the first name and last name of the customer, first name and last name of the employee who made the sale and the name, city and state of the dealership.
SELECT 
	vin, 
	c.first_name AS cust_first, 
	c.last_name AS cust_last,
	e.first_name AS emp_first,
	e.last_name AS emp_last,
	d.business_name AS dealership,
	d.city AS dealer_city,
	d.state AS dealer_state
FROM sales AS s
	LEFT JOIN vehicles AS v USING (vehicle_id)
	LEFT JOIN customers AS c USING (customer_id)
	LEFT JOIN employees AS e USING (employee_id)
	LEFT JOIN dealerships AS d USING (dealership_id);

--3. Get a list of all the dealerships and the employees, if any, working at each one.
SELECT 
	d.business_name AS dealership,
	e.first_name AS emp_first,
	e.last_name AS emp_last
FROM dealershipemployees AS de
	LEFT JOIN dealerships AS d USING (dealership_id)
	INNER JOIN employees AS e USING (employee_id);
	
--4. Get a list of vehicles with the names of the body type, make, model and color.
SELECT 
	body_type, 
	make,
	model, 
	exterior_color
FROM vehicles
	LEFT JOIN vehicletypes USING (vehicle_type_id);
