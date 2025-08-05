
-- Count results using COUNT

-- 1. Count all records

select count(*) from movies


-- 2. count all records of a specific column

select count(movie_length) from movies;

-- 3. Using COUNT with DISTINCT

select
	count(distinct(movie_lang))
from movies

-- 4. Count all english movies

select 
	count(*)
from movies
where 
	movie_lang = 'English'

-- SUM with SUM functions

-- 1. Lets look at all movie revenue records

select * from movies_revenues

-- 2. Get total domestic revenues for all events

select 
	sum(revenues_domestic)
from movies_revenues

-- 3. Get the total domestic revenues for all movies where domestic revenue is greater than 200

select 
	sum(revenues_domestic)
from movies_revenues
where 
	revenues_domestic > 200

-- 4. find the total movie length of all english languge movies

select * from movies


select 
	sum(movie_length)
from movies
where movie_lang = 'English'

-- 5. Can I sum all movies name?

select 
	sum(distinct revenues_domestic)
from movies_revenues

-- 6. with distinct

select * from movies_revenues
order by revenues_domestic

-- 1. what is the longtest length movie in movie table

select movie_length
from movies
order by movie_length desc;

select 
	max(movie_length)
from movies

-- 2. What is the shortest length movie in movie table

select 
	movie_length
from movies
order by movie_length asc


select 
	min(movie_length)
from movies

-- 3. What is the longtest length movie in movies table within all english based language

select 
	max(movie_length)
from 
	movies
where 
	movie_lang = 'English'

-- 4. What is latest release movie in english language

select 
	max(release_date)
from movies
where movie_lang = 'English'


-- 5. What was first movie release in chinese language
select 	
	max(release_date)
from movies
where movie_lang = 'Chinese'

-- 6. can we use MIN and MAX for text data types

select max(movie_name) from movies;


-- Using GREATEST and LEAST functions

select greatest(200,10,20)

select least (10,20,5)

-- 1. Find the greatest and least revenue per each movie

select
	movie_id,
	revenues_domestic,
	revenues_international,
	greatest(revenues_domestic, revenues_international) as "Greatest",
	least(revenues_domestic, revenues_international) as "Least"
from movies_revenues;

-- AVG functions

-- 1. get the average movie_length fromm movies data

select 
	avg(movie_length)
from movies

-- 2. get te average movie_length for all english based movies

select
	avg(movie_length)
from movies
where
	movie_lang = 'English'

-- 3. Using avg and sum functions together

select
	avg(movie_length),
	sum(movie_length)
from 
	movies
where movie_lang = 'English'

-- 1. Lets practice above

select 2+10 as addition
select 2 -10 as substration
select 11/2::numeric(10,2) as divine

select 2.5*2.5

select 10%3

select
	movie_id,
	revenues_domestic,
	revenues_international,
	(revenues_domestic + revenues_international) as "Total revenue"
from movies_revenues;


select
	movie_id,
	revenues_domestic,
	revenues_international,
	(revenues_domestic + revenues_international) as "Total revenue"
from movies_revenues
order by 4 desc nulls last


