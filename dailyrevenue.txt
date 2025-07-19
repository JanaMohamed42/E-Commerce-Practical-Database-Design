SELECT 
    o.order_date,
    SUM(od.quantity * od.unit_price) AS total_revenue
FROM 
    Orders o
JOIN Order_Details od ON o.order_id = od.order_id
WHERE 
    o.order_date = '2025-06-12'
GROUP BY o.order_date;
