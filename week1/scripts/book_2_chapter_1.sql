--Example queries

SELECT *
FROM vehicles;

SELECT
	v.engine_type,
	v.floor_price,
	v.msr_price
FROM vehicles AS v;

--Practice: Dealers
--Write a query that returns the business name, city, state, and website for each dealership. Use an alias for the dealerships table.

SELECT 
	d.business_name,
	d.city,
	d.state,
	d.website
FROM dealerships AS d;

--Practice: Customers
--Write a query that returns the first name, last name, and email address of every customer. Use an alias for the the customers table.

SELECT 
	c.first_name,
	c.last_name,
	c.email
FROM customers AS c;