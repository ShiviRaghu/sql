use practice;


--------------------- FUNCTIONS----------OPERATORS----------------------

use empdata;
select employee_id +10 from employee_data;
select employee_id -10 from employee_data;
select employee_id*2 from employee_data;
select employee_id%10 from employee_data;
select round(employee_id/10,2) from employee_data;


select * from employee_data where salary >50000 order by salary;
select * from employee_data where(salary >50000 or department= 'Engineering') and hire_date <current_date() order by salary desc; -- now()
select * from employee_data where not department  in ('Engineering','HR');

SELECT * FROM employee_data
UNION ALL
SELECT * FROM employee_data ORDER BY hire_date DESC;

SELECT * FROM employee_data
UNION 
SELECT * FROM employee_data ORDER BY hire_date DESC;


/*SELECT * FROM employee_data
INTERSECT
SELECT * FROM employee_data ORDER BY hire_date DESC;  -- MY SQL DOESNT SUPPORT INTERSECT */

/*SELECT * FROM employee_data
EXCEPT
SELECT * FROM employee_data ORDER BY hire_date DESC;   -- MY SQL DOESNT SUPPORT EXCEPT */

select * from employee_data;

----------------- like -------------------
select * from employee_data where first_name like 'C%';
select * from employee_data where first_name like '%N';
select * from employee_data where first_name like '_y%';
select * from employee_data where first_name like '__%n';
select * from employee_data where first_name like '%C%';
select * from employee_data where first_name like 'C_R%';
select * from employee_data where first_name like 'A__e%'; -- a _ _ e at 4
select * from employee_data where first_name like '_n%a';  -- 2nd position n and end with a
select * from employee_data where first_name like 'C__%__%_'; -- start c , atleast nchar in length
select * from employee_data where first_name like 'C%y'; -- strt with x end with y
----------------------------

select * from employee_data where hire_date is null;
select * from employee_data where hire_date is not null; 

-- select first_name||'-'|| last_name  as fullname from employee_data ; 

select upper(first_name),lower(last_name)from employee_data ; 

select substring(last_name ,1,3) from employee_data ; 

SELECT * FROM employee_data;

select concat_ws('', first_name,last_name) as full_name,salary  from employee_data order by salary asc;

-- functions ----
show tables;
-----------------------------------------------------------------------------------
use companydb;

insert into customers values (3003,'abc' ,'bcd',90,null);
select * from customers;

-- abs
select abs (customer_id) from customers;

-- avg 
select avg(customer_id) from customers;

-- || - in mysql it interpreted as OR
select abs (customer_id) ||  abs (age) from customers;
SELECT 'Hello' || 'World';

-- case 
select order_id,order_date,
case
when  order_date < current_date() then 'old_product'
when  order_date <= current_date() then 'recent_product'
when  order_date > current_date() then 'future_product'
else 'noinf'
end as order_date_inf
from orders;

-- cast
/* 
Supported Data Types
You can use CAST to convert values to the following data types:

CHAR (or VARCHAR)
SIGNED (for integers)
UNSIGNED (for unsigned integers)
DECIMAL (or NUMERIC)
DATE
**DATETIME`
BINARY
*/

SELECT CAST('123.45' AS DECIMAL(10, 2)) AS converted_value;
SELECT CAST(12345 AS CHAR) AS string_value;
SELECT CAST(123.45 AS SIGNED) AS integer_value;
SELECT CAST('2024-11-21' AS DATE) AS date_value;
SELECT CAST('11-21-2024' AS DATE) AS date_value;

SELECT CAST(age AS CHAR) AS age_string
FROM customers;


-- ciel = or >  -- floor = or <
SELECT floor(3.7) ;
SELECT ceil(3.7) ;

-- coalesce  --nvl --if null --null if
SELECT coalesce(email,null,0)  from customers;
SELECT coalesce(email,'xyz',0)  from customers;
SELECT ifnull(email,0)  from customers;
SELECT nullif(email,'charlie.brown@example.com')  from customers;  -- if x=y the null ,otherwise x

-- concat 
SELECT concat(customer_id , ' ' ,first_name)  from customers;
SELECT concat_ws('" "',customer_id,first_name) from customers;

-- cos ,tan ,sin
SELECT cos(customer_id)from customers;

-- current
select current_date();
select current_time();
select current_timestamp();
select current_user();
select now();

-- datepart

select extract(month from current_timestamp());
select date(current_timestamp());
select year(current_timestamp());
select month(current_timestamp());
select day(current_timestamp());
SELECT HOUR(current_timestamp()), MINUTE(current_timestamp()), SECOND(current_timestamp());
SELECT DAYOFWEEK(current_timestamp()); -- Example: 5 (Thursday)

SELECT DATE_FORMAT(current_timestamp(), '%d-%m-%y %H:%i:%s');
SELECT DATE_FORMAT('2024-11-21 10:00:00', '%Y-%m-%d %H:%i:%s');
-- Example: 2024-11-21 14:35:45


-- interval --
SELECT DATE_ADD(current_date(), INTERVAL 5 DAY);
SELECT DATE_SUB('2024-11-21', INTERVAL 2 year);

SELECT subdate('2024-11-21', INTERVAL 10 month);
select adddate('2024-11-21',interval 40 month);

SELECT DATEDIFF('2024-11-25', '2024-11-21');
SELECT DATEDIFF('2024-11-25', '2024-11-21');

SELECT TIMEDIFF('14:35:45', '12:15:30');

SELECT TIMESTAMPDIFF(HOUR, '2024-11-21 10:00:00', '2024-11-21 14:00:00');
SELECT TIMESTAMPDIFF(minute, '2024-11-21 10:00:00', '2024-11-21 14:00:00');
SELECT TIMESTAMPDIFF(year, '2024-11-21 10:00:00', '2024-11-21 14:00:00');

SELECT TIME('2024-11-21 14:35:45'); -- Example: 14:35:45


SELECT STR_TO_DATE('11-21-2024', '%m-%d-%Y');
SELECT CAST('11-21-2024' AS DATETIME);

SELECT LAST_DAY('2024-11-21'); -- Example: 2024-11-30
SELECT WEEK('2024-11-21'); -- Example: 47
SELECT TO_DAYS('2024-11-21'); -- Example: 738640

----------------------------------------------

SELECT 8 / 3 AS result;


----
select extract(year from current_timestamp());

--- string function
select instr('shivani raghu' , 'rA');
select position( 'rA'IN 'shivani raghu');
select locate('swl','my swl is swl');

select substr('shivani raghu' ,1,8);
select substring('shivani raghu' ,-8,6);
-- select patindex('shivani raghu' ,1,8);
select left('shivani raghu' ,4);
select right('shivani raghu' ,4);

select length('shivani raghu');

  -- lpad , rightpad to pad string to a specify length
   select reverse('hello');
  select rpad('hello  ',7,'*');
  select lpad('hello',10,'*');
  
  
  select substring_index('my swl ol swl ok on kp lo',' ',-2);    -- last 2 parts
  select substring_index('my swl ol swl ok on kp lo',' ',3);

------------------ --


select quarter(current_date());

select replace('shivani','a','e');

select round(12.455,2);

select to_char(current_time); --  date_format , format 

select trim(' SH');



-----------
select sum(age) from customers;
select avg(age) from customers;
select max(age) from customers;
select min(age) from customers;
select count(age) from customers;
select count(*) from customers;


-- top,limit,rownum
select age from customers order by age desc;
-- 2nd max/min
select max(age) from customers where age not in (select max(age) from customers);
select min(age) from customers where age not in (select min(age) from customers);

use companydb;
-- nth  highest

select min(age) as min from (select age from customers order by age desc limit 5 )as minq;

SELECT age 
FROM customers 
ORDER BY age DESC 
LIMIT 1 OFFSET 4; -- OFFSET is 4 because the 5th highest is the 4th index (zero-based).

-- nth lowest
select max(age) from (select age from customers order by age asc limit 5) as maxm;


-- ANY/SOME checks if at least one condition is satisfied. -- allT o test if all conditions are satisfied, use ALL instead.



SELECT *
FROM employees
WHERE salary > ANY (
    SELECT salary
    FROM employees
    WHERE department_id = 2
);





 

 

 

  
  
  
  
  ---------------------------------------------- DCL -TCL ----------------------

select * from p2;

START TRANSACTION;  -- Start a new transaction
UPDATE p2 SET id2 = id2 - 1;
-- If everything is fine, commit the changes
COMMIT;

-- The ROLLBACK statement reverts all changes made after START TRANSACTION. The employee's salary will remain unchanged.
rollback;



START TRANSACTION;

-- First update
UPDATE p1 SET salary = salary + 3000 WHERE id = 1;

select * from p1;
-- Set a savepoint after the first update
SAVEPOINT after_first_update;

-- Second update
UPDATE p1 SET salary = salary + 2000 WHERE id = 2;

-- Rollback to the first savepoint if needed
ROLLBACK TO after_first_update;

-- Third update
UPDATE p1 SET salary = salary + 1500 WHERE id = 3;

-- If everything looks good, commit the changes
COMMIT;


-- using a different storage engine (like MyISAM), transactions are not supported.

-- Autocommit Mode: By default, MySQL operates in autocommit mode, which automatically commits each query.
-- To use TCL commands, you need to disable autocommit by using START TRANSACTION (or SET autocommit = 0).

-- Example to disable autocommit:


SET autocommit = 0;
-- After the transaction, you can set autocommit back to 1:


SET autocommit = 1;



-- --------------------------- DCL ---------

CREATE USER 'root'@'localhost' IDENTIFIED BY 'shivi';
GRANT SELECT, INSERT ON p1 TO 'alice'@'localhost';
SHOW GRANTS FOR 'alice'@'localhost';
REVOKE INSERT ON p1 FROM 'alice'@'localhost';

-- GRANT privilege_type ON database_name.table_name TO 'UNhostname' IDENTIFIED BY 'password';
-- privilege_type: Specifies the privileges to grant (e.g., SELECT, INSERT, UPDATE, DELETE, ALL PRIVILEGES).

GRANT SELECT ON p1 TO 'john'@'localhost';
-- GRANT SELECT, INSERT, UPDATE ON p1 TO 'john'@'localhost' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;


-- REVOKE privilege_type ON database_name.table_name FROM 'username'@'hostname';
REVOKE SELECT ON p1 FROM 'john'@'localhost';
-- REVOKE ALL PRIVILEGES ON *.* from 'SHIVI'@'localhost';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'john'@'localhost';




-- Privilege Scope: You can specify privileges at the database level, table level, or column level.





