SELECT 
    p.product_id,
    p.name,
    SUM(od.quantity) AS total_sold
FROM 
    Order_Details od
JOIN Product p ON od.product_id = p.product_id
JOIN Orders o ON o.order_id = od.order_id
WHERE 
    o.order_date >= '2025-06-01' AND o.order_date <= '2025-06-30'
GROUP BY p.product_id, p.name
ORDER BY total_sold DESC
LIMIT 10;
