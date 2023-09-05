-- Selling a Vehicle
-- Carnival would like to create a stored procedure that handles the case of updating their vehicle inventory when a sale occurs. They plan to do this by flagging the vehicle as is_sold which is a field on the Vehicles table. When set to True this flag will indicate that the vehicle is no longer available in the inventory. Why not delete this vehicle? We don't want to delete it because it is attached to a sales record.

-- Returning a Vehicle
-- Carnival would also like to handle the case for when a car gets returned by a customer. When this occurs they must add the car back to the inventory and mark the original sales record as sale_returned = TRUE.

-- Carnival staff are required to do an oil change on the returned car before putting it back on the sales floor. In our stored procedure, we must also log the oil change within the OilChangeLogs table.

-- Goals

-- 1. Use the story above to extract the requirements.
-- 2. Build two stored procedures for selling a car and returning a car. Be ready to share with your class or instructor your result.


-----------------------------------------
-- Procedure 1
-- Create procedure to change is_sold flag to True. Should accept vehicle_id as input

CREATE PROCEDURE sold_vehicle (invehicleid integer)
LANGUAGE plpgsql
AS $$
BEGIN

	UPDATE vehicles
	SET is_sold = 'true'
	WHERE vehicle_id = invehicleid;
	
END
$$
; 

CALL sold_vehicle(4)


----------------------------------------
-- Procedure 2
-- Create procedure that updates both the sale_returned column in the sales table and the is_sold column in the vehicles table. Values should update to 'true' and 'false' respectively.

CREATE PROCEDURE vehicle_return (invehicleid integer)
LANGUAGE plpgsql
AS $$
BEGIN

	UPDATE vehicles
	SET is_sold = 'false'
	WHERE vehicle_id = invehicleid;
	
	UPDATE sales
	SET sale_returned = 'true'
	WHERE vehicle_id = invehicleid;
	
END
$$
;

CALL vehicle_return(2)

-- vehicle_id is not unique in sales table. Data was updated as expected.
SELECT vehicle_id, is_sold, sale_returned FROM vehicles LEFT JOIN sales USING (vehicle_id) ORDER BY vehicle_id