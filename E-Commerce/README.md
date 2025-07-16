
# 🛍️ E-Commerce SQL Database Project

## 📘 Overview

This project simulates an **E-commerce relational database system** using MySQL. It includes a comprehensive schema with customers, products, orders, carts, payments, reviews, and shipping details, along with SQL views, queries, and stored procedures to manage real-world operations.

---

## 🗂️ Database Name
```sql
CREATE DATABASE Ecommerce;
USE Ecommerce;
```

---

## 📄 Tables Created

1. **Customers**
2. **Categories**
3. **Products**
4. **Orders**
5. **Order_Items**
6. **Cart**
7. **Cart_Items**
8. **Payment**
9. **Reviews**
10. **Shipping**

Each table uses proper **primary keys** and **foreign key relationships** to enforce referential integrity.

---

## 🔗 Relationships

| Relationship | Description |
|--------------|-------------|
| Customers → Orders | One-to-Many |
| Customers → Cart | One-to-One/Many |
| Orders → Order_Items | One-to-Many |
| Orders → Payment | One-to-One |
| Orders → Shipping | One-to-One |
| Cart → Cart_Items | One-to-Many |
| Products → Categories | Many-to-One |
| Products → Reviews | One-to-Many |
| Products → Order_Items | One-to-Many |
| Products → Cart_Items | One-to-Many |
| Customers → Reviews | One-to-Many |

---

## 🔍 Key Queries

- View all customers
- List products with category
- Count total orders
- Orders by a customer
- Product sales & revenue
- Most popular product
- Reviews for a product
- Orders with payment status
- Products out of stock
- Revenue by customer
- Cart contents

---

## 👁️‍🗨️ SQL Views

- `Customer_Order_Summary`: Customer spending overview
- `Product_Inventory`: Inventory with price/stock
- `Order_Details`: Complete order detail with product & customer info

---

## ⚙️ Stored Procedures

| Procedure Name        | Description |
|-----------------------|-------------|
| `Add_New_Customer`    | Insert new customer |
| `Place_New_Order`     | Insert new order |
| `Add_Order_Item`      | Insert order item |
| `Process_Payment`     | Record payment |
| `Add_Shipping_Info`   | Add shipping record |

All procedures are tested with real sample data and are fully functional.

---

## 🧪 Sample Data Added

- Customer: `Shubham Thakur`
- Order: `ORD10001`
- Product: `Nvidia RTX 400`
- Category: `Graphics Cards`
- Order Item, Payment, Shipping records added and verified

---

## 🧾 E-R Diagram

> <img width="2201" height="2320" alt="E-R Model" src="https://github.com/user-attachments/assets/0f14cbc8-ccca-4849-ba19-c715f23b33e2" />


```

```

---
```

---

## 🚀 Future Add-ons

- Triggers for auto stock update
- More stored procedures (update/delete)
- Discount & coupons table
- Admin/roles support
- Enhanced shipping tracking

---

## 👨‍💻 Created By

**Shubham Thakur**  



---

> ⭐ *This project is fully expandable and a strong base for data analytics using Python or full-stack development with front-end + backend integration.*
