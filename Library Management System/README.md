
# 📚 Library Management System (SQL-Based)

This project is a **SQL-based Library Management System** designed to manage books, authors, members, and loan transactions efficiently. It includes schema creation, sample queries, and views to support basic to intermediate database operations.

---

## 🔧 Database Setup

```sql
CREATE DATABASE Library;
USE Library;
```

---

## 🧱 Table Definitions

### 1. Authors
```sql
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    nationality VARCHAR(50)
);
```

### 2. Books
```sql
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(200),
    author_id INT,
    publication_year INT,
    genre VARCHAR(20),
    pages INT,
    available_copies INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);
```

### 3. Members
```sql
CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    join_date DATE,
    membership_type VARCHAR(20)
);
```

### 4. Loans
```sql
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE,
    due_date DATE,
    return_date DATE,
    fine_amount DECIMAL(5,2),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
```

---

## 📄 Sample Queries

### 🔹 List all Books of a Specific Genre
```sql
SELECT title, genre, publication_year, available_copies
FROM Books
WHERE genre = 'Science';
```

### 🔹 Find Members with Premium Membership
```sql
SELECT CONCAT(first_name, ' ', last_name) AS full_name, membership_type
FROM Members
WHERE membership_type = 'Premium';
```

### 🔹 Count Total Number of Books
```sql
SELECT title AS Name_of_Book, genre, SUM(available_copies) AS Total_books
FROM Books
GROUP BY title, genre;
```

### 🔹 Books Published Before 1995
```sql
SELECT title, publication_year
FROM Books
WHERE publication_year < 1995;
```

### 🔹 Books Written by a Particular Author
```sql
SELECT b.title, b.genre, b.publication_year
FROM Books b
JOIN Authors a ON b.author_id = a.author_id
WHERE a.first_name = 'Danielle' AND a.last_name = 'Johnson';
```

### 🔹 Members Who Joined in 2022
```sql
SELECT * FROM Members
WHERE YEAR(join_date) = 2022;
```

### 🔹 Total Fine Collected from All Members
```sql
SELECT SUM(fine_amount) AS total_fine
FROM Loans;
```

### 🔹 Show All Members and Their Loans
```sql
SELECT CONCAT(m.first_name, ' ', m.last_name) AS full_name, l.book_id
FROM Members m
INNER JOIN Loans l ON m.member_id = l.member_id;
```

### 🔹 Member Who Paid the Highest Fine
```sql
SELECT first_name, last_name
FROM Members
WHERE member_id = (
    SELECT member_id
    FROM Loans
    ORDER BY fine_amount DESC
    LIMIT 1
);
```

---

## 👁️ View: Member Fine Summary

### Create View
```sql
CREATE VIEW Member_Fines AS
SELECT 
    m.member_id,
    CONCAT(m.first_name, ' ', m.last_name) AS full_name,
    SUM(l.fine_amount) AS total_fine
FROM Members m
JOIN Loans l ON m.member_id = l.member_id
GROUP BY m.member_id, m.first_name, m.last_name;
```

### Use the View
```sql
SELECT * FROM Member_Fines;
```

---

## ✅ Features Implemented
- Book and author management
- Member and loan tracking
- Genre and publication filtering
- Fine calculation and reporting
- SQL view for summary report

---

## 📌 Requirements
- MySQL or MariaDB
- SQL Client (e.g., MySQL Workbench, DBeaver)

---


