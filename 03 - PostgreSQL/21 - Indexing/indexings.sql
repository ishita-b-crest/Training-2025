-- Indexing 

-- Try to keep the naming conventions unique and globally accesable

index 		  create index idx_table_name_column_name
unique index  create index idx_u_table_name_column_name

-- 1. Lets create an index on order_date on order table
ALTER TABLE orders
ADD COLUMN order_date DATE;

create index idx_orders_order_date on orders (order_date)

select * from orders

-- 2. Create an index on multiple fields say orders -> customer_id, order_id

create index idx_orders_customer_id_order_id on orders (customer_id, order_id)


ALTER TABLE orders
ADD COLUMN customer_id INT,
ADD COLUMN employee_id INT,
ADD COLUMN required_date DATE,
ADD COLUMN shipped_date DATE,
ADD COLUMN ship_via INT,
ADD COLUMN freight NUMERIC(10,2),
ADD COLUMN ship_name VARCHAR(255),
ADD COLUMN ship_address VARCHAR(255),
ADD COLUMN ship_city VARCHAR(100),
ADD COLUMN ship_region VARCHAR(100),
ADD COLUMN ship_postal_code VARCHAR(20),
ADD COLUMN ship_country VARCHAR(100);

-- create unique indexes

-- 	primary key and indexes

-- lets create a unique index on products table on product_id

create unique index idx_u_products_product_id on products (product_id);

-- lets create a unique index on employee table on employee_id


create unique index idx_u_employee_employee_id on employees (employee_id)

create unique index idx_u_orders_order_id_customer_id on orders (order_id, customer_id)

create unique index idx_u_employees_employee_id_hire_date on employees (employee_id, hire_date)

select * from employees

insert into employees (employee_id, first_name, last_name) values(1, 'a', 'b');

create table t1(
	id serial primary key,
	tag text
)

select * from t1

insert into t1 (tag) values ('a'), ('b')

create unique index idx_u_t1_tag on t1(tag)

-- List all indexes

select
*
from pg_indexes
where schemaname = 'public'
order by
	tablename,
	indexname

-- indexes of a table

select
*
from pg_indexes
where tablename = 'orders'
order by
	tablename,
	indexname

-- size of the table index

-- lets create an index on supplier -> region

select
	pg_indexes_size('orders')

-- List all indexes


select
	*
from pg_indexes
where
	tablename = 'orders'
order by
	tablename,
	indexname

select count(*) from orders

-- lets create an index on supplier -> region

create index idx_suppliers_region on suppliers (region)


SELECT pg_size_pretty(pg_indexes_size('suppliers'));   --- 32 KB

--- Adding indices may improve the speed of the data access but they add a COST to the data modification. 
--- Therefore it is important to understand if the index is used.

--- pg_stat_all_indexes
SELECT * FROM pg_stat_all_indexes;
SELECT * FROM pg_stat_all_indexes WHERE schemaname = 'public';
SELECT * FROM pg_stat_all_indexes WHERE relname = 'orders';

--- Drop indexes
DROP INDEX [CONCURRENTLY]
[IF EXISTS] index_name
[CASCADE | RESTRICT]     --- syntax

DROP INDEX idx_suppliers_region;
--- 	SQL statement stages
---    parser --> rewriter --> optimizer --> executor
--- optimizer  
--- nodes  --- available for every operations and access methods 
--- types of nodes  ,  nodes are stackable 

SELECT * FROM pg_am;






