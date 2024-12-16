-- insert new employee in employee table
use  companydb;

drop table employees ;

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    department_id INT
);

INSERT INTO Employees (employee_id, first_name, last_name, age, department_id)
VALUES (101, 'John', 'Doe', 35, 3);
INSERT INTO Employees (employee_id, first_name, last_name, age, department_id)
VALUES (102, 'Jane', 'Smith', 29, 4);
INSERT INTO Employees (employee_id, first_name, last_name, age, department_id)
VALUES (103, 'Sam', 'Brown', 41, 2);
INSERT INTO Employees (employee_id, first_name, last_name, age, department_id)
VALUES (104, 'Sue', 'Green', 37, 1);


insert into employees value(167,'satish','singh',32,2);
select * from employees;

USE CompanyDB;
select * from orders; 

-- 5.1: Retrieve all employees' first and last names
select first_name,last_name from employees;

select concat(first_name , ' ' , last_name) from employees;


 
-- 5.2: Retrieve all products in the 'Electronics' category
select * from products where upper (category)='ELECTRONICS';
 
-- 5.3: Retrieve all orders sorted by total amount in descending order
select * from orders order by total_amount desc;
 
 select * from products;
-- 5.4: Retrieve the number of products in each category
select category,count(*) as number_products from products group by 1;

-- 5.5: Retrieve categories with more than one product
select category,count(*) as number_products from products group by 1 having number_products>1;
 

-- 6.1: Insert a new employee into the Employees table
insert into employees values (123,'shivani','raghu',28,6);

-- 7.1: Update an employee's department and name

select * from employees;
-- to update 2 columns
update employees set first_name ='shici' , last_name ='neema' where department_id=4;
update departments set department_name ='xyz' where department_id=6;

-- 8.1: Delete a product from the Products table
delete from departments where department_id=6;

-- 11.1: Count the number of employees
select count(distinct employee_id) as emp_count from employees;
SELECT COUNT(*) FROM Employees;
 
-- 11.2: Find the average price of products
select round(avg(price),2) from products;

 
-- 12.1: Concatenate first and last names of employees
SELECT concat(first_name,' ' ,last_name) as full_name FROM Employees;
 SELECT concat_ws(',',first_name,last_name) as full_name FROM Employees;
 
-- 12.2: Convert product names to uppercase
SELECT upper(product_name) from products ;
 
 select * from orders;
 
-- 13.2: Calculate the difference between two order dates  -- can be done with windows function
SELECT DATEDIFF('2024-08-12', '2024-08-10') AS difference_in_days;
-- SELECT TIMESTAMPDIFF(HOUR, date_column2, date_column1) AS hours_difference FROM table_name;
-- SELECT DATEDIFF(month ,date_column1, date_column2) AS days_difference FROM table_name;

select datediff(o2.order_date, o1.order_date) AS days_difference
from orders o1 left join orders o2 
on  o2.order_id  = o1.order_id 
and  o2.order_date  <o1.order_date ;

-- 14.1: Categorize orders based on total amount
SELECT order_id, total_amount ,
CASE
	    WHEN total_amount > 1000 THEN 'High Value'
        WHEN total_amount > 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS order_category
FROM Orders;

select total_amount ,order_id from orders group by total_amount ,order_id ;

-- 17.1: Alter table to add a new column
alter table employees add gender varchar(10);
 
-- 17.2: Drop the Products table
drop table products;
 
-- 17.3: Truncate the Orders table (remove all data but keep the structure)

truncate table products;



-- -- 14.1: Categorize orders based on order date
select order_id,order_date,
case
when  order_date < current_date() then 'old_product'
when  order_date <= current_date() then 'recent_product'
when  order_date > current_date() then 'future_product'
else 'noinf'
end as order_date_inf
from orders;



  






