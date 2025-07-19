# E-Commerce SQL Tasks

This project contains SQL scripts to perform various database tasks for an e-commerce system.

---

## Task List

### 1. Create Database Schema
- Create tables for categories, products, customers, orders, and order details.
- [createtables.txt](createtables.txt)

### 2. Generate Daily Revenue Report
- Generate total revenue per day based on order dates.
- [dailyrevenue.txt](dailyrevenue.txt)

### 3. Generate Monthly Top-Selling Products Report
- Retrieve the top-selling products in the previous month.
- [topsellingproducts.txt](topsellingproducts.txt)

### 4. List High-Value Customers
- Retrieve customers who spent more than $500 in the previous month.
- [highvaluecustomers.txt](highvaluecustomers.txt)

### 5. Search for Products Containing "Camera"
- Search for products where the name or description contains the word "camera".
- [searchcamera.txt](searchcamera.txt)

### 6. Trigger to Log Sale History
- Automatically log sale history (customer, product, quantity, total) when a new order is placed.
- [triggersalehistory.txt](triggersalehistory.txt)

### 7. Lock Quantity Field for a Product
- Lock the quantity field for product with ID 211 during update operations.
- [lockquantity.txt](lockquantity.txt)

### 8. Lock Product Row
- Lock the entire row for product ID 211 to prevent concurrent updates.
- [lockrow.txt](lockrow.txt)
