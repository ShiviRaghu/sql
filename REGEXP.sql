
SELECT * 
FROM employee_data 
WHERE first_name REGEXP '^[^AEIOUaeiou]'; 
  -- ^ start of string matches
SELECT * 
FROM employee_data 
WHERE first_name REGEXP '^[AEIOUaeiou]';

-- regexp - regular expressions

-- syntax - where col_name regexp 'pattern'
-- patterns are made up of - literal characters (exact matches like abc), 
-- special characters (flexible search patterns)

-- ^ --> start of a string

-- find customer names that start with A 

select Name
from Customers
where Name regexp '^A';

-- $ --> end of the string

-- find customer names which end with a

select Name
from Customers
where Name regexp 'a$';   

-- find customer names which are just A
-- name = 'A'
-- name like 'A'
-- name regexp '^A$'

-- where name like '%a%';

-- . --> any single character

-- find customer names which contain exactly one character between a and c

select name from customers
where name regexp 'a.c'; 

create table example
(customerid varchar(10));

insert into example
values ('ABC123'), ('GHIITC'), ('12RTUON');

select * from example;

-- find customerids which conatin any digit

-- customerid like '%1%' or customerid like '%2%'......

-- [] --> character class, [aeiou] -> matches any vowel
 
select *
from example
where customerid regexp '[0-9]';

--  To find customer names that do not start with vowels and do not end with vowels 
-- using REGEXP

select *
from example
where lower(customerid) regexp '^[aeiou].*[aeiou]$';

-- starts with vowel and ends with vowel

select *
from example
where lower(customerid) regexp '^[^aeiou].*[^aeiou]$';

-- does not start or end with vowel 

-- ^ -> patterns matches at start of string
-- [^] --> not operator  

-- name regexp '[^0-9]$' --> name should not end with any digit
 
-- .* -> ensures 0 or more characters are present (% in like) 

-- name regexp '^0' -- start with 0

select 'ayesha123@gmail.com';
-- extract domain 

select 'ayesha123@gmail.com', 
substring_index('ayesha123@gmail.com','@',-1),
substring_index('ayesha123@gmail.com','@',1);

-- madam 

