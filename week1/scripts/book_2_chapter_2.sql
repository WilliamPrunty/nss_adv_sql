--Example queries
--Customers who are from Texas:
SELECT
	last_name, first_name, city, state
FROM
	customers
WHERE
	state = 'TX';
	
--Customers who are from Houston, TX:	
SELECT
	c.last_name, c.first_name, c.city, c.state
FROM
	customers AS c
WHERE
	c.city = 'Houston' AND state = 'TX';
	
--Customers who are from Texas or Tennessee:	
SELECT
	c.last_name, c.first_name, c.city, c.state
FROM
	customers AS c
WHERE 
	c.state = 'TX' OR c.state = 'TN';
	
--For providing a list of values in the WHERE clause, use IN.
SELECT
	c.last_name, c.first_name, c.city, c.state
FROM
	customers AS c
WHERE 
	c.state IN ('TX', 'TN', 'CA');
	
--For pattern matching, use LIKE. The % is a wildcard that means anything can come after the "C".	
SELECT
	c.last_name, c.first_name, c.city, c.state
FROM
	customers AS c
WHERE 
	c.state LIKE 'C%';
	
--Customers whose last name is greater than 5 characters and first name is less than or equal to 7 characters:
SELECT
	c.last_name, c.first_name
FROM
	customers AS c
WHERE
	LENGTH(c.last_name) > 5 and LENGTH(c.first_name) <=7;

--If you want to specify a range in the WHERE clause, use BETWEEN.
--Customers whose company name has between 10 and 20 characters (greater than or equal to 10 and less than or equal to 20):
SELECT
	c.last_name, c.first_name, c.company_name
FROM
	customers AS c
WHERE 
	LENGTH(c.company_name) BETWEEN 10 AND 20;
	
--Customers whose company name is null:
--Because NULL is not equal to any value (even itself), this will not work.
SELECT
	c.last_name, c.first_name, c.company_name
FROM
	customers AS c
WHERE c.company_name = NULL;
--Instead, we use the following:
SELECT
	c.last_name, c.first_name, c.company_name
FROM
	customers AS c
WHERE
	c.company_name IS NULL;
	
	

--Practice: Carnival
--1. Get a list of sales records where the sale was a lease.
SELECT *
FROM sales AS s
WHERE s.sales_type_id = 2;

--2. Get a list of sales where the purchase date is within the last five years.
SELECT *
FROM sales AS s
WHERE s.purchase_date >= '2018-08-07';

--3. Get a list of sales where the deposit was above 5000 or the customer payed with American Express.
SELECT *
FROM sales AS s
WHERE s.deposit > 5000 OR s.payment_method = 'americanexpress';

--4. Get a list of employees whose first names start with 'M' or ends with 'd'.
SELECT *
FROM employees AS e
WHERE e.first_name LIKE 'M%' OR e.first_name LIKE '%d';

--5. Get a list of employees whose phone numbers have the 604 area code.
SELECT *
FROM employees as e
WHERE e.phone LIKE '604%';