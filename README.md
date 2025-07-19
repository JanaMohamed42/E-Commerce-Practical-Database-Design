# E-Commerce SQL Tasks

This project contains SQL scripts to perform various database tasks for an e-commerce system.

---

## Task List

### 1. Create Database Schema
- Create tables for categories, products, customers, orders, and order details.
- [createtables.sql](createtables.sql)

### 2. Generate Daily Revenue Report
- Generate total revenue per day based on order dates.
- [dailyrevenue.sql](dailyrevenue.sql)

### 3. Generate Monthly Top-Selling Products Report
- Retrieve the top-selling products in the previous month.
- [topsellingproducts.sql](topsellingproducts.sql)

### 4. List High-Value Customers
- Retrieve customers who spent more than $500 in the previous month.
- [highvaluecustomers.sql](highvaluecustomers.sql)

### 5. Search for Products Containing "Camera"
- Search for products where the name or description contains the word "camera".
- [searchcamera.sql](searchcamera.sql)

### 6. Trigger to Log Sale History
- Automatically log sale history (customer, product, quantity, total) when a new order is placed.
- [triggersalehistory.sql](triggersalehistory.sql)

### 7. Lock Quantity Field for a Product
- Lock the quantity field for product with ID 211 during update operations.
- [lockquantity.sql](lockquantity.sql)

### 8. Lock Product Row
- Lock the entire row for product ID 211 to prevent concurrent updates.
- [lockrow.sql](lockrow.sql)
