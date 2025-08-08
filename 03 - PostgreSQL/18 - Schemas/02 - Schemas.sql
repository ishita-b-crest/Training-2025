-- Duplicate schema w3ith all data

-- 1. Lets create a sample database called 'test_schema'

create database test_schema;

-- 2. Create a table called "Songs"

create table test_schema.public.songs(
	song_id serial primary key,
	song_title varchar(100)
);

-- 3. Add some data to songs tables

insert into test_schema.public.songs (song_title) values
('Counting Stars'),
('Rolling on')

-- 4. Now duplicate the schema "public" with all data
pg_dump -d test_schema -h localhost -U postgres -n public > dump.sql

-- schemas and privileges

-- 1. Lets create a schema called 'private' on 'hr' database and give rights to postgres user

grant usage on schema private to crest;

grant select on all tables in schema private to crest











