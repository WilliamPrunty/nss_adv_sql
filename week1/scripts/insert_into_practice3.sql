--Insert new employee into employees table

INSERT INTO employees (first_name, last_name, email_address, phone, employee_type_id)
VALUES
	('Kennie', 'Maharg', 'kmaharge@com.com', '598-678-4885', 4)

RETURNING *;