DELIMITER //

CREATE TRIGGER update_product_stock
AFTER INSERT ON orderdetails
FOR EACH ROW
BEGIN
    UPDATE product
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END;
//

DELIMITER ;
