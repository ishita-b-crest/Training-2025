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

-- Index Nodes

explain select * from orders
natural join customers

-- Index Types

-- B-Tree Index

create index idx_orders_order_date_on on orders
using hash (order_date)

select * from orders order by order_date

explain select * from orders where order_date = '2020-01-01'

-- BRIN Index

-- GIN index

-- EXPLAIN statement

select * from suppliers;

explain select * from suppliers
where supplier_id = 1

explain select company_name from suppliers 
order by company_name

explain select company_name from suppliers 
where supplier_id = 1
order by company_name, city;


-- EXPLAIN 	output options

explain ( format json ) select * from orders where order_id = 1

explain select * from orders where order_id = 1

explain select * from orders where order_id = 1 order by order_id

select count(*) from orders

explain analyze select * from orders where order_id = 1 order by order_id

explain (analyze) select * from orders where order_id = 1 order by order_id

create table t_big (id serial, name text);

insert into t_big (name)
select 'Adam' from generate_series(1,2000000);

insert into t_big (name)
select 'Linda' from generate_series(1,2000000);

select * from t_big where id = 12345

explain select * from t_big where id = 12345

show max_parallel_workers_per_gather
set max_parallel_workers_per_gather to 0;

select pg_relation_size('t_big') / 8192.0

show seq_page_cost;

show cpu_tuple_cost

show cpu_operator_cost

select 
	pg_size_pretty(
		pg_total_relation_size('t_big')
	)
select
	pg_size_pretty(pg_indexes_size('t_big'));

explain analyze select * from t_big where id = 123456

create index idx_t_big_id on t_big(id)


paraller index creation -> btree index
show max_parallel_maintance_workers

explain select * from orders where order_id = 1

-- Indexes for second output

explain select * from t_big
order by id limit 20;

explain select * from t_big
order by name limit 20;

explain select
min(id),
max(id)
from t_big


-- using multiple indexes on a single query

explain select * from t_big
where 
	id = 20
	or id = 40

-- execution plans depends on input values

create index idx_t_big_name on t_big (name);

explain select * from t_big where name = 'Adam'
limit 10

explain select * from t_big
where 
	name = 'Adam'
	or name = 'Linda'


explain select * from t_big
where 
	name = 'Adam1'
	or name = 'Linda1'


-- Using organized vs random data

select * from t_big order by id limit 10

explain (analyze true, buffers true, timing true)
select * from t_big where id < 10000

-- order by random()

create table t_big_random as select * from t_big order by random()

create index idx_t_big_random_id on t_big_random (id)

select * from t_big_random limit 10

vacuum analyze t_big_random

explain (analyze true, buffers true, timing true)
select * from t_big_random where id < 10000

select 
	tablename,
	attname,
	correlation
from pg_stats
where 
	tablename in ('t_big', 't_big_random')
order by 1, 2

explain analyze select id from t_big where id = 123456;  --0.179
 
create index idx_p_t_big_name on t_big(name)
where name not in('Adam','Linda');
 
select * from customers;
 
update customers
set is_active = 'N'
where customer_id in ('ALFKI','ANATR');
 
explain analyze select * from customers
where is_active = 'N';
 
create index idx_p_customers_inactive on customers(is_active)
where is_active = 'N';
 
select count(*) from customers;
 
create table t_dates as select d, repeat(md5(d::text),10) as padding
from generate_series(timestamp '1800-01-01',timestamp '2100-01-01',interval '1 day')s(d);
 
vacuum analyze t_dates;
 
select count(*) from t_dates;
 
explain select * from t_dates
where d between '2001-01-01' and '2001-01-31';
 
create index idx_t_dates on t_dates(d);
 
explain analyze select * from t_dates
where d between '2001-01-01' and '2001-01-31';
 
create index idx_expr_t_dates on t_dates(extract(day from d));
 
analyze t_dates;
 
explain analyze select * from t_dates
where extract(day from d) = 1;
 
--Adding Data whilr indexing
 
create index concurrently  idx_t_big_name2 on t_big(name);

select 
	oid,relname,relpages,reltuples,
	i.indisunique,i.indisclustered,i.indisvalid,
	pg_catalog.pg_get_indexdef(i.indexrelid,0,true)
	from pg_class c join pg_index i on c.oid = i.indrelid
	where c.relname = 't_big';


select 
	oid,relname,relpages,reltuples,
	i.indisunique,i.indisclustered,i.indisvalid,
	pg_catalog.pg_get_indexdef(i.indexrelid,0,true)
	from pg_class c join pg_index i on c.oid = i.indrelid
	where c.relname = 'orders';
 
select * from orders

explain select * from orders where ship_country = 'USA';

-- Lets disallow the query optimizer 
update pg_index 
set indisvalid = false
where indexrelid = (select oid from pg_class
					where relkind = 'i'
					and relname = 'idx_orders_ship_country')


update pg_index 
set indisvalid = true
where indexrelid = (select oid from pg_class
					where relkind = 'i'
					and relname = 'idx_orders_ship_country')

-- Rebuilding an index 

reindex  index idx_orders_customer_id_order_id 

reindex (verbose) database mydata

reindex (verbose) table concurrently orders

