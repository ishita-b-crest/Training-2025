-- Using Northwind Database

/*
	-Practice Queries
	- Joins/ sub joins
	- Advanced Queries and much more
*/


select * from orders order by ship_country

select 
*
from orders
where
	ship_country = 'USA'
	or ship_country = 'France'
order by ship_country

-- count total number of orders shipping to USA or FRANCE

select 
	ship_country,
	count(*)
from orders
where
	ship_country = 'USA'
	or ship_country = 'France'
group by ship_country
order by 2 desc

-- Order shipping to any countries within latin america

-- SELECT ...
	where col in (latin america)

select
*
from orders
where
	ship_country in ('Brazil','Mexico','Argentina','Venezuela')
order by ship_country

-- Show order total amount per each order line

select
	order_id,
	product_id,
	unit_price,
	quantity,
	discount,
	((unit_price * quantity) - discount) as total_order_amount 
from order_details
order by 6 desc

-- Find the first and the latest order dates?

select 
	min(order_date) as min_order,
	max(order_date) as max_order
from orders


select 
	min(quantity) as min_qty,
	max(quantity) as max_qty
from order_details

-- Total products in each categories

select
	c.category_name,
	count(*) as total_products
from products p
inner join categories c on c.category_id = p.category_id
group by 1
order by 2 desc

-- List products that needs re-ordering

select
	product_id,
	product_name,
	units_in_stock,
	reorder_level
from products
where
	units_in_stock <= reorder_level
order by 4 desc


-- List top 5 highest freight charge

select 
	ship_country,
	avg(freight)
from orders
group by ship_country
order by 2 desc
limit 5

-- List top 5 highest freight charges in year 1997
select 
	ship_country,
	avg(freight)
from orders
where
	order_date between ('1997-01-01') and ('1997-12-31')
group by ship_country
order by 2 desc
limit 5

-- List top 5 highest freight charges last year

select max(order_date) from orders

select 
	ship_country,
	avg(freight)
from  orders
where 
	extract ('Y' from order_date) >=  select max(order_date) from orders
group by ship_country
order by 2 desc
limit 5

-- customer with no orders

select
*
from customers c
left join orders o on o.customer_id = c.customer_id

select *
from customers c
left join orders o on o.customer_id = c.customer_id
where o.customer_id is not null;

-- Top customers with their total order amount spend

select
	c.customer_id,
	c.company_name,
	sum((od.unit_price * od.quantity)-od.discount) as total_amount
from customers c
join orders o on o.customer_id = c.customer_id
join order_details od on od.order_id = o.order_id
group by 
	c.customer_id,
	c.company_name
order by 3 desc
limit 10


-- order with many line of items

select * from order_details
order by order_id


select 
	order_id,
	count(*)
from order_details
group by order_id
order by 2 desc
limit 10

-- Orders with double entry line items

select 
	order_id,
	quantity
from order_details
where
	quantity > 60
group by 
	order_id,
	quantity
having 
	count(*) > 1
order by 
	order_id


select * from order_details where order_id = 10395

-- Lets get the details of the items too

 with duplicate_entries as
 (
	select 
		order_id,
		quantity
	from order_details
	where
		quantity > 60
	group by 
		order_id,
		quantity
	having 
		count(*) > 1
	order by 
		order_id
)
select
	*
from order_details
where
	order_id in (select order_id from duplicate_entries)
order by
	order_id


-- List all late shipped orders

select
	*
from orders
where 
	shipped_date > required_date
	
-- List employees with late shipped orders

with late_orders as
(
	select 
		employee_id,
		count(*) as total_late_orders
	from orders
	where
		shipped_date > required_date
	group by 
		employee_id
),
all_orders as
(
	select
		employee_id,
		count(*) as total_orders
	from orders
	group by 
		employee_id
)
select
	employees.employee_id,
	employees.first_name,
	all_orders.total_orders,
	late_orders.total_late_orders
from employees
join all_orders on all_orders.employee_id = employees.employee_id
join late_orders on late_orders.employee_id = employees.employee_id
order by late_orders.total_late_orders desc

-- Countries with customers or suppliers

with countries_suppliers as
(
	select distinct country from suppliers
),
countries_customers as
(
	select distinct country from customers
)
select
	countries_suppliers.country as country_suppliers,
	countries_customers.country as country_customers
from 
	countries_suppliers
full join countries_customers on countries_customers.country = countries_suppliers.country


-- Customers with multiple orders

-- say within 4 days period  

with next_order_date as
(
	select 
		customer_id,
		order_date,
		lead (order_date, 1) over (partition by customer_id order by customer_id, order_date) as next_order_date
	from orders
)
select
	customer_id,
	order_date,
	next_order_date,
	(next_order_date - order_date) as days_between_orders
from next_order_date
where
	(next_order_date - order_date) <= 4

-- First order from each country

with orders_by_country as
(
	select
		ship_country,
		order_id,
		order_date,
		row_number() over (partition by ship_country order by ship_country, order_date) country_row_number
	from orders
)
select 
	ship_country,
	order_id,
	order_date
from orders_by_country
where
	country_row_number = 1

