-- 

-- 1. Get all English movies

SELECT * FROM movies;

select * from movies
where 
	movie_lang = 'English';


-- 2. get all japanese language movies

select 
*
from movies
where
	movie_lang = 'Japanese';

-- USING MULTIPLE OPERATORS

-- 1. get all the english movies and age certificate to 18

select 	 
	*
from movies
where
	movie_lang = 'English'
	AND age_certificate = '18';

-- USING LOGICAL OR OPERATOR

-- Get all English or Chinese movies

select 
	* 
from movies
where 
	movie_lang = 'English' 
	or movie_lang = 'Japanese'
order by movie_lang;


-- get all english movie and director_id == 8

select 
	* 
from movies
where 
	movie_lang = 'English'
	and director_id = '8'


select 
*
from 
movies
where 
	(movie_lang = 'English'
	or movie_lang = 'Chinese')
	and age_certificate = '12'
order by movie_lang

-- Can we use where before from
--no

-- can we use where after order by
-- No

-- Order of execution with AND, OR operators

-- Can we use column aliases with where? --- NO
select 
* 
from 
actors
where 
	last_name = 'Allen';


select 
	* 
from movies
where 
	movie_lang = 'English'
order by
	movie_length desc


-- 1. Get all movies where movie length is greater than 100 

select 
	* 
from movies
where 
	movie_length > 150
order by movie_length

-- 2. Get all movies where movie length is greater and equal to 100
select 
	* 
from movies
where 
	movie_length >= 100
order by movie_length

-- 3. Get all movies where movie length is less than 100

select 
	* 
from movies
where 
	movie_length < 100
order by movie_length

-- 4. Get all movies where movie length is less than and equal to 100

select 
	* 
from movies
where 
	movie_length <= 100
order by movie_length


-- Get all movies where release date is greater then 2000

select * from movies
order by release_date asc

select
	*
from movies
where 
	release_date > '1999-12-31'


-- get all the movies which is greater than english language

select 
*
from movies
where 
	movie_lang > 'English'

-- get all the movies which is lesser than english language

select 
*
from movies
where 
	movie_lang < 'English'
order by movie_lang

-- get all movies which not in english language

select 
* 
from movies
where 
	movie_lang <> 'English'

-- can we omit quotes when using numerical values

select 
* 
from movies
where 
	movie_length = 100


-- 1. get the top 5 biggest movies by movie length

select 
*
from movies
order by movie_length
limit 5;

-- 2. get the top 5 oldest american directors


select 
	*
from directors
where 
	nationality = 'American'
order by date_of_birth asc
limit 5

-- 3. get top youngest female actors

select 
*
from 
actors
where
	gender = 'F'
order by date_of_birth desc
limit 10

-- 4. top 10 domestic profitale movies

select
*
from movies_revenues
order by revenues_domestic desc
limit 5

-- 5. List 5 films starting from the fourth one ordered by movie_id

select 
*
from movies
order by movie_id
limit 5 offset 4

-- 6. List all top 5 movies after the top 5 highest domestic profits movies

select 
*
from 
movies_revenues
order by revenues_domestic desc nulls last
limit 5 offset 5

-- using limit to limit output records

-- 1. get the top 5 biggest movies by movie length

select
* 
from movies
order by movie_length desc
limit 5


-- OFFSET

-- 1. get first row of movies table

select 
* 
from movies
order by movie_id
limit 1

-- 2. Get the top 5 biggest movies by movie length

select 
* 
from movies
order by movie_length desc
limit 5

-- 3. Get the top 5 oldest american directors

select
*
from directors
order by date_of_birth asc
fetch first 5 row only

-- 4. Get the top  10 youngest femate actors

select 
*
from actors
where
	gender = 'F'
order by date_of_birth desc
fetch first 10 row only

-- 5. Get first 5 movies from the 5th record onward by long movie length

select 
*
from movies
order by movie_length desc
fetch first 5 row only
offset 5

-- USING IN AND NOT IN

-- 1. get all movies for english, chinese and japanese languages


select 
* 
from movies
where 
	movie_lang in ('English', 'Chinese', 'Japanese')
order by movie_lang

-- 2. get all movies where age 	certification is 13 and PG type

select 
*
from movies
where
	age_certificate in ('12', 'PG')
order by age_certificate asc

-- 3. Get all movies where director id is not 13 or 19

 select 
 *
 from movies
 where 
 	director_id not in (13, 10)
order by director_id

-- 4. Get all actors where actor_id is not 1,2,3,4

select
*
from actors
where
	actor_id not in (1,2,3,4)
order by actor_id


-- USING BETWEEN AND NOT BETWEEN

-- 1. GET ALL ACTORS WHERE BIRTH_DATE BETWEEN 1991 AND 1995

SELECT 
*
FROM actors
WHERE
	date_of_birth BETWEEN '1991-01-01' AND '1995-12-31'
ORDER BY date_of_birth


-- 2. get all movies relesed between 1998 and 2002

select 
*
from movies
where release_date between '1998-01-01' and '2002-12-31'
order by release_date


-- 3.  get all movies where domestic revenues are between 100 and 300

select 
* 
from movies_revenues
where
	revenues_domestic between 100 and 300
order by revenues_domestic 

-- 4. get all english movie where movie length is between 100 and 200

select 
* 
from
movies
where 
	movie_length not between 100 and 200
order by movie_length


select 
* 
from movies
where 
	movie_length >= 100 and movie_length <= 200
order by movie_length











	