-- Create Customers Table

use joinscustomerdb;

show tables;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Country VARCHAR(50),
    SignupDate DATE,
    CustomerCategory VARCHAR(20)
);

-- Insert Data into Customers
INSERT INTO Customers (CustomerID, Name, Country, SignupDate, CustomerCategory) VALUES
(1, 'Alice Wong', 'USA', '2023-01-15', 'Gold'),
(2, 'Bob Smith', 'Canada', '2023-02-20', 'Silver'),
(3, 'Carol Li', 'UK', '2023-03-12', 'Bronze'),
(4, 'David Kim', 'USA', '2023-04-05', 'Gold'),
(5, 'Eva Zhou', 'Australia', '2023-05-25', 'Silver');

alter table Customers modify SignupDate DATE default (date(current_timestamp()));

INSERT INTO Customers (CustomerID, Name, Country, SignupDate, CustomerCategory) VALUES
(18, 'xyz', '', default, 'silver');

select * from Customers;
-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    ProductID INT,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    OrderChannel VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

SHOW CREATE TABLE orders;

alter table orders drop primary key ;
alter table orders add primary key(OrderID,ProductID);
alter table orders modify ProductID int not null ;

describe orders;

-- Insert Data into Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, ProductID, Quantity, TotalAmount, OrderChannel) VALUES
(101, 1, '2023-06-01', 201, 2, 300.00, 'App'),
(102, 2, '2023-06-10', 202, 1, 150.00, 'Website'),
(103, 3, '2023-06-15', 203, 3, 450.00, 'Website'),
(104, 4, '2023-06-20', 201, 1, 150.00, 'App'),
(105, 5, '2023-06-25', 204, 5, 500.00, 'Website');

select * from orders;
-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT,
    SupplierID INT
);

alter table products add foreign key(ProductID) references orders(ProductID);

-- Insert Data into Products
INSERT INTO Products (ProductID, ProductName, Category, Price, Stock, SupplierID) VALUES
(201, 'Laptop', 'Electronics', 150.00, 50, 1001),
(202, 'Smartphone', 'Electronics', 150.00, 100, 1002),
(203, 'T-Shirt', 'Clothing', 100.00, 200, 1003),
(204, 'Headphones', 'Electronics', 100.00, 150, 1001),
(205, 'Coffee Maker', 'Home & Kitchen', 200.00, 80, 1004);


-- Add More Rows to Customers
INSERT INTO Customers (CustomerID, Name, Country, SignupDate, CustomerCategory) VALUES
(6, 'Frank Harris', 'Germany', '2023-01-20', 'Bronze'),
(7, 'Grace Lee', 'USA', '2023-02-15', 'Silver'),
(8, 'Hannah Brown', 'UK', '2023-03-22', 'Gold'),
(9, 'Ian Thompson', 'Australia', '2023-04-18', 'Silver'),
(10, 'Jackie Chan', 'China', '2023-05-29', 'Gold'),
(11, 'Karen Wilson', 'India', '2023-06-11', 'Bronze'),
(12, 'Liam Garcia', 'USA', '2023-07-13', 'Silver'),
(13, 'Maria Fernandez', 'Spain', '2023-08-14', 'Gold'),
(14, 'Nina Singh', 'India', '2023-09-15', 'Gold'),
(15, 'Oliver King', 'UK', '2023-10-19', 'Bronze');

-- Add More Rows to Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, ProductID, Quantity, TotalAmount, OrderChannel) VALUES
(106, 6, '2023-07-01', 205, 2, 400.00, 'App'),
(107, 7, '2023-07-02', 202, 1, 150.00, 'Website'),
(108, 8, '2023-07-05', 203, 2, 200.00, 'Website'),
(109, 9, '2023-07-07', 204, 3, 300.00, 'App'),
(110, 10, '2023-07-10', 201, 1, 150.00, 'App'),
(111, 11, '2023-07-12', 202, 4, 600.00, 'Website'),
(112, 12, '2023-07-15', 203, 1, 100.00, 'App'),
(113, 13, '2023-07-17', 204, 5, 500.00, 'Website'),
(114, 14, '2023-07-20', 205, 1, 200.00, 'Website'),
(115, 15, '2023-07-23', 203, 6, 600.00, 'App'),
(116, 1, '2023-08-01', 205, 2, 400.00, 'App'),
(117, 2, '2023-08-02', 202, 2, 300.00, 'Website'),
(118, 3, '2023-08-03', 204, 1, 100.00, 'App'),
(119, 4, '2023-08-04', 201, 4, 600.00, 'App'),
(120, 5, '2023-08-05', 202, 3, 450.00, 'Website');

-- Add More Rows to Products
INSERT INTO Products (ProductID, ProductName, Category, Price, Stock, SupplierID) VALUES
(206, 'Blender', 'Home & Kitchen', 80.00, 100, 1004),
(207, 'Desk Lamp', 'Furniture', 50.00, 150, 1005),
(208, 'Running Shoes', 'Clothing', 120.00, 200, 1006),
(209, 'Backpack', 'Accessories', 60.00, 180, 1006),
(210, 'Gaming Console', 'Electronics', 400.00, 30, 1001),
(211, 'Wireless Mouse', 'Electronics', 25.00, 500, 1002),
(212, 'Coffee Table', 'Furniture', 200.00, 70, 1005),
(213, 'Smart Watch', 'Electronics', 250.00, 90, 1003),
(214, 'Electric Kettle', 'Home & Kitchen', 45.00, 150, 1004),
(215, 'Yoga Mat', 'Fitness', 30.00, 300, 1006);



-- 1. Retrieve all orders made through the "Website" channel. 
-- Include the OrderID, CustomerID, OrderDate, and OrderAmount

select OrderID, CustomerID, OrderDate, TotalAmount from orders where lower(OrderChannel) ='website';


-- 2.Find customers who joined after March 1, 2023. 
-- Include CustomerID, Name, Country, and CreatedDate.

select CustomerID, Name, Country, SignupDate from customers where SignupDate >'2023-03-01';


-- 3. Retrieve all orders with an amount greater than 200.

select * from orders where TotalAmount>500;

-- 4. Find customers from "USA" and "Canada" only. Include CustomerID, Name, and Country.

select CustomerID, Name, Country from customers where Country in('USA','Canada');
select CustomerID, Name, Country from customers where Country='USA' or Country='Canada';


-- 5. Retrieve orders placed between February 1, 2023, and July 1, 2023. 
-- Include OrderID, CustomerID, and OrderDate

select OrderID, CustomerID, OrderDate from orders where OrderDate between '2023-02-01' and '2023-07-01';


-- 6. Retrieve details of customers in the "Gold" category. 
select CustomerID, Name, Country from customers where CustomerCategory ='Gold';

-- 7. Find customers whose names start with the letters "A" or "B".
--  Include CustomerID, Name, and Country.
select CustomerID, Name, Country from customers where Name like 'A%' OR Name like'B%';

-- 8. Find orders placed through the "App" channel with an amount between 150 and 300. 
-- Include OrderID, CustomerID, OrderAmount, and OrderDate.

select * from orders where OrderChannel ='App' and TotalAmount between 150 and 300;

-- 9. Find the total number of orders placed by each customer. 
select CustomerID, count(OrderID)as orders_placed from orders group by CustomerID;

select * from orders;
-- 10. Calculate the average order amount for each order channel.
select OrderChannel, round(avg(TotalAmount),2)as orders_placed from orders group by OrderChannel;


-- 11. Retrieve the total amount spent by each customer, 
-- but only include customers who have spent more than 500
select CustomerID, round(sum(TotalAmount),2)as orders_placed from orders group by CustomerID having orders_placed>500;



--------- ------------------------------------------------ joins -----------------------------------------------
-- inner join
select * from customers;
-- Show only customers who have placed orders.

select c.CustomerID,c.Name,o.OrderID,o.OrderDate,o.ProductID
from 
customers c join orders o
on c.CustomerID = o.CustomerID;


--  left join 

-- Show all customers and any orders they’ve placed, 
-- even if some customers haven’t placed any orders.

select c.Name , o.OrderID
from 
customers c left join orders o
on c.CustomerID = o.CustomerID;


INSERT INTO Customers (CustomerID, Name, Country, CustomerCategory, SignupDate) VALUES
(23, 'Henry', 'Australia', 'Gold', '2024-01-15'),
(28, 'Jahan', 'USA', 'Silver', '2024-02-10');

---- right join
-- -- Show all orders, even if some customers aren’t in the Customers table

select c.Name , o.OrderID
from 
customers c right join orders o
on c.CustomerID = o.CustomerID;

-- -- List customers from each country along with their total spending,
--  including only those with spending over 500.

select c.CustomerID  ,c.Country, sum(o.TotalAmount)
from 
customers c  join orders o
on c.CustomerID = o.CustomerID group by c.CustomerID,c.Country having  sum(o.TotalAmount)>500;

--  1. Retrieve each customer's name and their total spending amount. 
-- Include only those customers who have made at least one order. 

select c.Name ,sum(o.TotalAmount) as amt_spent
from 
customers c  join orders o
on c.CustomerID = o.CustomerID group by c.Name;

-- --  2. List each product's name along with the total quantity ordered
--  for that product.

select p.ProductName , coalesce(sum(o.Quantity),0)  as quant_ordered
from orders o left join products p
on o.ProductID = p.ProductID group by p.ProductName ;


-- -- 3. Number of Orders Per Customer Category
select c.CustomerCategory ,count(distinct OrderID) as numb_of_orders
from customers c left join orders o
on o.CustomerID = c.CustomerID group by 1 ;

-- -- 4. For each product category, show the total number of orders and the 
-- total quantity ordered.
--  Only include categories with total quantities ordered above 10.

select p.Category ,count(distinct o.OrderID) as numb_of_orders ,sum(o.Quantity) as total_quant
from products p left join orders o
on p.ProductID = o.ProductID group by 1 having total_quant>10;

 -- 5. Calculate the average order amount for customers in the "Silver" category.
--  Display the CustomerCategory and AvgOrderAmount. 

select c.CustomerCategory ,round(avg(o.TotalAmount),2) as avg
from customers c left join orders o
on o.CustomerID = c.CustomerID  where c.CustomerCategory = 'Silver' group by 1 ;

---- 6. Retrieve the product names and the total quantities ordered 
-- for each product where the total ordered quantity exceeds 10. 

select p.ProductName ,sum(o.Quantity) as total_quant
from products p left join orders o
on p.ProductID = o.ProductID group by 1 having total_quant>10;


-- 7. Show the total sales (sum of TotalAmount) by each country for customers who have placed orders.
--  Display the Country and TotalSales.

select c.Country ,round(sum(o.TotalAmount),2) as avg
from customers c join orders o
on o.CustomerID = c.CustomerID group by 1 order by 2 desc limit 1 ;




-- 8. For orders placed through the "App" channel, display each product category 
-- and the total number of orders placed for that category.

select p.Category,count(o.OrderID) as orders
from products p left join orders o
on p.ProductID = o.ProductID where lower(o.OrderChannel) ='app' group by 1;


-- 9. Retrieve the product names along with the number of times each product was 
-- ordered by customers in the "Gold" customer category.

select p.ProductName,count(o.OrderID) as orders
from products p left join orders o
on p.ProductID = o.ProductID
left join customers c on c.CustomerID = o.CustomerID
where lower(c.CustomerCategory) ='gold' group by 1 order by 2 desc;



-- 10. Retrieve the names of customers who have ordered products in the 
-- "Electronics" category.

 select distinct c.Name  
 from customers c left join orders o on c.CustomerID = o.CustomerID
 join products p on o.ProductID = p.ProductID
 where p.Category ='Electronics';



-- 11.Total Stock and Order Quantity for Each Product

select * from products;

select p.ProductName, (p.Stock) ,sum(o.Quantity) as quant
from orders o right join products p on p.ProductID = o.ProductID
group by 1,2;


-- 12. List the names of customers who have placed more than or equal to two orders.

select * from orders;

select c.Name, count(o.OrderID) as no_of_orders
from orders o join customers c on c.CustomerID = o.CustomerID
group by 1 having no_of_orders>=2;



-- 13. Show each product name and its total sales amount (quantity * price) 
-- only for products priced above 100.

select  p.ProductName , sum(p.Price*o.Quantity) as total_sales
from products p left join orders o
on p.ProductID = o.ProductID where p.Price >100
group by 1;

select  p.ProductName , sum(o.TotalAmount) as total_sales
from products p left join orders o
on p.ProductID = o.ProductID  where p.Price >100
group by 1;



------- cross join -------------------


create table e1(
id int,
color varchar(10)
);

insert into e1 values (1,'red'),
(2,'green'),
(3,'yellow');

select * from e1;

create table e2(
c_id int,
size varchar(10)
);

insert into e2 values (1,'small'),
(2,'medium');

select * from e2;

select e1.id,e1.color,e2.c_id,e2.size
from e1 cross join e2;

select *
from e1 cross join e2 order by id ;

-- all possible combination for customer and product
select CustomerID,Name,Country,SignupDate,CustomerCategory,
ProductID,ProductName,Category,Price,Stock
from customers cross join products ;

select c.CustomerID,p.ProductID from customers c cross join products p ;


---- explore every product with every order date

select p.ProductID ,o.OrderDate from orders o cross join products p order by ProductID desc;

-- lets assume u r planning to customize each customer data for each date 
select c.CustomerID ,c.CustomerCategory,c.Country,o.OrderDate,o.Quantity from orders o cross join customers c order by customerID ;


-- --------------------------------       full join --------------------------

select c.CustomerID,c.Name,o.OrderID,o.OrderDate
from customers c left join orders o on
c.CustomerID = o.CustomerID
union 
select c.CustomerID,c.Name,o.OrderID,o.OrderDate
from customers c right join orders o on
c.CustomerID = o.CustomerID ;  -- all orders with customer id


-- 1. Retrieve All Customer and Product Pairs, Including Customers with 
-- No Orders and Products Not Ordered by Any Customer
-- 2. List All Customers and Their Orders, Including Customers with No Orders 
-- and Orders with No Matching Customer

select p.ProductID,o.OrderDate
from products p left join orders o on
p.ProductID = o.ProductID
union 
select p.ProductID,o.OrderDate
from products p right join orders o on
p.ProductID = o.ProductID;  -- all orders with customer id




---------------- self join -----------------------

drop table weather;

CREATE TABLE Weather_class (
    WeatherDate DATE PRIMARY KEY,
    Temperature INT
);

INSERT INTO Weather_class (WeatherDate, Temperature)
VALUES
('2024-11-01', 20),
('2024-11-02', 22),
('2024-11-03', 21),
('2024-11-04', 23),
('2024-11-05', 22),
('2024-11-06', 24);

select * from Weather_class;

-- find about days where temp was higher than previous day

select w2.WeatherDate as next_day, w1.WeatherDate,w1.Temperature ,w2.Temperature as next_temp
from
Weather_class w1 join Weather_class w2
on ( w2.WeatherDate - w1.WeatherDate =1)and (w2.Temperature >w1.Temperature);

/*or 
on ( w2.WeatherDate - w1.WeatherDate =1)and (w2.Temperature >w1.Temperature); */

INSERT INTO Weather_class (WeatherDate, Temperature)
VALUES
('2024-11-07', 24),
('2024-11-08', 26)
;
-- find consecutive days with same temp

select * from
Weather_class w1 join Weather_class w2
on datediff(w2.WeatherDate,w1.WeatherDate )=1;

SELECT * 
FROM Weather_class w1 
JOIN Weather_class w2 
ON subdate(w2.WeatherDate,INTERVAL 1 DAY)= w1.WeatherDate;

-- SUBDATE(date, interval) is designed to subtract an interval (e.g., days, months, years) from a date. For example:

SELECT * FROM 
Weather_class w1 JOIN   Weather_class w2
ON w1.WeatherDate = DATE_ADD(w2.WeatherDate, INTERVAL 1 DAY)
WHERE w1.temperature > w2.temperature;


-- largest temp drop

select w1.* ,w2.*,
w2.Temperature-w1.Temperature as temp_drop
from
Weather_class w1 join Weather_class w2
on datediff(w2.WeatherDate,w1.WeatherDate )=1 
order by temp_drop desc;


SELECT w1.* , w2.*,(w2.Temperature - w1.Temperature) AS TempDrop
FROM Weather_class w1 JOIN  Weather_class w2
ON  DATEDIFF(w2.WeatherDate, w1.WeatherDate) = 1
WHERE  (w2.Temperature - w1.Temperature) = (SELECT MAX(w2.Temperature - w1.Temperature )
FROM  Weather_class w1 JOIN  Weather_class w2
        ON DATEDIFF(w2.WeatherDate, w1.WeatherDate) = 1);
     
     
     ------------------
    
create table emp_aqr(emp_id int, name varchar(20),manager_id int);

insert into emp_aqr values(1,'jean',null),
(2,'kamlesh',1),
(3,'awd',2),
(4,'gaurav',3)
;
insert into emp_aqr values(4,'gaurav',3);

update emp_aqr set name ='ashwin' where name ='awd';

delete from emp_aqr  ;

select * from emp_aqr;



select  e2.name as emp_name ,e1.name as manager_name
from
emp_aqr e1 join emp_aqr e2
on e1.emp_id = e2.manager_id;


Drop table employees;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY, 
    name VARCHAR(50),           
    manager_id INT,             
    department VARCHAR(50)       
);

-- Insert data into the employees table
INSERT INTO employees (employee_id, name, manager_id, department) VALUES
(1, 'Alice', NULL, 'HR'),       
(2, 'Bob', 1, 'Finance'),      
(3, 'Charlie', 1, 'Finance'),  
(4, 'Diana', 2, 'IT'),          
(5, 'Eve', 2, 'IT'),            
(6, 'Frank', 3, 'Marketing'),   
(7, 'Grace', 3, 'Marketing'),   
(8, 'Henry', 4, 'IT');  

select * from employees;

-- list all manager will there employess

-- e1 employee e2 manager
select e1.name as  emp_name   , e2.name as manager_name
from employees e1 left join employees e2
on  e2.employee_id =e1.manager_id ;

-- how many emp reports to each manager  --e1 emp table , e2 manger table

select e2.name as manager_name,count(e1.employee_id) as emp_count
from employees e1 join employees e2 
on e1.manager_id= e2.employee_id
group by 1 ;

-- find employee who work on same department as there manager

select * from employees;  
                                                                                                                                                          
select e1.name as emp_name
from employees e1 join employees e2 
on e1.manager_id= e2.employee_id
where e1.department =e2.department group by 1 ;



-- delete all employees associated with the department 3
DELETE e1
FROM employees e1 JOIN employees e2 ON  e2.employee_id =e1.manager_id 
WHERE e1.employee_id = 9;


select * FROM employees;

UPDATE 
employees e1 JOIN employees e2 ON  e2.employee_id =e1.manager_id 
SET e1.employee_id =e1.employee_id+1
WHERE e2.department ='IT';