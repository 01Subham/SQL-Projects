create database product_sales;
use product_sales;

create table customer(
	Customer_Id varchar(50) primary key,
    Customer_Name varchar(100) not null,
    Customer_Location varchar(500) not null,
    Region varchar(50)
);



create table Product(
	Product_code varchar(50) primary key,
    Type varchar(50),
    Brand varchar(50),
    Product_Specification varchar(200),
    Price decimal(10,2) not null
);


create table Orders(
	Order_Id int primary key,
    Product_Code varchar(50),
    Customer_Id varchar(50),
    Inward_Date date,
    Dispatch_Date date,
    Quantity_Sold Float,
    Price decimal(10,2),
    foreign key (Product_code) references Product(Product_code),
    foreign key (Customer_Id) references Customer(Customer_Id)
);



Create table Product_Specification(
	Product_Code varchar(50) primary key,
    Brand varchar(50),
    Core_Specification varchar(255),
    Processor_Specification varchar(255),
    RAM varchar(50),
    ROM varchar(50),
    SSD varchar(50),
    foreign key(Product_Code) references Product(Product_code)
);





-- List all products from a specific brand
SELECT 
    Type, Brand, Price
FROM
    product
WHERE
    brand = 'Apple';
    
    



-- All orders placed by a specific customer
SELECT 
    o.Order_ID, p.Brand, c.Customer_Name, o.Price, o.Inward_Date
FROM
    Orders o
        JOIN
    Product p ON o.Product_Code = p.Product_Code
        JOIN
    Customer c ON c.Customer_Id = o.Customer_ID
WHERE
    o.Customer_ID = 'CUST_35693'
        AND o.Product_Code = '86EA8AE2';





-- Get the average price of laptops
SELECT 
    AVG(Price) AS AverageLaptopPrice
FROM
    Product
WHERE
    Type LIKE '%Laptop%';



-- Find products with 16GB RAM with it's Specifications
SELECT 
    p.Type,
    p.Brand,
    p.Price,
    ps.Core_Specification,
    ps.Processor_Specification,
    ps.RAM,
    ps.ROM,
    ps.SSD
FROM
    product_specification ps
        JOIN
    product p ON ps.product_code = p.product_code
WHERE
    RAM LIKE '16GB';




-- Total sales amount per customer
SELECT 
    c.Customer_Name,
    SUM(o.Quantity_Sold * o.Price) AS Total_Spent
FROM
    Orders o
        JOIN
    Customer c ON o.Customer_Id = c.Customer_ID
GROUP BY c.Customer_Name
ORDER BY Total_Spent DESC;






-- Monthly sales trend
SELECT 
    MONTH(Dispatch_Date) AS Sales_Month,
    SUM(Quantity_Sold * Price) AS Monthly_Revenue
FROM
    orders
GROUP BY Sales_Month
ORDER BY Monthly_Revenue DESC;



-- List all orders with customer and product details
SELECT 
    o.Order_Id,
    c.Customer_Name,
    p.Type,
    p.Brand,
    o.Quantity_Sold AS Total_Quantity,
    SUM(o.Quantity_Sold * o.Price) AS Total_Amount,
    o.Inward_Date,
    o.Dispatch_Date,
    ps.Core_Specification,
    ps.Processor_Specification,
    ps.RAM,
    ps.ROM,
    ps.SSD
FROM
    orders o
        JOIN
    Product p ON o.Product_Code = p.Product_Code
        JOIN
    Customer c ON c.Customer_Id = o.Customer_Id
        JOIN
    Product_Specification ps ON o.Product_Code = ps.Product_Code
GROUP BY o.Order_Id , c.Customer_Name , p.Type , p.Brand , o.Quantity_Sold , o.Inward_Date , o.Dispatch_Date , ps.Core_Specification , ps.Processor_Specification , ps.RAM , ps.ROM , ps.SSD
ORDER BY Total_Amount DESC;



-- Identify Top 5 Best-Selling Products by Quantity
SELECT 
    p.Type,
    p.Brand,
    SUM(o.Quantity_Sold * o.Price) AS TotalSalesByQuantity
FROM
    orders o
        JOIN
    Product p ON o.product_code = p.product_code
GROUP BY p.Brand , p.Type
ORDER BY TotalSalesByQuantity DESC
LIMIT 5;



-- Customers_Purchased_Laptops
CREATE VIEW Customer_Purchased_Laptops AS
    SELECT 
        c.Customer_ID,
        c.Customer_Name,
        c.Customer_Location,
        c.Region,
        SUM(o.Quantity_Sold) AS Total_Laptop_Quantity_Purchased,
        SUM(o.Quantity_Sold * o.Price) AS Total_Spent_On_Laptops
    FROM
        Customer c
            JOIN
        Orders o ON c.Customer_ID = o.Customer_ID
            JOIN
        Product p ON o.Product_Code = p.Product_Code
    WHERE
        p.Type = 'Laptop'
    GROUP BY c.Customer_ID , c.Customer_Name , c.Customer_Location , c.Region
    ORDER BY Total_Spent_On_Laptops DESC;



SELECT 
    *
FROM
    Customer_Purchased_Laptops;




--  Customers_Purchased_Laptops
CREATE VIEW Customer_Purchased_Mobile_Phone AS
    SELECT 
        c.Customer_ID,
        c.Customer_Name,
        c.Customer_Location,
        c.Region,
        SUM(o.Quantity_Sold) AS Total_Mobile_Phone_Quantity_Purchased,
        SUM(o.Quantity_Sold * o.Price) AS Total_Spent_On_Mobile_Phones
    FROM
        Customer c
            JOIN
        orders o ON c.Customer_Id = o.Customer_Id
            JOIN
        product p ON o.Product_Code = p.Product_Code
    WHERE
        p.type = 'Mobile Phone'
    GROUP BY c.Customer_ID , c.Customer_Name , c.Customer_Location , c.Region
    ORDER BY Total_Spent_On_Mobile_Phones DESC
;

	

SELECT 
    *
FROM
    Customer_Purchased_Mobile_Phone;


