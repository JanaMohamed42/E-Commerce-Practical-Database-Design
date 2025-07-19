

CREATE TRIGGER trg_create_sale_history
AFTER INSERT ON Order_Details
FOR EACH ROW
BEGIN
    DECLARE orderDate DATE;
    DECLARE customerId INT;

    SELECT order_date, customer_id 
    INTO orderDate, customerId
    FROM Orders
    WHERE order_id = NEW.order_id;

    INSERT INTO Sale_History (
        order_date,
        customer_id,
        product_id,
        quantity,
        total_amount
    ) VALUES (
        orderDate,
        customerId,
        NEW.product_id,
        NEW.quantity,
        NEW.quantity * NEW.unit_price
    );
END;


