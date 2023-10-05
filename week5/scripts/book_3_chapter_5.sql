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

-- Testing --

SELECT * FROM sales ORDER BY sale_id DESC

-- 2. Create a trigger for updates to the sales table. If the pickup date is on or before the purchase date, set the pickup date to 7 days after the purchase date. If the pickup date is after the purchase date but less than 7 days out from the purchase date, add 4 additional days to the pickup date.

CREATE OR REPLACE FUNCTION correct_pickup_date()
RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
BEGIN
	UPDATE sales
	SET pickup_date =
		CASE 
			WHEN pickup_date <= NEW.purchase_date THEN NEW.purchase_date + integer '7'
			WHEN pickup_date > NEW.purchase_date 
		 	   AND pickup_date < NEW.purchase_date + integer '7' THEN pickup_date + integer '4'
		ELSE pickup_date
	END
	;

	RETURN NULL;
	
END
$$
;

CREATE OR REPLACE TRIGGER update_sale
AFTER UPDATE
ON sales
FOR EACH STATEMENT
EXECUTE PROCEDURE correct_pickup_date()
;

UPDATE sales
SET pickup_date = '2019-08-16'
WHERE sale_id = 5000

SELECT * FROM sales ORDER BY sale_id DESC