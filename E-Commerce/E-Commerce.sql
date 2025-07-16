Create Database Ecommerce;
Use Ecommerce;






-- Customer Table
CREATE TABLE Customers (
    Customer_id varchar(100) PRIMARY key,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(300)  NOT NULL,
    Password VARCHAR(200) NOT NULL,
    Phone_Number VARCHAR(100),
    Address TEXT,
    Created_at DATE
);





-- Categories Table

CREATE TABLE categories (
    Category_Id float PRIMARY KEY not null,
    Category_Name_no VARCHAR(100) NOT NULL,
    Description TEXT
);







-- Products Table
CREATE TABLE products (
    Product_Id float primary key,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    Category_Id Float NOT NULL,
    Stock_quantity float,
    brand VARCHAR(300),
    FOREIGN KEY (Category_Id) REFERENCES categories(Category_Id )
);







-- Orders Table
CREATE TABLE orders (
    Order_id varchar(300) primary key,
    Customer_id varchar(300),
    Order_date DATE,
    total_amount DECIMAL(10, 2),
    Shipping_Address TEXT,
    Status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);








-- Order Items Table
CREATE TABLE order_items (
    Order_Item_Id varchar(300) PRIMARY KEY,
    Order_Id varchar(300),
    Product_Id float,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);






-- Cart Table
CREATE TABLE cart (
    Cart_Id varchar(300) PRIMARY KEY,
    Customer_Id varchar(100),
    Created_At DATE,
    FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_Id)
);








-- Cart Items Table
CREATE TABLE cart_items (
    Cart_Item_Id varchar(300) PRIMARY KEY,
    Cart_Id varchar(300),
    Product_Id float,
    Quantity INT,
    FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);









-- Payment Table

CREATE TABLE payment (
    Payment_Id INT PRIMARY KEY,
    Order_Id varchar(300),
    Payment_Date DATE,
    Amount DECIMAL(10, 2),
    Payment_Method VARCHAR(100),
    Payment_Status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);






-- Review Table

CREATE TABLE reviews (
    Review_Id INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Id varchar(100),
    Product_Id float,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    Review_Date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);







-- Shipping Table

CREATE TABLE shipping (
    Shipping_Id INT PRIMARY KEY AUTO_INCREMENT,
    Order_Id varchar(300),
    Shipping_Method VARCHAR(100),
    Tracking_Number VARCHAR(300),
    Shipping_Status VARCHAR(50),
    Shipped_Date DATE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);












-- View all Customers
SELECT 
    *
FROM
    customers;




-- List All Products with Their Category Description
SELECT 
    p.Product_Id,
    p.Name AS Product_Name,
    c.Description,
    p.Price,
    p.Brand
FROM
    products p
        JOIN
    categories c ON c.Category_Id = p.Category_Id;





-- Get Total Number of Oders Placed
SELECT 
    COUNT(*) AS Total_Orders
FROM
    orders;





-- Get All Orders Placed by a Specific Customer Name
SELECT 
    o.Order_id,
    c.Customer_Name,
    o.Order_date,
    o.total_amount,
    o.Shipping_Address,
    o.Status
FROM
    orders o
        JOIN
    Customers c ON o.Customer_id = c.Customer_id
WHERE
    Customer_Name = 'Norma Fisher';





-- Total Sales per Product with thier Total Revenue
SELECT 
    p.Name AS Product_Name,
    p.Brand,
    SUM(oi.Quantity) AS Total_Sales,
    SUM(oi.Quantity * oi.Price) AS Total_Revenue
FROM
    products p
        JOIN
    order_items oi ON oi.Product_Id = p.Product_Id
GROUP BY p.Product_Id , p.Name , p.brand;







-- Most Popular Product (by quantity sold)
SELECT 
    p.Name AS Product_Name, SUM(oi.Quantity) AS Total_Sold
FROM
    Products p
        JOIN
    order_items oi ON oi.Product_Id = p.Product_Id
GROUP BY p.Product_Id
ORDER BY Total_Sold DESC;







-- View All Reviews for a Product
SELECT 
    r.Rating, r.Comment, c.Customer_Name, r.Review_Date
FROM
    reviews r
        JOIN
    customers c ON c.Customer_id = r.Customer_id
WHERE
    Review_Id = 890;







-- List All Orders with Payment Status
SELECT 
    o.Order_Id,
    o.total_amount,
    p.Payment_Method,
    p.Payment_Status
FROM
    payment p
        JOIN
    orders o ON o.Order_id = p.Order_Id;







-- Products Out of Stock
SELECT 
    name AS Product_Name, Stock_quantity
FROM
    products
WHERE
    Stock_quantity = 0;






-- Total Revenue by Each Customer
SELECT 
    c.Customer_Name, SUM(o.total_amount) AS Total_Revenue
FROM
    customers c
        JOIN
    orders o ON o.Customer_id = c.Customer_id
GROUP BY c.Customer_id
ORDER BY Total_Revenue DESC;







-- View Cart Items of a Specific Customer
SELECT 
    p.Name AS Product_Name, p.Brand, c.Created_At, ci.Quantity
FROM
    cart_items ci
        JOIN
    cart c ON ci.Cart_Id = c.Cart_Id
        JOIN
    products p ON p.Product_Id = ci.Product_Id;









-- VEIWS::

-- Customer Order Summary
CREATE VIEW Customer_Order_Summary AS
    SELECT 
		c.Customer_id,
        c.Customer_Name,
        c.Email,
        c.Phone_Number,
        SUM(o.total_amount) AS Total_Spent
    FROM
        customers c
            JOIN
        orders o ON o.Customer_id = c.Customer_id
    GROUP BY c.Customer_id,c.Customer_Name,c.Email,c.Phone_Number
;


select *from customer_order_summary where Customer_Name like 'Jorge Sullivan';








-- Product Inventory with Category
CREATE VIEW Product_Inventory AS
    SELECT 
        p.product_id,
        p.Name AS Product_Name,
        p.Brand AS Brand,
        p.Price,
        p.Stock_Quantity
    FROM
        products p
            JOIN
        categories c ON c.Category_Id = p.Category_Id
;


select *from product_inventory where Stock_Quantity < 67;









-- Order Details with Items

create view Order_Details as
select 
	o.Order_Id,
    o.Order_Date,
	c.Customer_Name,
    p.name as Product_Name,
    p.Brand,
    o.Shipping_Address,
    oi.Quantity,
    (oi.Quantity * oi.Price) as Total_Amount
from orders o
join customers c on c.Customer_id = o.Customer_id
join order_items oi on oi.Order_Id = o.Order_id
join products p on p.Product_Id = oi.Product_Id
;


select *from order_details where customer_name in ("Norma Fisher","Jorge Sullivan");











-- Procedure ::

-- Add New Customer
DELIMITER $$

CREATE PROCEDURE Add_New_Customer(
    IN p_customer_id VARCHAR(100),
    IN p_customer_name VARCHAR(100),
    IN p_email VARCHAR(300),
    IN p_password VARCHAR(200),
    IN p_phone_number VARCHAR(100),
    IN p_address TEXT,
    IN p_created_at DATE
)
BEGIN
    INSERT INTO customers (
        Customer_Id,
        Customer_Name,
        Email,
        Password,
        Phone_Number,
        Address,
        Created_At
    )
    VALUES (
        p_customer_id,
        p_customer_name,
        p_email,
        p_password,
        p_phone_number,
        p_address,
        p_created_at
    );
END$$

DELIMITER ;


CALL Add_New_Customer(
    'CUST009999',
    'Shubham Thakur',
    'shubham@email.com',
    'Shubham@123',
    '9876543210',
    'Bhubaneswar, India',
    '2025-07-12'
);

SELECT 
    *
FROM
    customers
WHERE
    Customer_id = 'CUST009999';








-- Place a New Order
DELIMITER $$
Create Procedure Place_New_Order(
	IN p_Order_Id varchar(300),
    IN p_Customer_Id varchar(300),
    IN p_Order_Date date,
    IN p_Total_Amount decimal(10,2),
    IN p_Shipping_Address text,
    IN p_Status varchar(50)
)
Begin
	Insert into orders(Order_Id,Customer_Id,Order_Date,Total_Amount,Shipping_Address,Status)
    values (p_Order_Id,p_Customer_Id,p_Order_Date,p_Total_Amount,p_Shipping_Address,p_Status);
End $$


DELIMITER ;

CALL Place_New_Order('ORD10001','CUST009999','2025-07-12','899.99','Bhubaneswar, India', 'Pending');

SELECT 
    *
FROM
    orders
WHERE
    Order_id = 'ORD10001';
    






    
-- Add Order Item
describe order_items;
SELECT 
    *
FROM
    categories;
INSERT INTO categories(Category_Id, Category_Name_no,Description)
VALUES (453,'Category_50566','Graphics Cards');


SELECT 
    *
FROM
    products;
insert into products(Product_Id,Name,Description,Price,Category_Id,Stock_Quantity,Brand) 
values (900000,'Nvdia RTX 400','GPU with fan and cooling functionality',890.14,453,49,'Nvdia');

DELIMITER $$
Create Procedure Add_Order_Item(
	IN p_Order_Item_Id varchar(300),
    IN p_Order_Id varchar(300),
    IN p_Product_Id float,
    In p_Quantity int,
    IN p_Price decimal(10,2)
)
Begin
	Insert into order_items(Order_Item_Id,Order_Id,Product_Id,Quantity,Price)
    values(p_Order_Item_Id,p_Order_Id,p_Product_Id,p_Quantity,p_Price);
End $$

DELIMITER ;



CALL Add_Order_Item(
    'OI1001',         -- p_Order_Item_Id
    'ORD10001',          -- p_Order_Id
    900000,           -- p_Product_Id (e.g., NVIDIA RTX 400)
    2,                -- p_Quantity
    890.14            -- p_Price per unit
);

SELECT 
    *
FROM
    order_items
WHERE
    Order_Id = 'ORD10001';







-- Process_Payment

SELECT 
    *
FROM
    Payment;
describe payment;

DELIMITER $$
Create Procedure Process_Payment(
	IN p_Payment_Id int,
    IN p_Order_Id varchar(300),
    IN p_Payment_Date date,
    IN p_Amount decimal(10,2),
    IN p_Payment_Method varchar(100),
    IN p_Payment_Status varchar(50)
)
Begin
	Insert into payment(Payment_Id,Order_Id,Payment_Date,Amount,Payment_Method,Payment_Status)
    values(p_Payment_Id,p_Order_Id,p_Payment_Date,p_Amount,p_Payment_Method,p_Payment_Status);
End $$

DELIMITER ;

CALL Process_Payment(45664,'ORD10001','2025-07-12','890.14','UPI','Completed');






-- Add_Shipping_Info
describe shipping;
SELECT 
    *
FROM
    shipping;
DELIMITER $$
Create Procedure Add_Shipping_Info(
	IN p_Shipping_ID int,
    IN p_Order_Id varchar(300),
    IN p_Shipping_Method varchar(100),
    IN p_Tracking_Number varchar(100),
    IN p_Shipping_Status varchar(50),
    IN p_Shipped_Date date
)
Begin
	Insert into shipping(Shipping_Id,Order_Id,Shipping_Method,Tracking_Number,Shipping_Status,Shipped_Date)
    values(p_Shipping_Id,p_Order_Id,p_Shipping_Method,p_Tracking_Number,p_Shipping_Status,p_Shipped_Date);
End $$;

DELIMITER ;


CALL Add_Shipping_Info(2002,'ORD10001','BlueDart','TRK1234567','Shipped','2025-07-13');

SELECT 
    *
FROM
    shipping
WHERE
    Shipping_Method = 'BlueDart';








