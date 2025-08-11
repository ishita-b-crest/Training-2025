-- Exploring JSON objects

-- 1. How will you represent a JSON object in postgresql
select '{"title":"The lord of the rings"}'

-- 2. Do you have to cast data type to make it JSON data type?

select '{"title":"The Lord of the rings"}'::json 

-- 3. Can we preserve white spaces, if yes how?

select '{
	"title":"The Lord of the rings"
}'::json 

-- 4. What if we dont want white space?

select '{
	"title":"The Lord of the rings"
}'::jsonb

-- Create our first table with JSONB data type

-- 1. Create a table called "books"

create table books(
	book_id serial primary key,
	book_info JSONB
)

-- insert some data

-- single record
insert into books (book_info) values
('{"title":"book1",
"auther":"author1"}')

select * from books

insert into books (book_info) values
('
{
	"title":"book2",
	"auther":"author2"
}'),
('
{
	"title":"book3",
	"auther":"author3"
}'),
('
{
	"title":"book4",
	"auther":"author4"
}')

-- 3. select all JSON records

select * from books


-- 3.1 lets use selectors

-- The -> operators returns the JSON object field as a field in quotes

select book_info from books

select book_info->'title' from books

-- the operator ->> returns the JSON object field as TEXT

select book_info->>'title' from books

select 
	book_info ->> 'title' as title,
	book_info ->>'auther' as author
from 
	books

-- 4. select and filter records

select 
	book_info ->> 'title' as title,
	book_info ->> 'auther' as author
from 
	books
where book_info->>'auther' = 'author2'

-- Update JSON data

select * from books

insert into books (book_info) values
('{"title":"Book title 10","author":"author10"}')

-- 2. Lets update a record

-- will use || concetanation operator, which will;

	-- add field or
	-- replace existing field

-- let update "author10" with "Adam"

update books
set book_info = book_info || '{"auther":"Adnan"}'

where book_info->>'author'='author10'

update books
set book_info = book_info || '{"title":"The future 1.0"}'

where book_info->>'auther'='Adnan'

select * from books

-- 2. Add additional field like "Best Seller" with boolean value
update books
set book_info = book_info || '{"Best Seller":"true"}'

where book_info->>'auther'='Adnan'
returning *

-- 3. Delete best seller boolean key/value
-- to delete we will use - operator

update books
set book_info = book_info -'Best Seller'

where book_info->>'auther' = 'Adnan'
returning *

-- 4. Add a nested array data in JSON 

update books
set book_info = book_info || '{ "availability_locations" : [
	"New York",
	"New Jersey"

]}'
where book_info->>'auther' ='Adnan'
returning *

-- delete from arrays via '#-'

update books
set book_info = book_info #- '{availability_locations, 1}'
where book_info->>'auther'='Adnan'
returning *

-- Create JSON from table

-- 1. Lets output directors table into JSON format

select * from directors

select row_to_json(directors) from directors;

-- 2. How about taking only director_id, first_name, last_name, and nationality from the directors table
select row_to_json(t) from 
(
	select 
		director_id, 
		first_name,
		last_name,
		nationality
	from directors
) as t

-- use json_agg() to aggregate data

-- 1. Lets list movies for each directors

select 
*
from movies

select 
*,
(
	select json_agg(x) as all_movies from 
	(
		select
			movie_name
		from movies
		where director_id = directors.director_id  
	) as x
)
from directors

-- Build a JSON array

-- 1. Lets build a sample array with numbers

select json_build_array(1,2,3,4,5)

select json_build_array(1,2,3,4,5);
select json_build_array(1,2,3,4,5,'Hi');
 
-- key/value format
 
select json_build_object(1,2,3,4,5,'Hi');
select json_build_object('name','Adnan','email','a@b.com');
 
select json_object('{name,Adnan}','{email,a@b.com}');
 
-- Create sample table
 
create table directors_docs(
	id serial primary key,
	body jsonb
);
 
-- Insert data
 
insert into directors_docs (body)
select row_to_json(a)::jsonb from
(
	select director_id,first_name,last_name,date_of_birth,nationality,
	(
		select json_agg(x) as all_movies from
		(
			select movie_name
			from movies
			where director_id = directors.director_id
		) x	
	)
	from directors
)as a;
 
select * from directors_docs;
 
-- Populate the data with empty array elements for all_movies
 
delete from directors_docs;
 
insert into directors_docs (body)
select row_to_json(a)::jsonb from
(
	select director_id,first_name,last_name,date_of_birth,nationality,
	(
		select case count(x) when 0 then '[]' else json_agg(x) end as all_movies from
		(
			select movie_name
			from movies
			where director_id = directors.director_id
		) x	
	)
	from directors
)as a;
select * from directors_docs;
 
select jsonb_array_elements(body -> 'all_movies') from directors_docs;
 
-- Getting information from JSON documents

-- 1. Count total movies for each directors
select
	*,
	jsonb_array_length(body->'all_movies') as total_movies
from directors_docs
order by jsonb_array_length(body->'all+movies') desc


-- 2. List all the keys within each JSON row

select
	*,
	jsonb_object_keys(body)
from directors_docs

-- what is you want to see key/value style output

select
	j.key,
	j.value
from directors_docs, jsonb_each(directors_docs.body) j

-- 3. Turning JSON document to table format

select
	j.*
from directors_docs, jsonb_to_record(directors_docs.body) j (
	director_id INT,
	first_name VARCHAR(255)
)

-- The Existence Operator ?

-- 1. Find all first name equal to 'John'

select
*
from directors_docs
where body->'first_name' ? 'John'


-- 2. Fins all records with director_id = 1

select
*
from directors_docs
where body->'director_id' ? '1'

-- ? expect both the left and right side to be a text value !!!

-- The Containment Operator @>

-- 1. Find all first name equal to 'John'

select
* 
from directors_docs
where body @> '{"first_name":"John"}'

-- 2. Find all records with director_id = 1

select
* 
from directors_docs
where body @> '{"director_id":1}'

-- 3. Find the record for movie name "Toy Story"

select
*
from directors_docs
where body -> 'all_movies' @> '[{"movie_name":"Toy Story"}]'

-- Mix and Match JSON search


-- 1. First name starting with 'j'

select
*
from directors_docs
where body ->>'first_name' like 'J%'

-- 2. Find all records where director_id is greater than 2

select 
*
from directors_docs
where (body ->> 'director_id')::integer > 2

-- 3. Find all records where director_id is in 1,2,3,4,5 and 10

select
*
from directors_docs
where (body ->> 'director_id')::integer in (1,2,3,4,5,10)


-- Indexing on JSONB

select * from contacts_docs

-- 1. Lets get all records where first name is 'John'. Remember we are searching in 20,000 JSON based records

select 
* 
from contacts_docs
where body @> '{"first_name":"John"}'

-- 2. What was the total execution time to run the above query

explain analyze select
*
from contacts_docs
where body @> '{"first_name":"John"}'

--  How the data was search? was there any index on JSON document?

-- Lets crate a GIN index

create index idx_gin_contacts_docs_body on contacts_docs using GIN(body);

-- 4. Lets check query execution time after time creating GIN index

select 
	*
from contacts_docs
where body @> '{"first_name":"John"}'

create index idx_gin_contacts_docs_body on contacts_docs using gin(body);
 
select pg_size_pretty(pg_relation_size('idx_gin_contacts_docs_body'::regclass)) as index_name;
 
create index idx_gin_contacts_docs_body_cool on contacts_docs using gin(body jsonb_path_ops);

select pg_size_pretty(pg_relation_size('idx_gin_contacts_docs_body'::regclass)) as index_name


-- can we create an index on specific JSON key too?

create index idx_gin_contacts_docs_body_fname on contacts_docs using gin((body->'first_name') jsonb_path_ops)

select pg_size_pretty(pg_relation_size('idx_gin_contacts_docs_body_fname'::regclass)) as index_name
