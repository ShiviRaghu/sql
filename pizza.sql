/*customer preferences, sales performance, and operational trends that can drive data-driven decision-making.
 
  most popular pizza types, 
  analyzing revenue generation, 
  and uncovering ordering patterns across different times and categories. Y
  
  Top-Selling and Most Ordered Pizzas: Identifying the most frequently ordered pizzas and determining which types generate the most revenue.
  
  Revenue Analysis: Tracking how revenue accumulates over time, offering insights into sales performance and potential seasonal trends.
  
  Order Patterns and Trends: Analyzing how orders vary by date and time to identify peak hours and average daily sales, which can be critical for staffing and resource allocation.
  
  Category-Wise Analysis: Examining the distribution of orders across different pizza categories, helping to understand customer preferences and adjust the menu offerings accordingly.
  
  */
  use pizza;
  
  select * from pizzas;
  select * from pizza_types;
  select * from order_details;
  select * from orders;
  
-- 1.Top-Selling and Most Ordered Pizzas: Identifying the most frequently ordered pizzas 
-- 2. and determining which types generate the most revenue.

with cte1 as (
select pizza_id ,count(order_id) as order_placed
from order_details
group by 1 order by order_placed desc limit 1),

cte2 as(
select p.pizza_id ,sum(o.quantity*p.price) as rev_gen
from pizzas p left join order_details o
on p.pizza_id = o.pizza_id
group by 1 order by rev_gen desc limit 1)

SELECT 
    cte1.pizza_id AS most_ordered, 
    cte1.order_placed AS max_orders, 
    cte2.pizza_id AS top_selling,
    cte2.rev_gen AS top_sales
FROM 
    cte1, cte2;


select o.pizza_id ,sum(o.quantity*p.price) as rev_gen,count(order_id) as order_placed
from pizzas p left join order_details o
on p.pizza_id = o.pizza_id
group by 1 order by rev_gen desc ,order_placed desc;



-- 3.   Revenue Analysis: Tracking how revenue accumulates over time, offering insights into sales performance and potential seasonal trends.

select month(o1.date),round(sum(o.quantity*p.price),2) as rev_gen
from pizzas p left join order_details o
on p.pizza_id = o.pizza_id
left join orders o1
on o.order_id =o1.order_id
group by 1 order by 2 desc;

select * from order_details;

-- Chapter 2: Data Exploration 

-- Task 1 :  Retrieve the total number of orders placed.
select count(distinct order_id) as total_orders from order_details;
select count(order_id) as total_orders from orders;

-- Task 2: Calculate the total revenue generated from pizza sales.
select round(sum(o.quantity*p.price),2) as rev_gen
from pizzas p left join order_details o
on p.pizza_id = o.pizza_id
order by rev_gen desc;

-- Task 3 : Identify the highest-priced pizza.

select pt.name,p.price
from pizzas p left join pizza_types pt
on p.pizza_type_id = pt.pizza_type_id
where pizza_id=
(select pizza_id from pizzas where price =(
select max(price)
from pizzas));

select pt.name,p.price
from pizzas p left join pizza_types pt
on p.pizza_type_id = pt.pizza_type_id
order by p.price desc limit 1;

-- Task 4 : Identify the most common pizza size ordered.

select p.size ,count(od.order_id)
from pizzas p left join order_details od
on p.pizza_id = od.pizza_id
group by 1 order by 2 desc;

-- Chapter 3: Sales Analysis - Crunching the Numbers
-- Task 1:  List the top 5 most ordered pizza types along with their quantities

-- most ordered --pizza types -- quantity --top 5

select count(*) from order_details;

select pt.name ,sum(o.quantity) as quant_ordered
from pizzas p join pizza_types pt
on p.pizza_type_id =pt.pizza_type_id
join
order_details o  on o.pizza_id = p.pizza_id
group by  pt.name order by quant_ordered desc limit 5 ;


-- Task 2 : Determine the distribution of orders by hour of the day.

select hour(time) as hr,count(order_id) from orders as orders_count
group by 1 order by 2 desc ;


-- Task 3 : Determine the top 3 must ordered pizza types based on revenue.


select pt.name,round(sum(o.quantity*p.price),2) as rev_gen
from pizzas p  join order_details o
on p.pizza_id = o.pizza_id
 join pizza_types pt
on pt.pizza_type_id =p.pizza_type_id
group by 1 order by 2 desc limit 3;


-- Chapter 4: Operational Insights 
-- Task 1: Calculate the percentage contribution of each  pizza type to total revenue

with rev as (
select round(sum(o.quantity*p.price),2) as total_revenue
from pizzas p  join order_details o
on p.pizza_id = o.pizza_id )

select pt.category,round((sum(o.quantity*p.price) /(select total_revenue from rev)*100),2)as percent
from pizzas p  join order_details o
on p.pizza_id = o.pizza_id
join pizza_types pt
on pt.pizza_type_id =p.pizza_type_id
group by 1 ;

-- Task 2 :  Analyse the cumulative revenue generated over time
with rev as (
select ot.date as dt,round(sum(o.quantity*p.price),2) as rev_gen
from pizzas p join order_details o
on p.pizza_id = o.pizza_id
join orders ot
on ot.order_id = o.order_id
group by 1 )

select dt,sum(rev_gen) over(order by dt) as cum_sum
from rev;

-- Task 3 : Determine the top 3 most ordered pizza types based on revenue for each pizza category

select pt.category,round((sum(o.quantity*p.price) /(select total_revenue from rev)*100),2)as percent
from pizzas p  join order_details o
on p.pizza_id = o.pizza_id
join pizza_types pt
on pt.pizza_type_id =p.pizza_type_id
group by 1 ;

-- Chapter 5: Category-Wise Analysis:
--- Task 1: Join the necessary tables to find the total quantity of each pizza category ordered.alter

select pt.category ,sum(o.quantity) from
pizzas p join pizza_types pt
on pt.pizza_type_id =p.pizza_type_id
join  
order_details o
on p.pizza_id = o.pizza_id
group by 1;



--  Task 2 :Join relevant tables to find the category-wise distribution of pizzas.alter

select category ,count(name) from
pizza_types pt
group by 1
;

select * from pizza_types;


-- Task 3 : Group the orders by the date and calculate the average number of pizzas ordered per day.alter

select avg(sum) from (
select o.date,sum(od.quantity) as sum from 
orders o join order_details od
on o.order_id =od.order_id
group by 1) as ord;

