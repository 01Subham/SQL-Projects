
# 📊 Product Sales Database Project

This project implements a relational database system named `product_sales`, designed to manage product details, customer information, and order transactions. It also includes analytical queries and views for business insights.

---

## 📁 Database Name
```sql
CREATE DATABASE product_sales;
USE product_sales;
```

---

## 🏗️ Tables

### 1. `Customer`
Stores customer information.

```sql
CREATE TABLE Customer (
    Customer_Id VARCHAR(50) PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Customer_Location VARCHAR(500) NOT NULL,
    Region VARCHAR(50)
);
```

### 2. `Product`
Stores basic product data.

```sql
CREATE TABLE Product (
    Product_code VARCHAR(50) PRIMARY KEY,
    Type VARCHAR(50),
    Brand VARCHAR(50),
    Product_Specification VARCHAR(200),
    Price DECIMAL(10,2) NOT NULL
);
```

### 3. `Orders`
Stores transaction data between customers and products.

```sql
CREATE TABLE Orders (
    Order_Id INT PRIMARY KEY,
    Product_Code VARCHAR(50),
    Customer_Id VARCHAR(50),
    Inward_Date DATE,
    Dispatch_Date DATE,
    Quantity_Sold FLOAT,
    Price DECIMAL(10,2),
    FOREIGN KEY (Product_Code) REFERENCES Product(Product_code),
    FOREIGN KEY (Customer_Id) REFERENCES Customer(Customer_Id)
);
```

### 4. `Product_Specification`
Detailed technical specs of each product.

```sql
CREATE TABLE Product_Specification (
    Product_Code VARCHAR(50) PRIMARY KEY,
    Brand VARCHAR(50),
    Core_Specification VARCHAR(255),
    Processor_Specification VARCHAR(255),
    RAM VARCHAR(50),
    ROM VARCHAR(50),
    SSD VARCHAR(50),
    FOREIGN KEY (Product_Code) REFERENCES Product(Product_code)
);
```

---

## 📈 Analytical Queries

### 🔹 List all products from a specific brand
```sql
SELECT Type, Brand, Price
FROM Product
WHERE Brand = 'Apple';
```

### 🔹 All orders placed by a specific customer
```sql
SELECT o.Order_ID, p.Brand, c.Customer_Name, o.Price, o.Inward_Date
FROM Orders o
JOIN Product p ON o.Product_Code = p.Product_Code
JOIN Customer c ON c.Customer_Id = o.Customer_Id
WHERE o.Customer_Id = 'CUST_35693' AND o.Product_Code = '86EA8AE2';
```

### 🔹 Average price of laptops
```sql
SELECT AVG(Price) AS AverageLaptopPrice
FROM Product
WHERE Type LIKE '%Laptop%';
```

### 🔹 Find products with 16GB RAM and their specs
```sql
SELECT p.Type, p.Brand, p.Price, ps.Core_Specification, ps.Processor_Specification, ps.RAM, ps.ROM, ps.SSD
FROM Product_Specification ps
JOIN Product p ON ps.Product_Code = p.Product_Code
WHERE ps.RAM LIKE '16GB';
```

### 🔹 Total sales amount per customer
```sql
SELECT c.Customer_Name, SUM(o.Quantity_Sold * o.Price) AS Total_Spent
FROM Orders o
JOIN Customer c ON o.Customer_Id = c.Customer_Id
GROUP BY c.Customer_Name
ORDER BY Total_Spent DESC;
```

### 🔹 Monthly sales trend
```sql
SELECT MONTH(Dispatch_Date) AS Sales_Month, SUM(Quantity_Sold * Price) AS Monthly_Revenue
FROM Orders
GROUP BY Sales_Month
ORDER BY Monthly_Revenue DESC;
```

### 🔹 All orders with customer and product details
```sql
SELECT o.Order_Id, c.Customer_Name, p.Type, p.Brand, o.Quantity_Sold AS Total_Quantity,
       SUM(o.Quantity_Sold * o.Price) AS Total_Amount, o.Inward_Date, o.Dispatch_Date,
       ps.Core_Specification, ps.Processor_Specification, ps.RAM, ps.ROM, ps.SSD
FROM Orders o
JOIN Product p ON o.Product_Code = p.Product_Code
JOIN Customer c ON c.Customer_Id = o.Customer_Id
JOIN Product_Specification ps ON o.Product_Code = ps.Product_Code
GROUP BY o.Order_Id, c.Customer_Name, p.Type, p.Brand, o.Quantity_Sold, o.Inward_Date, o.Dispatch_Date,
         ps.Core_Specification, ps.Processor_Specification, ps.RAM, ps.ROM, ps.SSD
ORDER BY Total_Amount DESC;
```

### 🔹 Top 5 best-selling products by quantity
```sql
SELECT p.Type, p.Brand, SUM(o.Quantity_Sold * o.Price) AS TotalSalesByQuantity
FROM Orders o
JOIN Product p ON o.Product_Code = p.Product_Code
GROUP BY p.Brand, p.Type
ORDER BY TotalSalesByQuantity DESC
LIMIT 5;
```

---

## 👁️ Views

### 🔸 `Customer_Purchased_Laptops`
Tracks customers who purchased laptops.

```sql
CREATE VIEW Customer_Purchased_Laptops AS
SELECT c.Customer_Id, c.Customer_Name, c.Customer_Location, c.Region,
       SUM(o.Quantity_Sold) AS Total_Laptop_Quantity_Purchased,
       SUM(o.Quantity_Sold * o.Price) AS Total_Spent_On_Laptops
FROM Customer c
JOIN Orders o ON c.Customer_Id = o.Customer_Id
JOIN Product p ON o.Product_Code = p.Product_Code
WHERE p.Type = 'Laptop'
GROUP BY c.Customer_Id, c.Customer_Name, c.Customer_Location, c.Region
ORDER BY Total_Spent_On_Laptops DESC;
```

```sql
SELECT * FROM Customer_Purchased_Laptops;
```

### 🔸 `Customer_Purchased_Mobile_Phone`
Tracks customers who purchased mobile phones.

```sql
CREATE VIEW Customer_Purchased_Mobile_Phone AS
SELECT c.Customer_Id, c.Customer_Name, c.Customer_Location, c.Region,
       SUM(o.Quantity_Sold) AS Total_Mobile_Phone_Quantity_Purchased,
       SUM(o.Quantity_Sold * o.Price) AS Total_Spent_On_Mobile_Phones
FROM Customer c
JOIN Orders o ON c.Customer_Id = o.Customer_Id
JOIN Product p ON o.Product_Code = p.Product_Code
WHERE p.Type = 'Mobile Phone'
GROUP BY c.Customer_Id, c.Customer_Name, c.Customer_Location, c.Region
ORDER BY Total_Spent_On_Mobile_Phones DESC;
```

```sql
SELECT * FROM Customer_Purchased_Mobile_Phone;
```

---

## 📌 Notes
- Ensure that foreign key constraints are respected while inserting data.
- All monetary values are represented using `DECIMAL(10,2)` for currency precision.
- RAM, ROM, and SSD fields store string values like `'16GB'`, `'512GB'`, etc.

---

## ✅ Future Enhancements
- Add stock management and inventory control.
- Create stored procedures for automated reports.
- Integrate with visualization tools for dashboards.

---

## 🧑‍💻 Author
**Subham Thakur**

