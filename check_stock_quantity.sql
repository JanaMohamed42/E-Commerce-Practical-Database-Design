DELIMITER //

CREATE TRIGGER check_stock_quantity
BEFORE INSERT ON orderdetails
FOR EACH ROW
BEGIN
    DECLARE available_stock INT;

    SELECT stock_quantity
    INTO available_stock
    FROM product
    WHERE product_id = NEW.product_id;

    IF available_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not enough stock available';
    END IF;
END;
//

DELIMITER ;
