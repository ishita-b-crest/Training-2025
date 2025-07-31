-- boolean datatype

-- supports single boolean data type: True, False, and NULL.

-- 1. lets create a sample table called 'table_boolean'

create table table_boolean(
	product_id serial primary key,
	is_available boolean not null
);

-- 2. lets insert some data

insert into table_boolean (product_id) values (4)

-- 3. Lets view the records

select * from table_boolean;

insert into table_boolean (is_available) values (False);
insert into table_boolean (is_available) values (TRUE)

-- 4. Lets insert more variable of boolean data

select * from table_boolean
where is_available = '0'

--5. lets do some condition search  

select 8 from table_boolean 
where is_available = 'y'

-- 6. using NOT condition

alter table table_boolean 
alter column is_available
set default  false


-- CHARACTER DATA TYPE


select cast ('adnan' as character(10)) as "Name";


select 'Adnan'::char(10) as "Name"

select 
	cast('Adnan' as character(10)) as "Name1",
	'Adnan'::char(10) as "Name2"

select 'Adnan'::char as "Name";

select 'Adnan'::varchar(10)

select 'This is a system from'::varchar(10)
"This is a "

select 'ABCD 123 $%&j*'::VARCHAR(10)

create table table_characters(
	col_char char(10),
	col_varchar varchar(10),
	col_text TEXT
);

insert into table_characters(col_char, col_varchar, col_text) values
('abc', 'abc','abc')

select * from table_characters

