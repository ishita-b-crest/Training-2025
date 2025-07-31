-- Database: mydata

-- DROP DATABASE IF EXISTS mydata;

CREATE DATABASE mydata
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_India.1252'
    LC_CTYPE = 'English_India.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


create table persons(
	person_id serial primary key,
	first_name varchar(20) not null,
	last_name varchar(20) not null
);

alter table persons
add column age int not null;

select * from persons;

alter table persons
add column nationality varchar(20) not null,
add column email varchar(100) unique

-- Modify table structure

-- rename a table

alter table users 
rename to persons;

--rename a column

alter table persons
rename column age to person_age;

-- Drop a column

alter table persons
drop column person_age;


alter table persons
add column age varchar(10);

-- change data type pf a column

alter table persons
alter column age type int
using age::integer;

alter table persons
alter column age type varchar(20);

select * from persons;

-- set a default values of a column

alter table persons
add column is_enable varchar(1);


alter table persons
alter column is_enable set default 'Y';

insert into persons
(
	first_name,
	last_name,
	nationality,
	age
)
values
(
	'John',
	'Behn',
	'Us',
	40
);


-- Add a constraint to a column

-- add a unique consstraint to a column

create table web_link(
	link_id serial primary key,
	link_url varchar(255) not null,
	link_target varchar(20)
);

select * from web_link

insert into web_link(link_url, link_target)
values ('https://www.youtube.com', '_blank');

alter table web_link
add constraint unique_web_url unique (link_url);

alter table web_link
add column is_enable  varchar(2);


insert into web_link(link_url, link_target, is_enable)
values ('https://www.netflix.com', '_blank', 'Y');

alter table web_link
add check (is_enable in ('Y','N'));

update web_link 
set is_enable = 'N'
where link_id = 3



									



















 