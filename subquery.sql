use joinscustomerdb
;

select * from customers;
select * from products;
select * from orders;


-- 1. customer who place largest order amount
select CustomerID from orders where TotalAmount =(select max(TotalAmount) from orders);

-- 2. find products purchased by more than 1 customer

select distinct ProductName from products where ProductID in(
select ProductID from orders group by 1 having count(CustomerID)>1);

-- same qus join
select p.ProductID ,p.ProductName 
from products p join orders o on p.ProductID = o.ProductID 
group by 1,2
having count(o.CustomerID)>1;



-- 3.customer who has not placed any order --correlated
select * from customers;
select * from orders;

select c.CustomerID ,C.Name
from customers c left join orders o on o.CustomerID = c.CustomerID
where o.CustomerID is null;
 
-- subquery
select CustomerID, Name
from Customers
where CustomerID not in (select distinct CustomerID
from Orders);


-- 4 find product with higher price than avg price
select ProductID,ProductName,Price from products where Price >(
select round(avg(Price),2) from products) ;


-- 5 Find Orders Placed on the Latest Order Date
select OrderID ,OrderDate from orders where OrderDate = (select max(OrderDate) from orders);


-- 6 find customers who have place order for most expensive product
select o.CustomerID, c.Name
from customers c join orders o 
on c.CustomerID = o.CustomerID
join products p 
on o.ProductID =p.ProductID 
where Price =
(select max(Price) from products);

select * from orders;

 -- 7 find product ordered only once
 
select ProductID from orders group by ProductID having count(OrderID) =1;
 
 select distinct ProductName
from Products
where ProductID in (select ProductID
 from Orders
 group by ProductID
 having count(distinct OrderID) = 1);


-- Find Customers Who Have Never Ordered Mobile Phones
select Name
from Customers
where CustomerID  not in (
select  CustomerID from orders where ProductID in(
select  ProductID from products where ProductName ='Headphones'));

-- Find Products Purchased by the Most latest Customer
select p.ProductName ,p.ProductID,o.OrderDate
from orders o join products p
on o.ProductID =p.ProductID
where OrderDate =
(select max(OrderDate) from orders);

select OrderDate from orders;

-- -- Find Products Purchased by the Most frequent Customer ( max number of orders)
-- limit cant be used with subquery -- to overcome subquery

select p.ProductName ,p.ProductID,count(o.OrderID)
from orders o join products p
on o.ProductID =p.ProductID
where CustomerID in
(select CustomerID from orders group by 1 order by COUNT(OrderID) desc )
group by p.ProductName ,p.ProductID limit 1;


select ProductID, ProductName
from Products
where ProductID in (select ProductID
from Orders
where CustomerID in (
select CustomerID
from Orders
group by CustomerID
order by COUNT(OrderID) desc ));


--  aggregate fn over rows, where clause only 1 row select ProductID from orders where OrderDate= max(OrderDate) ;

-- Find the Total Revenue= items *price Generated by Each Customer


select c.CustomerID, c.Name,sum(p.price * Quantity)
from Orders o join Products p
on o.ProductID = p.ProductID
right join customers c
on c.CustomerID = o.CustomerID
group by 1,2;


select CustomerID, Name, (
select sum(p.price * Quantity)
from Orders o join Products p
on o.ProductID = p.ProductID
where o.CustomerID = c.CustomerID) as total_revenue
from customers c;


/* ANY/SOME:
Example: salary > ANY (SELECT salary FROM employees WHERE department_id = 101)
This checks if an employee's salary is greater than any salary in department 101.

ALL:
Example: salary > ALL (SELECT salary FROM employees WHERE department_id = 101)

This checks if an employee's salary is greater than all salaries in department 101.

*/

use notes_boss;
-- 1. Find Employees with Higher Salaries 
-- Write a query to find the names and salaries of employees who earn more than the average salary of all employees in the company.

select Name,Salary from employee where Salary > (
select avg(Salary) from employee);


-- 2. Retrieve Managers of Employees 
-- Write a query to retrieve the names of employees who are managers (i.e., their EmployeeID appears in the ManagerID column of other employees).

select * from employee;

select distinct e1.Name as manager_name
from employee e1 join employee e2
on e1.EmployeeID = e2.ManagerID;

SELECT DISTINCT e.Name
FROM Employee e
WHERE e.EmployeeID IN (SELECT ManagerID FROM Employee WHERE ManagerID IS NOT NULL);

-- 3. List Employees in Specific Departments 
-- Write a query to list the names of employees who work in the 'Sales' department.

select Name from employee where DepartmentID in(
select DepartmentID from department where DepartmentName ='Sales');

-- 4. Identify Departments with High Salaries
-- Write a query to find the names of departments that have at least one employee earning more than $70,000.

select DepartmentName from department where DepartmentID in(
select DepartmentID from employee where Salary >70000);

-- 5. Find Employees Hired After a Specific Date 
-- Write a query to find all employees hired after the hire date of the employee with the highest salary.

select Name from employee where HireDate >(
select HireDate from employee where Salary =(
select max(Salary) from employee));


SELECT Name
FROM Employee
WHERE HireDate > (SELECT HireDate FROM Employee ORDER BY Salary DESC LIMIT 1);


-- 6. List Locations with Departments 
-- Write a query to list the names of locations that have departments. Only show the unique location names.

select distinct LocationName from locations where LocationID in(
select LocationID from department where DepartmentID is not null);

-- 7. Employees Without Managers 
--  Write a query to find the names of employees who do not have a manager assigned (i.e., their ManagerID is NULL).

select * from employee; 

select distinct e2.Name as emp_name
from employee e1 right join employee e2
on e1.EmployeeID = e2.ManagerID where e2.ManagerID ='';

select Name from employee where ManagerID ='';

-- 8. Count Employees by Department 
-- Write a query to find the number of employees in each department and list only those departments with more than 5 
select DepartmentID ,count(EmployeeID) as emp_count
from employee 
group by 1 having count(*) >5;


-- 9. Find Departments with No Employees 
-- Write a query to identify departments that currently do not have any employees assigned to them.
select DepartmentID ,count(EmployeeID) as emp_count
from employee 
group by 1 having count(*) =0;

SELECT DepartmentName
FROM Department
WHERE DepartmentID NOT IN (SELECT DISTINCT DepartmentID FROM Employee);


-- 10. Retrieve Employees in Departments in a Specific Location 
-- Write a query to find the names of employees who work in departments located in 'New York'.

select e.Name
from department d right join employee e 
on d.DepartmentID = e.DepartmentID where  d.LocationID 
in
(select l.LocationID 
from department d right join locations l 
on d.LocationID = l.LocationID where LocationName ='New York');


SELECT e.Name
FROM Employees e
WHERE e.DepartmentID IN (
    SELECT d.DepartmentID
    FROM Departments d
    WHERE d.LocationID IN (
        SELECT LocationID
        FROM Locations
        WHERE LocationName = 'New York'
    )
);