 -- window functions
 
 use joinscustomerdb;
 
-- Create the Students table
CREATE TABLE Students (
    StudentID INT,
    Subject VARCHAR(50),
    Marks INT
);

-- Insert data into the Students table
INSERT INTO Students (StudentID, Subject, Marks)
VALUES
(1, 'Maths', 90),
(2, 'Maths', 88),
(3, 'Maths', 88),
(4, 'Maths', 70),
(1, 'History', 87),
(2, 'History', 80),
(3, 'History', 77),
(4, 'History', 70);

select * from students;

select *,
rank() over(partition by Subject order by marks desc) as rank_x,
dense_rank() over(partition by Subject order by marks desc) as dense_rank_x,
row_number() over(partition by Subject order by marks desc) as row_number_x
from Students;
-- where row_number_x = 2;

select * from
(select * , rank() over (partition by Subject order by Marks desc) as rnk,
dense_rank() over (partition by Subject order by Marks desc) as dense_rnk,
row_number() over (partition by Subject order by Marks desc) as row_rnk
 from students) as sub_table where row_rnk<=2 or dense_rnk<=2 ;

-- rank upto 2
select * from
(select * ,rank() over (partition by Subject order by marks desc) as rnk from students) as sub_table
where rnk <=2;

-- retrieve student id and marks of top performer in each subject -- using rank -- more than 1 person can be top
select StudentID ,Marks ,rank_x from
(select * , RANK() OVER (PARTITION BY Subject ORDER BY Marks DESC) as rank_x from students) as  sub_table
where rank_x <2;
-- or rank_x=1

-- same marks same rank
select * , dense_rank() OVER (PARTITION BY Subject ORDER BY Marks DESC) as rank_x from students;

-- unique rank , second highest
select * from
(select * , row_number() OVER (PARTITION BY Subject ORDER BY Marks DESC) as row_x from students) as sub_table
where row_x =2;

-- find customers who placed most order in last 12 month, rank them by number of orders

select * , dense_rank() over(order by total_ordr desc) as rnk
from
(select CustomerID ,count(OrderID) as total_ordr
from  orders
where OrderDate <= current_date() - interval 12 month
group by 1 ) as sub_table;


select * from products;

-- find rank of product based on price within each category

select ProductName ,Category,Price , 
dense_rank() over(partition by Category order by Price desc) as rnk
from products
order by Category,rnk;


-- find avg total for each customer
select avg(TotalAmount) from orders;

select  CustomerID ,
round(avg(TotalAmount) over(partition by CustomerID),2) as avg_amt
from orders;

select CustomerID, OrderID,
round(avg(TotalAmount) over(partition by CustomerID),2) as avg_order_total
from Orders;

-- Find the Running Total of Products Sold (Quantity) for Each Product
select o.ProductID ,p.ProductName ,o.OrderID,
sum(Quantity) over(partition by o.ProductID ORDER BY o.OrderDate) as running_total
from orders o join products p
on o.ProductID =p.ProductID
order by  o.ProductID,o.OrderDate;

-- Running Total Clarification: For a true running total, 
-- you need to sort the rows within each product by a specific order, such as OrderID.
-- SUM(Quantity) OVER: Calculates the running total by partitioning the data by ProductID 
-- and ordering within each partition by OrderID.

select ProductID ,OrderID,Quantity from orders order by ProductID,OrderID;

-- Find the Average Price of Products for Each Product Category.Use AVG() as a window function

select  Category,ProductName,Price,
round(avg(Price) over(partition by Category),2) as avg_price
from products
order by Category,ProductName;

-- Removed ORDER BY Inside OVER(): The ORDER BY within the OVER() clause is not needed for computing 
-- the average because the average calculation is based on the entire partition, not on a cumulative or running total.


-- Find the Cumulative Total Spend for Each Customer Across All Orders.

select CustomerID,ProductID,
sum(TotalAmount) over(partition by CustomerID order by OrderDate)  as Cumulative_Total 
from orders
order by CustomerID,ProductID;

select CustomerID,ProductID,TotalAmount
from orders
order by CustomerID,ProductID;
select * from orders;


----------------------



create table funct (
OrderID int unique,	ProductID int,Category char(1) ,Price decimal(5,1),	Quantity int,Salesperson varchar(10) );

insert into funct values (1,	101,	'A'	,50.0,	2	,'Alice'),
(2,	102,'A'	,30.0,	5	,'BOB'),
(3,	103,'B'	,20.0,	3	,'Alice'),
(4,	104,'B'	,40.0,	4	,'CAROL'),
(5,	105,'A'	,60.0,	1	,'BOB');

select * from funct;

-- 1. ROW_NUMBER(): Assigns a unique number to each row within a partition.
-- Use Case: Rank products within categories based on price.

select *,
row_number() over (partition by Category order by Price desc) as rnk
from funct;


-- 2. RANK(): Assigns ranks but gives the same rank to ties, skipping numbers.
-- Use Case: Rank products in categories, with ties.

select  Category,ProductID,Price,
rank() over (partition by Category order by Price desc ) as rank_num
from funct ;

-- 3. DENSE_RANK(): Similar to RANK() but does not skip numbers.
-- Use Case: Dense ranking without skipping numbers on ties

select  Category,ProductID,Price,
dense_rank() over (partition by Category order by Price desc ) as rdense_rank_num
from funct ;

-- 4. NTILE(n): Divides rows into n equal groups and assigns a group number.
-- Use Case: Divide products into two price-based groups within categories.

select  Category,ProductID,Price,
ntile(2) over (partition by Category order by Price desc ) as rdense_rank_num
from funct ;

-- 5. SUM(): Calculates a running or partitioned total.
-- Use Case: Running total of quantities sold by category.

select  Category,ProductID,OrderID,Quantity,
sum(Quantity) over (partition by Category order by OrderID desc ) as Running
from funct ;

-- 6. AVG(): Calculates the average over a window.
-- Use Case: Average price for products within each category.

select  Category,ProductID,OrderID,Quantity,
round(avg(Price) over (partition by Category),2)as avg_price
from funct ;

-- 7. LAG(): Gets the value from the previous row.
-- Use Case: Find the previous product's price in each category.
SELECT Category,ProductID,Price,
LAG(Price) OVER(PARTITION BY Category ORDER BY ProductID) AS previous_price
FROM funct;

SELECT Category,ProductID,Price,
LAG(Price,2,0) OVER(PARTITION BY Category ORDER BY ProductID) AS previous_price
FROM funct;

-- 8. LEAD(): Gets the value from the next row.
-- Use Case: Find the next product's price in each category.

SELECT Category,ProductID,Price,
lead(Price) OVER(PARTITION BY Category ORDER BY ProductID) AS previous_price
FROM funct;

SELECT Category,ProductID,Price,
lead(Price ,1,0) OVER(PARTITION BY Category ORDER BY ProductID) AS previous_price
FROM funct;

-- 9. FIRST_VALUE(): Gets the first value in a window.
-- Use Case: Find the lowest-priced product in each category.

SELECT Category,ProductID,Price,
first_value(Price) OVER(PARTITION BY Category ORDER BY Price ) AS lowest
FROM funct;


-- 10. LAST_VALUE(): Gets the last value in a window.
-- Use Case: Find the highest-priced product in each category.

SELECT Category,ProductID,Price,
last_value(Price) OVER(PARTITION BY Category ORDER BY Price ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS highest
FROM funct;

-- --- Example 1: Running Total with ROWS and a Dynamic Frame


SELECT Category,OrderID,Quantity,
    SUM(Quantity) OVER(PARTITION BY Category ORDER BY OrderID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM funct;

SELECT Category,OrderID,Quantity,
    SUM(Quantity) OVER(PARTITION BY Category ORDER BY OrderID ROWS BETWEEN CURRENT ROW and UNBOUNDED following ) AS running_total
FROM funct;

-- Example 2: Moving Average with ROWS and Fixed Frame
-- Query: Calculate a 3-row moving average of prices for each category.

SELECT Category, OrderID,Price,
    AVG(Price) OVER( PARTITION BY Category ORDER BY OrderID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg
FROM funct;

 -- 2 PRECEDING to CURRENT ROW).
-- ROWS: Limits the frame to a fixed number of rows, regardless of the values in ORDER BY.


-- Example 3: Aggregation Over Entire Partition with RANGE
-- Calculate the total price for each category (repeated for every row).


SELECT Category,OrderID,Price,
    SUM(Price) OVER(PARTITION BY Category RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS total_price
FROM funct;

-- Frame: Includes all rows in the partition (UNBOUNDED PRECEDING to UNBOUNDED FOLLOWING).
-- RANGE: Operates on logical ranges based on the ORDER BY column.


---------------------

use notes_boss;

-- Calculates the running total of sale_amount per product_id ordered by sale_date.
SELECT department_id,salary,hire_date,
round(SUM(salary) OVER(PARTITION BY department_id ORDER BY hire_date desc)) AS running_total
FROM employees_sample_data;



-- Computes the average salary per department, assigning the same average to each employee within the department.
SELECT department_id,salary,hire_date,
round(avg(salary) OVER(PARTITION BY department_id)) AS avgs
FROM employees_sample_data;

SELECT department_id,salary,hire_date,
round(avg(salary) OVER(PARTITION BY department_id order by hire_date )) AS avgs
FROM employees_sample_data;

-- Counts the total number of products per category.

SELECT department_id,salary,hire_date,
count(*) OVER(PARTITION BY department_id) AS emp_count
FROM employees_sample_data;

SELECT department_id,salary,hire_date,
count(*) OVER(PARTITION BY department_id  ORDER BY hire_date desc) AS emp_count
FROM employees_sample_data;

-- Retrieves the max salary per department./latest and min

SELECT department_id,salary,hire_date,
max(salary) OVER(PARTITION BY department_id) AS max_salry
FROM employees_sample_data;

SELECT department_id,salary,hire_date,
min(salary) OVER(PARTITION BY department_id) AS max_salry
FROM employees_sample_data;

SELECT department_id,salary,hire_date,
max(salary) OVER(PARTITION BY department_id ORDER BY hire_date desc) AS emp_count
FROM employees_sample_data;

SELECT department_id,salary,hire_date,
max(hire_date) OVER(PARTITION BY department_id) AS latest_joinee
FROM employees_sample_data;

SELECT department_id,salary,hire_date,
max(hire_date) OVER(PARTITION BY department_id ORDER BY hire_date desc) AS emp_count
FROM employees_sample_data;

-- rank /row_number /dense rank
-- Explanation: Assigns a unique number to each employee within each department ordered by their hire date.
SELECT department_id,
       employee_id,hire_date,
       ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY hire_date) AS row_num
FROM employees_sample_data;


SELECT department_id,
       employee_id,hire_date,
       dense_rank() OVER(PARTITION BY department_id ORDER BY hire_date) AS dense_rnk
FROM employees_sample_data;

SELECT department_id,
       employee_id,hire_date,
       rank() OVER(PARTITION BY department_id ORDER BY hire_date) AS rnk
FROM employees_sample_data;

-- ntile

SELECT department_id,
       employee_id,hire_date,
       ntile(3) OVER(PARTITION BY department_id ORDER BY hire_date) AS parts
FROM employees_sample_data;


---------------------- first/last value
--  time series analysis, financial analysis, and trend reporting.

SELECT department_id,
       employee_id,hire_date,
       FIRST_VALUE(employee_id) OVER(PARTITION BY department_id ORDER BY hire_date) AS parts
FROM employees_sample_data;

SELECT department_id,
       employee_id,hire_date,
       first_value(employee_id) OVER(PARTITION BY department_id ORDER BY hire_date RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS parts
FROM employees_sample_data;

SELECT department_id,
       employee_id,hire_date,
       FIRST_VALUE(employee_id) OVER(PARTITION BY department_id ORDER BY hire_date rows between 2 PRECEDING  and current row) AS parts
FROM employees_sample_data;


SELECT department_id,
       employee_id,hire_date,
       last_value(employee_id) OVER(PARTITION BY department_id ORDER BY hire_date RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS parts
FROM employees_sample_data;


-- The LAG() function retrieves a value from a specified number of rows “before” the current row in the same result set partition.
-- LAG(column_name, offset, default_value) OVER(PARTITION BY column1 ORDER BY column2)

SELECT department_id,
       employee_id,hire_date,
       LAG(employee_id, 2, null) OVER(PARTITION BY department_id ORDER BY hire_date RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS parts
FROM employees_sample_data;

SELECT department_id,
       employee_id,hire_date,
       LAG(employee_id) OVER(PARTITION BY department_id ORDER BY hire_date) AS parts
FROM employees_sample_data;

SELECT department_id,
       employee_id,hire_date,
       lead(employee_id,2,0) OVER(PARTITION BY department_id ORDER BY hire_date) AS parts
FROM employees_sample_data;

-- stastical data

SELECT department_id,
       employee_id,hire_date,
       variance(employee_id) OVER(PARTITION BY department_id ORDER BY hire_date) AS var
FROM employees_sample_data;

SELECT department_id,
       employee_id,hire_date,
       round(stddev(employee_id) OVER(PARTITION BY department_id ORDER BY hire_date),2) AS var
FROM employees_sample_data;

SELECT department_id,
       employee_id,hire_date,
       round(stddev(employee_id) OVER(PARTITION BY department_id ORDER BY hire_date ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING),2) AS var
FROM employees_sample_data;


SELECT department_id,
       employee_id,hire_date,
       round(stddev(employee_id) OVER(PARTITION BY department_id ORDER BY hire_date  RANGE BETWEEN INTERVAL '7' DAY PRECEDING AND CURRENT ROW),2) AS var
FROM employees_sample_data;

