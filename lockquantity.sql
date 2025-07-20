START TRANSACTION;

SELECT stock_quantity
FROM Product
WHERE product_id = 211
FOR UPDATE;

SET @requested_qty = 4;
SET @current_stock = (
  SELECT stock_quantity FROM Product WHERE product_id = 211
);

IF @current_stock >= @requested_qty THEN
  UPDATE Product
  SET stock_quantity = stock_quantity - @requested_qty
  WHERE product_id = 211;

  COMMIT;
ELSE
  ROLLBACK;
END IF;
