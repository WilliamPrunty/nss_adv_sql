-- Creating table in original format for transaction testing.

-- Dropping table
DROP TABLE IF EXISTS vehicletypes_og CASCADE;

-- Create table for testing

CREATE TABLE vehicletypes_og (
	vehicle_type_id int,
	make varchar (20),
	model varchar (20),
	body_type varchar (20));


-- inserting data

INSERT INTO vehicletypes_og (
	vehicle_type_id,
	make,
	model,
	body_type)
SELECT vt.vehicle_type_id AS vehicle_type_id, vma.name AS make, vmo.name AS model, vbt.name AS body_type
FROM vehicletypes AS vt
	LEFT JOIN vehiclemake AS vma USING (vehicle_make_id) 
	LEFT JOIN vehiclemodel AS vmo USING (vehicle_model_id)
	LEFT JOIN vehiclebodytype AS vbt USING (vehicle_body_type_id);
