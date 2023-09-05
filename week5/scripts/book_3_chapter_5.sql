-- Practice: Carnival
-- 1. Create a trigger for when a new Sales record is added, set the purchase date to 3 days from the current date.

CREATE OR REPLACE FUNCTION SetPurchaseDate()
RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
BEGIN

	IF (SELECT purchase_date FROM sales WHERE sales.sale_id = NEW.sale_id) IS NULL THEN 
  		UPDATE sales
  		SET purchase_date = CURRENT_DATE
  		WHERE sales.sale_id = NEW.sale_id;
    END IF;
	
	UPDATE sales
	SET pickup_date = NEW.purchase_date + integer '3'
	WHERE sales.sale_id = NEW.sale_id;
	
	RETURN NULL;
	
END
$$
;

CREATE OR REPLACE TRIGGER new_sale
AFTER INSERT
ON sales
FOR EACH ROW
EXECUTE PROCEDURE SetPurchaseDate()
;


-- testing --

INSERT INTO sales (vehicle_id, price)
	VALUES (1, 100000)
	
RETURNING *;


-- 2. Create a trigger for updates to the sales table. If the pickup date is on or before the purchase date, set the pickup date to 7 days after the purchase date. If the pickup date is after the purchase date but less than 7 days out from the purchase date, add 4 additional days to the pickup date.
