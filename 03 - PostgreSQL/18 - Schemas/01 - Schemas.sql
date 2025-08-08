-- Schema Operations

-- 1. Create a schema

-- Create schema schema_name

create schema sales

create schema hr 

-- 2. Rename a schema

alter schema sales rename to programming

-- 3. Drop a schema


-- 1. Lets create new database called "test"
-- database.schema.object_name

select * from mydata.public.actors;


-- 2. Select a table other than 'public' schema

select * from mydata.humanresources.employees


-- mopve a table to new schema

-- alter table table_name set schema schema_name

alter table humanresources.orders set schema public 

-- schema search path 

select current_schema()


select * from orders

-- 2. How to view current search path?

show search_path

-- 3. postgres, public

select * from public.orders


-- 3. How to add new schema to search path

-- set search_path to schema_path, public

set search_path to humanresources, public

set search_path to public, humanresources

select * from test1


insert into public.test2 (id2) values (1)

select * from test2

-- Schema Ownerships

-- alter schema schema_name owner to new_owner

alter schema humanresources owner to crest
