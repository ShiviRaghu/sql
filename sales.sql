use sales;
select * from coffee_sales1;
select Cogs,Margin,Market,'Area Code ' from coffee_sales1 limit 10;

create table orders (OrderID int, 
OrderDate date ,
CustomerName varchar(50),
ProductName varchar(50),
Quantity int,
TotalPrice float(2));

select * from orders;
insert into orders (OrderID,OrderDate, CustomerName, ProductName, Quantity, TotalPrice)
values
(111, '2024-10-10','Alice','Laptop', 1, 60000.89),
(121, '2024-09-08','Emily','Headphones', 2, 78000.49),
(122, '2024-09-18','David','Airpodes', 2, 48000.76),
(131, '2024-09-28','Zena','Monitor', 4, 118000.99),
(141, '2024-09-03','James','Smart Watch', 1, 68000.49),
(124, '2024-08-28','John','Laptop', 2, 138000.89),
(126, '2024-08-20','Linda','Airpodes', 1, 28000.49),
(151, '2024-08-26','Jane','Keyboard', 2, 88000.69);

alter table orders add address varchar(20);
alter table orders modify address varchar(36);

insert into orders (address)
values ('chennai'),
('bhopal');

update orders set address='india' where address is null;

alter table orders drop column address;

delete from orders where Quantity is null;

-- objective finds insights to find sales --  for products 

-- sales year on year
-- sales by area
-- sales by market
-- market size by area 

select * from coffee_sales1;

 -- 1.------------- sales year on year
 
 select YEAR(CAST(Date AS DATE)), sum(Sales) as yearly_Sales
 from coffee_sales1 group by 1 ;   -- not working here
 
set sql_safe_updates =0;
update coffee_sales1 set Date = STR_TO_DATE(Date,'%m/%d/%Y');
 
select YEAR(Date), sum(Sales) as yearly_Sales
 from coffee_sales1 group by 1 order by 1;
 -- ANS 1 MAKING PROGRESS TILL 2014 AND THEN DECREASES 
 
 -- QUERY FOR YEAR ON YEAR % CHANGE
 SELECT YEAR(Date),sum(Sales) as yearly_sales,
    LAG(sum(Sales)) OVER (ORDER BY  YEAR(Date)) AS previous_yr_sales,
    ROUND(((sum(Sales) - LAG(sum(Sales)) OVER (ORDER BY YEAR(Date))) 
           / LAG(sum(Sales)) OVER (ORDER BY YEAR(Date))) * 100, 2) AS percentage_change
FROM 
    coffee_sales1 group by 1;
    
    
    WITH YearlySales AS (
        SELECT YEAR(Date) AS year,
        SUM(Sales) AS yearly_sales
    FROM  coffee_sales1 GROUP BY 1
)
SELECT 
    year,
    yearly_sales,
    LAG(yearly_sales) OVER (ORDER BY year) AS previous_yr_sales,
    ROUND(((yearly_sales - LAG(yearly_sales) OVER (ORDER BY year)) 
           / LAG(yearly_sales) OVER (ORDER BY year)) * 100, 2) AS percentage_change
FROM YearlySales;




-- 2.  MONTHLY SALES

select MONTH(Date), sum(Sales) as yearly_Sales
from coffee_sales1 group by 1 
order by 2 desc ;
 
 -- product and their sales
 
 -- mid year - spike in sales

-- what are the different products 

select distinct Product from coffee_sales1;
-- produuct vs sales

select Product, sum(Sales) as total_sales
 from coffee_sales1
 group by 1
 order by 2 desc;


-- 1.Find the best-performing product lines by total profit

select * from coffee_sales1;
select Product_line,sum(Profit) as total_profit from coffee_sales1 group by 1 order by 2 desc
;

-- 2.Compare actual vs target sales across different states

select State,sum(Sales) as act_Sales, sum(Target_sales) as targ_sales,
case 
when sum(Sales) >=sum(Target_sales) then 'profitable'
when sum(Sales) <sum(Target_sales) then 'loss'
else 'not valid'
end as sale_category
from coffee_sales1 group by 1 order by 2,3 desc
;

with s as (select State,
sum(Sales) as actual_sales, sum(Target_sales) as target_sales
from coffee_sales1
group by 1)

select State, actual_sales,Target_sales,
case when actual_sales >=  target_sales then 'Profitable'
when actual_sales < target_sales then 'Loss'
else null end as Target_status
from s;


-- 3. Identify areas with the largest gaps between actual and target profits

select `Area Code`,DifferenceBetweenActualandTargetProfit from coffee_sales1;
select `Area Code`, sum(DifferenceBetweenActualandTargetProfit) as diff
from coffee_sales1 group by 1 order by 2 desc limit 5;

-- 4. Calculate average margin for each product type
select distinct Product_type,
round(avg(Margin) over(partition by Product_type),2) as avg_margin
from coffee_sales1 ;

SELECT Product_type, AVG(Margin) AS Average_Margin 
FROM coffee_sales1 GROUP BY Product_type ORDER BY Average_Margin DESC;

-- 5. Analyze inventory margin vs marketing expenses

SELECT Market, round(avg(Marketing),2) as avg_marketing ,round(avg(`Inventory Margin`),2) AS Average_Margin 
FROM coffee_sales1 GROUP BY 1 ORDER BY 2 DESC;

SELECT 
    Product_line,
    AVG(`Inventory Margin`) AS Avg_Inventory_Margin,
    AVG(Marketing) AS Avg_Marketing
FROM 
    coffee_sales1
GROUP BY 
    Product_line
ORDER BY 
    Avg_Inventory_Margin DESC;

-- 6. Rank the states by their market size

select * from coffee_sales1;

select  State, Market_size,
dense_rank() over( order by Market_size) as rnk
from coffee_sales1
group by 1,2 ;

/*ince dense_rank() is applied over a window,
 the result must adhere to the SQL rule that every column in the
 SELECT clause either appears in the GROUP BY clause or is part of an aggregate/window function. /

Not applicable here: In your query, the goal is to rank all states by their 
--  Market_size across the entire dataset—not separately within groups.
 -- Therefore, you use order by Market_size without partition by.
