-- INSERT INTO table_name (column_names)

INSERT INTO customers (first_name, last_name, email, street, city, state, zipcode)

-- VALUES (first, row, of, values), (second, row, of, values)

VALUES
	('Nicole', 'Wills', 'nwills25@gmail.com', '118 Cartwright Pky', 'Nashville', 'TN', 37072),
	('Joshua', 'Brickey', 'jb@gmail.com', '420 Who Knows Rd', 'Sterling', 'CT', 12345)
	
--Returns newly added rows.
RETURNING *;