--Inserting new vehicle type into vehicletypes table.

INSERT INTO vehicletypes (body_type, make, model)

VALUES
	('Car', 'Nissan', 'GTR')
	
RETURNING *;
	


--Inserting new vehicle to vehicles table

INSERT INTO vehicles (vin, engine_type, vehicle_type_id, exterior_color, interior_color, floor_price, msr_price, miles_count, year_of_car, is_sold, is_new, dealership_location_id)

VALUES
	(1234567891011, 'V6', 35, 'Black', 'Black', 125000, 100000, 0, 2023, false, true, 29)
	
RETURNING *;
	
