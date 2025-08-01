-- Introduction to contraints

create table table_nn(
	id serial primary key,
	tag text not null
)

-- lets view the data

select * from table_nn

insert into table_nn (tag) values
('ADAM');


create table table_nn2(
	id serial primary key,
	tag2 text
)

alter table table_name
alter column column_name set ....

alter table table_nn2
alter column tag2 set not null;

insert into table_nn2 (tag2) values
('ADAM')

create table table_emails(
	id serial primary key,
	emails text unique
)

select * from table_emails

insert into table_emails (emails) values ('a@b.com')

create table table_products(
	id serial primary key,
	product_code varchar(10),
	product_name text
)

alter table table_products
add constraint unique_product_code unique (product_code, product_name)

insert into table_products (product_code,  product_name) values
('A', 'apple');

select * from table_products

create table employee(
	employee_id serial primary key,
	first_name varchar(50),
	last_name varchar(50),
	is_enable varchar(2) default 'Y'
)


insert into employee (first_name, last_name) values ('JOH','ADA');

alter table employee 
alter column is_enable set default 'N'

-- drop default value

alter table employee
alter column is_enable drop default 


select * from employee

-- Primary contraint

create table table_items(
	item_id integer primary key,
	item_name varchar(100) not null
)

select * from table_items;

insert into table_items (item_id, item_name) values
(1, 'pen')

-- drop a constraits

alter table table_items
drop constraint table_items_pkey;


-- add a primary key

alter table table_items
add primary key(item_id)

select * from table_items


create table t_grades(
	course_id varchar(100) not null,
	student_id varchar(100) not null,
	grade int not null
);

select * from t_grades
insert into t_grades (course_id, student_id, grade) values
('Math','S1',50),
('Chemistry','s1',70),
('English','s2',70),
('Physics', 's1',80);

drop table t_grades;

alter table t_grades
drop constraint t_grades_pkey



























