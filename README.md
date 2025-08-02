# 🛍️ E-Commerce Practical Database Design

Welcome! This repository contains a set of SQL scripts used to build and manage a simple e-commerce database.  
It covers everything from schema creation to advanced queries, reporting, triggers, and transactions.

---

## 📊 ERD Diagram

![ERD](https://github.com/JanaMohamed42/E-Commerce-Practical-Database-Design/blob/main/ERD%20DB%20.png)

## 🧱 Main Entities in the Database

- **Customer**: Stores customer personal data (name, email, address, etc.)
- **Category**: Groups products under specific categories (e.g. Electronics, Clothing)
- **Product**: Represents items available for sale
- **Order**: Represents a customer's order (date, total amount, etc.)
- **Order_Details**: Line items of each order (what products were bought, quantity, price)

## 🔗 Updated Relationships Between Entities

- **Category → Product**  
  📘 Relationship: **One-to-Many (1:M)**  
  ➤ One category can have many products.

- **Customer → Order**  
  📘 Relationship: **One-to-Many (1:M)**  
  ➤ One customer can place many orders.

- **Order → Order_Details**  
  📘 Relationship: **One-to-Many (1:M)**  
  ➤ Each order has multiple order details.

- **Product → Order_Details**  
  📘 Relationship: **One-to-Many (1:M)**  
  ➤ One product can appear in many order detail entries.



## 📂 SQL Scripts Collection

### 🧱 Create Tables  
🔗 [`createtables.sql`](createtables.sql)  
Creates the full schema: `customers`, `products`, `orders`, `order_details`, and `categories`.

---

### 📊 Daily Revenue Report  
🔗 [`dailyrevenue.sql`](dailyrevenue.sql)  
Generates a summary of total daily revenue — auto-calculated based on today's date.

---

### 📈 Top-Selling Products (Last Month)  
🔗 [`topsellingproducts.sql`](topsellingproducts.sql)  
Retrieves best-selling products from the previous month based on sales count.

---

### 💰 High-Value Customers (>$500 last month)  
🔗 [`highvaluecustomers.sql`](highvaluecustomers.sql)  
Finds customers whose total purchases exceeded $500 in the past month.

---

### 🔍 Search Products with "Camera"  
🔗 [`searchcamera.sql`](searchcamera.sql)  
Searches for all products that contain the word "camera" in their name or description.

---

### 🎯 Product Recommendations (Same Category & Author)  
Recommends other products in the same category as previously purchased items by the customer, excluding already purchased products.
🔗 [View Code](./related_product_recommendations.sql)


---

### 🔁 Trigger: Sale History Logging  
🔗 [`triggersalehistory.sql`](triggersalehistory.sql)  
Automatically logs sales history after each new order using a database trigger.

---

### 🔒 Lock Quantity Field (Product ID: 211)  
🔗 [`lockquantity.sql`](lockquantity.sql)  
Prevents changes to the quantity field of a specific product using transaction locking.

---

### 🔐 Lock Product Row (Product ID: 211)  
🔗 [`lockrow.sql`](lockrow.sql)  
Locks a specific row from being updated during a transaction.




### 📉 Trigger to Automatically Update Product Stock After a New Order  
Updates the product stock quantity whenever a new order is inserted into the `orderdetails` table.

[🔗 View Trigger Code](./update_product_stock.sql)




---

### 🚫 Trigger to Prevent Orders with Insufficient Stock  
Prevents inserting a new order into the `orderdetails` table if the requested quantity exceeds available stock.

[🔗 View Trigger Code](./check_stock_quantity.sql)





# SQL Queries Optimization Test  



## ✅ Query 1: Fetch Latest 100 High-Value Product Orders

**Description:** Fetches the latest 100 orders of products priced above 500, including order details and product names, ordered by order date.  

```sql
SELECT 
    o.order_id,
    o.order_date,
    p.product_name,
    od.unit_price,
    od.quantity
FROM Orders o
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Product p ON od.product_id = p.product_id
WHERE p.price > 500
ORDER BY o.order_date DESC
LIMIT 100;
````

**Execution Before Optimization:** `100.844 sec`

**Execution After Optimization:** `0.047 sec`

**Optimization Technique:**

```sql
CREATE INDEX idx_product_price ON Product(price);
CREATE INDEX idx_orderdetails_orderid_productid ON Order_Details(order_id, product_id);
```

---

## ✅ Query 2: Identify Day with Highest Revenue

**Description:** Identifies the day with the highest total revenue by aggregating orders and total amount, limited to one result.

```sql
SELECT 
    o.order_date,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_revenue
FROM Orders o
GROUP BY o.order_date
ORDER BY total_revenue DESC
LIMIT 1;
```

**Execution Before Optimization:** `13.312 sec`

**Execution After Optimization:** `0.719 sec`

**Optimization Technique:**

```sql
CREATE INDEX idx_orders_order_date_total_amount ON Orders(order_date, total_amount);
```

---

## ✅ Query 3: Calculate Top 50 Revenue by Product Category

**Description:** Calculates total revenue per product category, joining aggregated order details with products and categories, limited to top 50.

```sql
SELECT 
    c.category_name,
    p.product_name,
    od_agg.revenue
FROM (
    SELECT product_id, SUM(quantity * unit_price) AS revenue
    FROM Order_Details
    GROUP BY product_id
) AS od_agg
JOIN Product p ON od_agg.product_id = p.product_id
JOIN Category c ON p.category_id = c.category_id
ORDER BY od_agg.revenue DESC
LIMIT 50;
```

**Execution Before Optimization:** `525.25 sec`

**Execution After Optimization:** `27.062 sec`

**Optimization Technique:**

```sql
CREATE INDEX idx_product_category_product_name ON Product(category_id, product_id, product_name);
CREATE INDEX idx_product_categoryid_productname ON Product(category_id, product_name);
```

---



## ✅ Query 4: Search Top 50 Laptops by Price

**Description:** Retrieves products with "Laptop" in their name, ordered by price, limited to 50 results.

```sql
SELECT 
    product_id, product_name, price
FROM Product
WHERE product_name LIKE '%Laptop%'
ORDER BY price DESC
LIMIT 50;
```

**Execution Before Optimization:** `95.718 sec`

**Execution After Optimization:** `25.547 sec`

**Optimization Technique:**

```sql
CREATE INDEX idx_product_name_price ON Product(product_name, price);
CREATE INDEX idx_product_name_price_cover ON Product(product_name, price, product_id);
```

---

## ✅ Query 5: Aggregate Top 100 Customer Spending

**Description:** Aggregates total spending by customers, joining orders and customer data, ordered by total spent, limited to 100.

```sql
SELECT  
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    SUM(o.total_amount) AS total_spent
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, full_name
ORDER BY total_spent DESC
LIMIT 100;
```

**Execution Before Optimization:** `163.312 sec`

**Execution After Optimization:** `10.032 sec`

**Optimization Technique:**

```sql
CREATE INDEX idx_orders_customer_id_total_amount ON Orders(customer_id, total_amount);
```

---

## ✅ Query 6: Count Products per Category

**Description:** Counts the number of products per category, including categories with no products, ordered by product count.

```sql
SELECT  
    c.category_id,
    c.category_name,
    COUNT(p.product_id) AS totalitems
FROM Category c
LEFT JOIN Product p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY totalitems DESC;
```

**Execution Before Optimization:** `36.386 sec`

**Execution After Optimization:** `1.500 sec`

**Optimization Technique:**

```sql
CREATE INDEX idx_product_categoryid_productid ON Product(category_id, product_id);
```

---

## ✅ Query 7: Find Top 10 Sold Products in June 2025

**Description:** Aggregates total quantity sold per product for orders in June 2025, limited to top 10.

```sql
SELECT 
    p.product_id,
    product_name,
    SUM(quantity) AS total_sold
FROM 
    Order_Details od
JOIN Product p ON od.product_id = p.product_id
JOIN Orders o ON o.order_id = od.order_id
WHERE 
    o.order_date >= '2025-06-01' AND o.order_date <= '2025-06-30'
GROUP BY p.product_id, product_name
ORDER BY total_sold DESC
LIMIT 10;
```

**Execution Before Optimization:** `109.516 sec`

**Execution After Optimization:** `92.203 sec`

**Optimization Technique:**

```sql
CREATE INDEX idx_orderdetails_orderid_productid_qty_price ON Order_Details(order_id, product_id, quantity, unit_price);
CREATE INDEX idx_orders_order_date_order_id ON Orders(order_date, order_id);
```

---

## ✅ Query 8: Calculate Revenue for June 12, 2025

**Description:** Calculates total revenue for orders on June 12, 2025, by joining orders and order details.

```sql
SELECT 
    o.order_date,
    SUM(quantity * unit_price) AS total_revenue
FROM 
    Orders o
JOIN Order_Details od ON o.order_id = od.order_id
WHERE 
    o.order_date = '2025-06-12'
GROUP BY o.order_date;
```

**Execution Before Optimization:** `5.875 sec`

**Execution After Optimization:** `1.313 sec`

**Optimization Technique:**

```sql
CREATE INDEX idx_orderdetails_orderid_qty_price ON Order_Details(order_id, quantity, unit_price);
```

---

## ✅ Query 9: Aggregate Revenue and Quantity by Category

**Description:** Aggregates total quantity and revenue per product category, joining categories, products, and order details.

```sql
SELECT 
    category_name,
    SUM(quantity) AS total_quantity,
    SUM(quantity * unit_price) AS total_revenue
FROM Category c
JOIN Product p ON c.category_id = p.category_id
JOIN Order_Details od ON od.product_id = p.product_id
GROUP BY c.category_id, c.category_name
ORDER BY total_revenue DESC;
```

**Execution Before Optimization:** `363.781 sec`

**Execution After Optimization:** `143.734 sec`

**Optimization Technique:**

```sql
CREATE INDEX idx_product_categoryid_productid ON Product(category_id, product_id);
```

---

## ✅ Query 10: List Low Stock Products

**Description:** Retrieves products with stock quantity ≤ 10, ordered by stock quantity.

```sql
SELECT product_id, product_name, price, stock_quantity 
FROM Product
WHERE stock_quantity <= 10
ORDER BY stock_quantity ASC;
```

**Execution Before Optimization:** `1.016 sec`

**Execution After Optimization:** `0.031 sec`

**Optimization Technique:**

```sql
CREATE INDEX idx_product_stock ON Product(stock_quantity);
```

---



