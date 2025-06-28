
# 🛒 Retail Sales Analysis (SQL Project)

This project is a simple but insightful SQL-based analysis of retail sales data. The goal is to analyze key performance metrics like total revenue, sales trends, customer demographics, and product performance using structured queries on a MySQL database.

---

## 📁 Project Structure

- **Database Name:** `retail_sales_analysis`
- **Table Name:** `retail_sales`

### 📊 Table Schema

```sql
CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    date DATE,
    customer_id VARCHAR(100),
    gender CHAR(50),
    age FLOAT,
    product_category VARCHAR(50),
    quantity INT,
    price_per_unit FLOAT,
    total_amount FLOAT
);
```

---


## 🧠 SQL Queries & Analysis

### 🔸 View All Transactions
```sql
SELECT * FROM retail_sales;
```

### 💰 Total Revenue Generated
```sql
SELECT SUM(total_amount) AS Total_Revenue
FROM retail_sales;
```

### 📦 Transactions Per Product Category
```sql
SELECT product_category, COUNT(*) AS Transaction_Count
FROM retail_sales
GROUP BY product_category;
```

### 📅 Monthly Sales Trend
```sql
SELECT MONTH(date) AS Month, SUM(total_amount) AS Monthly_Sales
FROM retail_sales
GROUP BY MONTH(date);
```

### 🗓️ Transactions Between July to November
```sql
SELECT * FROM retail_sales
WHERE MONTH(date) IN (7, 11);
```

### 👥 Total Sales by Gender
```sql
SELECT gender, SUM(total_amount) AS Total_Sales
FROM retail_sales
GROUP BY gender;
```

### 🧒 Customers Aged Under 30
```sql
SELECT * FROM retail_sales
WHERE age < 30;
```

### 📈 Product Performance

#### 🔹 Highest Revenue by Product Category
```sql
SELECT product_category, SUM(total_amount) AS Highest_Revenue
FROM retail_sales
GROUP BY product_category
ORDER BY Highest_Revenue DESC;
```

#### 🔹 Most Frequently Purchased Category
```sql
SELECT product_category, COUNT(*) AS Total_Quantity
FROM retail_sales
GROUP BY product_category
ORDER BY Total_Quantity DESC
LIMIT 1;
```

### 🧾 Verify Total Calculation (Quantity × Price)
```sql
SELECT *, (quantity * price_per_unit) AS calculate_total
FROM retail_sales;
```

### 🥇 Top 5 Transactions by Value
```sql
SELECT * FROM retail_sales
ORDER BY total_amount DESC
LIMIT 5;
```


## 📌 Tools Used

- **MySQL / MariaDB**
- **SQL (Structured Query Language)**
- (Optional: Excel / Power BI / Python for visualization)

---

## 📚 What You Can Learn

- Creating and managing SQL databases
- Writing advanced `SELECT`, `GROUP BY`, `ORDER BY`, and aggregate functions
- Real-world data analysis using SQL
- Identifying trends and patterns from structured data

---

## 🚀 Future Improvements

- Normalize tables for better scalability
- Add `region`, `store`, or `product_id` fields
- Visualize insights using Python, Power BI, or Tableau
- Create stored procedures and triggers

---

## 📬 Contact

**Author:** Subham Thakur  
Feel free to connect or suggest improvements!
