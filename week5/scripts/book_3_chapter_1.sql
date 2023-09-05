-- Practice: Employees
-- Kristopher Blumfield, an employee of Carnival has asked to be transferred to a different dealership location. She is currently at dealership 9. She would like to work at dealership 20. Update her record to reflect her transfer.

--verifying the record exists and has the expected information
SELECT * 
FROM employees
	LEFT JOIN dealershipemployees USING (employee_id)
WHERE first_name = 'Kristopher' AND last_name = 'Blumfield';

--updating the record as requested
UPDATE dealershipemployees
SET dealership_id = 20
WHERE employee_id = (SELECT employee_id
					FROM employees
					WHERE first_name = 'Kristopher' AND last_name = 'Blumfield');
					
					
-- Practice: Sales
-- A sales associate needs to update a sales record because her customer wants to pay with a Mastercard instead of JCB. Update customer Ernestus Abeau sales record which has an invoice number of 9086714242.

--verifying the record exists.
SELECT * 
FROM sales
	LEFT JOIN customers USING (customer_id)
WHERE invoice_number = '9086714242';

--updating with new information.
UPDATE sales
SET payment_method = 'mastercard'
WHERE invoice_number = '9086714242';