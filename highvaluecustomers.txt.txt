SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    SUM(o.total_amount) AS total_order_amount
FROM 
    Customer c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE 
    o.order_date >= '2025-06-01' AND o.order_date <= '2025-06-30'
GROUP BY c.customer_id, full_name
HAVING total_order_amount > 500;
