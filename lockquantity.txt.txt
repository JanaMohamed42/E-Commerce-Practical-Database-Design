START TRANSACTION;

SELECT stock_product
FROM Product
WHERE product_id = 211
FOR UPDATE;

SET @requested_qty = 4;
SET @current_stock = (
  SELECT stock_product FROM Product WHERE product_id = 211
);

IF @current_stock >= @requested_qty THEN
  UPDATE Product
  SET stock_product = stock_product - @requested_qty
  WHERE product_id = 211;

  COMMIT;
ELSE
  ROLLBACK;
END IF;
