-- Practice: Employees

-- 1. A sales employee at carnival creates a new sales record for a sale they are trying to close. The customer, last minute decided not to purchase the vehicle. Help delete the sales record with an invoice number of '2436217483'.

--Deleting the required row.
DELETE FROM sales
WHERE invoice_number = '2436217483';

--verifying the row is deleted.
SELECT * 
FROM sales
WHERE invoice_number = '2436217483';

-- 2. An employee was recently fired so we must delete them from our database. Delete the employee with employee_id of 35. What problems might you run into when deleting? How would you recommend fixing it?

--Checking what constraint exists

DELETE FROM employees
WHERE employee_id = 35;

-- ERROR:  update or delete on table "employees" violates foreign key constraint "dealershipemployees_employee_id_fkey" on table "dealershipemployees"
-- DETAIL:  Key (employee_id)=(35) is still referenced from table "dealershipemployees".
-- SQL state: 23503

'ALTER TABLE employees
DROP CONSTRAINT employees_pkey CASCADE,
ADD CONSTRAINT employees_pkey 
	FOREIGN KEY (employee_id)
	REFERENCES dealershipemployees_employees_id_fkey
	ON DELETE SET NULL;'