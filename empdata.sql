-- Retrieve employees from the Engineering department, earning more than 70,000, ordered by salary (highest to lowest), and display only the first 3 results.

use empdata;

select * from employee_data;
select concat(first_name,' ' ,last_name) as full_name ,salary  from employee_data order by salary asc;

-- concat_ws -->The CONCAT_WS function allows you to specify a separator between each argument 
-- (e.g., a comma or space).
-- SELECT CONCAT_WS(' ', column1, column2, column3) AS combined_column FROM table_name;



-- Retrieve employees from the Engineering department,
-- earning more than 70,000, ordered by salary (highest to lowest), and display only the first 3 results.
select * from employee_data where salary >70000  and department ='Engineering' order by salary desc limit 3;


-- Retrieve employees who work in either the Sales or Marketing departments and earn more than 70,000 USD.

SELECT first_name, last_name, department, salary
FROM employee_data
WHERE (department = 'Sales' OR department = 'Marketing')
AND salary > 70000;

-- Find employees from the HR department who earn more than 60,000 USD or employees from the Operations department who earn more than 75,000 USD.

select * from employee_data where (upper(department) ='HR' and salary >60000)or(upper(department) ='OPERATIONS' and salary >75000);

-- Suppose we want to sort employees by department first (in ascending order) and then by salary within each department (in descending order). 
-- This allows us to see the highest earners in each department listed at the top of their respective department groups.

select * from employee_data order by department asc,salary desc;

-- In this example we want to retrieve the first 5 employees, skipping the first 10 records.
--  This is useful for pagination when handling large datasets.

select * from employee_data limit 5 offset 10;

-- Retrieve the top 5 highest-paid employees from any department except HR,
-- ordered by salary, and display their full names, salaries, and departments.

select * from employee_data where not department ='HR' order by salary desc limit 5;

-- Display all employees from the Sales and Marketing departments,
-- sorted by salary in ascending order, and show only the first 10 results.

select * from employee_data where (upper(department) ='SALES' OR upper(department) ='MARKETING') ORDER BY salary limit 10;


-- Find employees with salaries between 50,000 and 90,000 who work in Engineering or Sales, order them by last name, 
-- and retrieve only the first 5 results after skipping the first 5.

select * from employee_data where (upper(department) ='SALES' OR upper(department) ='ENGINEERING') And (salary between 50000 and 90000)ORDER BY last_name limit 5 offset 5;
-- or 
SELECT first_name AS "First Name", last_name AS "Last Name", salary AS "Salary", department AS "Department" FROM employee_data
WHERE salary BETWEEN 50000 AND 90000 
AND department IN ('Engineering', 'Sales')
ORDER BY last_name ASC
LIMIT 5 OFFSET 5;

-- list employees who were hired between 2013 and 2018, belong to the Finance department, and show only their full names, departments, and hire dates.
-- Order the result by hire date in descending order, showing the first 7 results.

-- group by
select department, count(*) as emp_count from employee_data group by department;

select department, sum(salary) as salary from employee_data group by department order by salary desc;

SELECT * FROM employee_data WHERE EXISTS (SELECT employee_id FROM employee_data WHERE first_name = 'Delhi');
-------------------------

select * from sample_sql_dataset;

-- 1. Find the total salary of users who are from Delhi, Mumbai, or Chennai
select sum(Salary) from sample_sql_dataset where upper(City) in ('DELHI','CHENNAI','MUMBAI');

-- . Count the number of users whose salary is between 40,000 and 80,000 and live in Delhi
select count(*) from sample_sql_dataset where Salary between 40000 and 80000;
select count(distinct UserID) from sample_sql_dataset where Salary between 40000 and 80000;

-- 3. Find the average salary of users who are not from Delhi
select avg(Salary) from sample_sql_dataset where upper(City) not in ('DELHI');
select avg(Salary) from sample_sql_dataset where City != 'DELHI';

-- 4. Find the highest salary among users whose age is less than 30 or whose salary is greater than 70,000
select max(Salary) from sample_sql_dataset where age<30 or Salary>700000;

-- 6. List the total number of users in each city
select City,count(*) from sample_sql_dataset group by City;

-- 7. Find the total salary of users grouped by department, only for those who are older than 30

select Department,sum(Salary) from sample_sql_dataset Salary where Age>30  group by Department;

-- 8. Find users from Delhi or Mumbai and whose age is greater than the average age of all users

select UserID from sample_sql_dataset where  upper(City) in ('DELHI','MUMBAI') and Age >(select avg(Age) from sample_sql_dataset) ;

-- 9. Find the total salary of users in each department whose salary is greater than the department's average salary
-- again

select Department,sum(Salary) from sample_sql_dataset where Salary > (
select avg(Salary) from sample_sql_dataset as av where av.Department = sample_sql_dataset.Department) group by Department;

-- 10. Count the number of users whose name starts with 'A' and who have a salary greater than 60,000

select count(UserID) from sample_sql_dataset where Name like 'A%' and  Salary;

-- 11. Find the average salary of users who are from cities where the department is not 'HR'

select City, AVG(Salary) from sample_sql_dataset where Department !='HR' group by City;

-- 12. Find the users with the highest salary in each department
select department, MAX(Salary) from sample_sql_dataset  group by department;

-- 13. Find the number of users from each city who have a salary greater than 50,000
select City, count(*) from sample_sql_dataset where Salary >50000 group by City ;

-- 14. Find the total number of users whose salary is NULL
select count(*) from sample_sql_dataset where Salary is null;








