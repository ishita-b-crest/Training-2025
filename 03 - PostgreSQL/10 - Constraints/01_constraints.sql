-- Not null constraint
create table table_nn(
	id serial primary key,
	tag text not null
);

select * from table_nn;

insert into table_nn(tag) values ('adam');

insert into table_nn(tag) values (NULL);

insert into table_nn(tag) values ('');

insert into table_nn(tag) values ('0');

create table table_nn2(
	id serial primary key,
	tag2 text not null
);

alter table table_nn2
alter column tag2 set not null;


insert into table_nn2(tag2) values (NULL);

insert into table_nn2(tag2) values ('');

insert into table_nn2(tag2) values ('0');

-- Unique constraint

create table table_emails(
	id serial primary key,
	emails text unique
);

select * from table_emails;

insert into table_emails (emails) values ('a@b.com');

create table table_products(
	id serial primary key,
	product_code varchar(10),
	product_name text
);

alter table table_products
add constraint unique_product_code unique (product_code, product_name);

insert into table_products (product_code, product_name) values('apple','A');


-- default constraint
create table employees(
	employee_id serial primary key,
	first_name varchar(10),
	last_name varchar (50),
	is_enable varchar(2) default 'y'
);

select * from employees;

insert into employees(first_name, last_name) values ('Priyam2', 'Vyas2');

alter table employees
alter column is_enable set default 'N';

alter table employees
alter column is_enable drop default;

-- Primary key constraint
create table table_items(
	item_id integer primary key,
	item_name varchar(100) not null
);

select * from table_items;

insert into table_items(item_id, item_name) values (1,'Pen');

-- Constraint naming convention --> Tablename_pkey

-- drop a constraint
alter table table_items
drop constraint table_items_pkey;

-- alter table and add a primary key
alter table table_items
add primary key(item_id, item_name);

insert into table_items(item_id, item_name) values (2,'');


-- Primary key constraints on multiple columns
create table t_grades(
	course_id varchar(100) not null, 
	student_id varchar(100) not null,
	grade int not null,
	primary key (course_id, student_id)
);

select * from t_grades;

insert into t_grades(course_id, student_id, grade) 
values 
('Math','S',70),
('Chemistry','S',70),
('English','S',80),
('Physics','S',80);

drop table t_grades;

-- drop a primary key
alter table t_grades
drop constraint t_grades_pkey;

SELECT conname, contype
FROM pg_constraint
WHERE conrelid = 't_grades'::regclass;

alter table t_grades 
	add constraint t_grades_course_id_session_id_pkey
		primary key(course_id, student_id);

-- Tables without foreign key constraints
drop table table_products;

create table t_products(
	product_id int primary key,
	products_name varchar(100) not null,
	supplier_id int not null 
);

create table t_suppliers(
	supplier_id int primary key,
	supplier_name varchar(100) not null
)

insert into t_suppliers(supplier_id,supplier_name) values
(1, 'supplier 1'),
(2, 'supplier 2');

select * from t_suppliers

insert into t_products(product_id,products_name, supplier_id) values
(4, 'computer', 10);


select * from t_products;


-- Tables with foreign key constraints
drop table t_products;

drop table t_suppliers;

create table t_suppliers(
	supplier_id int primary key,
	supplier_name varchar(100) not null
)

create table t_products(
	product_id int primary key,
	products_name varchar(100) not null,
	supplier_id int not null,
	foreign key (supplier_id) references t_suppliers(supplier_id)
);


insert into t_suppliers(supplier_id,supplier_name) values
(100, 'supplier 100'),
(2, 'supplier 2');

select * from t_suppliers

insert into t_products(product_id,products_name, supplier_id) values
(1, 'pen', 1),
(2, 'pencil', 2);

select * from t_products;
	
	insert into t_products(product_id,products_name, supplier_id) values
	(4, 'computer', 100);

-- Delete data from child or foreign table
delete from t_products where product_id = 4;
delete from t_suppliers where supplier_id = 100;

-- update data on parent table
update t_products
set supplier_id = 100
where
	product_id = 1

-- drop a constraint
alter table t_products 
drop constraint t_products_supplier_id_fkey;

-- Add or update foriegn key constraint
alter table t_products 
add constraint t_products_supplier_id_fkey foreign key(supplier_id) references t_suppliers(supplier_id);

drop table staff;
-- Define check for new tables
create table staff(
	staff_id serial primary key,
	first_name varchar(50),
	last_name varchar(50),
	birth_date date check (birth_date < '2006-01-01'),
	joined_date date check (joined_date > birth_date),
	salary numeric check (salary > 0)
);

select * from staff;

insert into staff(first_name,last_name,birth_date,joined_date,salary)	
values ('Priyam1', 'Vyas11', '2004-05-01', '2025-07-02', 10000)

-- Add, Rename drop on existing table

create table prices(
	price_id serial primary key,
	product_id int not null,
	price numeric not null,
	discount numeric not null,
	valid_from date not null
);

-- Add a constraint
alter table prices
add constraint price_check
check (
	price > 0
	and discount >= 0
	and price > discount
);

insert into prices(product_id,price,discount,valid_from)
values('1', 100, 20, '2020-10-01');
	
	select * from prices;

-- rename constraint
alter table prices
rename constraint price_check to price_discount_check

-- drop a constraint
alter table prices 
drop constraint price_discount_check














