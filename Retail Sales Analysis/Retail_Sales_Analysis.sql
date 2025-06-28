create database retail_sales_analysis;
use retail_sales_analysis;

create table retail_sales(
	transaction_id int primary key,
    date date,
    customer_id varchar(100),
    gender char(50),
    age float,
    product_category varchar(50),
    quantity int,
    price_per_unit float,
    total_amount float
);

-- View All Transactions
select *from retail_sales;



-- Total Revenu Generated
select sum(total_amount) as Total_Revenue
from retail_sales;

-- Transactions were made in each product category.
select Product_Category, count(*) as Transaction_Count
from retail_sales
group by product_category;


-- Total sales for each month.
select month(date) as Month, sum(total_amount) as Monthly_Sales
from retail_sales
group by month(date);

-- All Transactions that occured between July to November.
select *from retail_sales
where month(date) in (7,11);


-- Total Sales by Gender
select Gender, sum(total_amount) as Total_Sales
from retail_sales
group by Gender;

-- All Transactions by customers aged under 30.
select *from retail_sales
where age < 30;



-- Which product generated the highest revenue..
select Product_Category, sum(total_amount) as Highest_Revenue
from retail_sales
group by Product_Category
order by Highest_Revenue desc;

-- Most frequently purchased per category...
select Product_Category, count(*) as Total_Quantity
from retail_sales
group by Product_Category
order by Total_Quantity desc
limit 1;

-- Calculate the actual total amount from quantity × price (to verify data).
select *,(quantity * price_per_unit) as calculate_total
from retail_sales;


-- Top 5 Transactions with the highest value.
select *from retail_sales
order by total_amount
limit 5;

