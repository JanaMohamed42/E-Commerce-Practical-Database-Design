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

