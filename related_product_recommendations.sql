SELECT DISTINCT p.product_id, p.product_name, p.category_id
FROM product p
WHERE p.category_id IN (
    SELECT pr.category_id
    FROM customer_history ch
    JOIN product pr ON ch.product_id = pr.product_id
    WHERE ch.customer_id = ?  -- Replace ? with actual customer_id
)
AND p.product_id NOT IN (
    SELECT product_id
    FROM customer_history
    WHERE customer_id = ?  -- Replace ? with actual customer_id
);
