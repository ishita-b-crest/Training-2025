-- 1. Let combine 'movies' and 'directors' tables

select
*
from movies
order by director_id

select 
*
from directors

select
	movies.movie_id,
	movies.movie_name,
	movies.director_id,
	directors.first_name
from movies
inner join directors
on movies.director_id = directors.director_id


-- lets say the same column name is column1
select
	table1.column1,
	table2.column2
from table1
inner join table2 using (column1)

-- 1. Lets connect 'mpvies' and directors table with using keyword

select
*
from movies
inner join directors using (director_id)

select
*
from movies
inner join directors on movies.director_id = directors.director_id

-- 2. can we connect movies and movie_revenues?
select 
*
from movies
inner join movies_revenues using (movie_id)

--3. can we connect more than two keyboard

select
* 
from movies
inner join directors using (director_id)
inner join movies_revenues using (movie_id)


-- 4. select movie_name, director name, domestic revenues for all japanese movies

select
	mv.movie_name,
	d.first_name,
	d.last_name,
	r.revenueS_domestic
from movies mv
inner join directors d on mv.director_id = d.director_id
inner join movies_revenues r on mv.movie_id = r.movie_id
where
	mv.movie_lang = 'Japanese'

-- select movie_name, director_name for all english, chinese and japanese  movies where domestic revenue is greater
-- than 200

select
	mv.movie_name,
	d.director_id,
	d.first_name
	d.last_name
from movies mv
inner join directors d on mv.director_id = d.director_id
inner join movies_revenues r on mv.movie_id = r.movie_id
where
	mv.movie_lang in ('English','Chinese','Japanese')
	and r.revenues_domestic  > 100

-- 6. movie name, director name, movie language, total revenues for all top 5 movies

select 
	m.movie_name,
	d.director_id,
	d.first_name,
	m.movie_lang,
	r.revenues_domestic,
	r.revenues_international,
	(r.revenues_domestic + r.revenues_international) as "Total Revenues"
from movies m
inner join  directors d on m.director_id = d.director_id
inner join movies_revenues r on m.movie_id = r.movie_id
order by 6 desc nulls last
limit 6


-- 7. what were top  10 most profitable movies between year 2005 and 2008 print movie_name, director_name, movie_name,
-- director_name, movie_language

select
	m.movie_name,
	m.movie_lang,
	d.first_name,
	d.last_name,
	r.revenues_domestic,
	r.revenues_international,
	(r.revenues_domestic + r.revenues_international) as "Total Revenue"

from
	movies m
inner join directors d on m.director_id = d.director_id
inner join movies_revenues r on m.movie_id = r.movie_id
where
	m.release_date between '2005-01-01' and '2008-12-31'
order by 6 desc nulls last
limit 10

-- 1. lets create some sample tables for our join exercise
create table left_products (
	product_id serial primary key,
	product_name varchar(100)
)

create table right_products(
	product_id serial primary key,
	product_name varchar(100)
)

insert into left_products (product_id, product_name) values
(1, 'computers'),
(2, 'laptops'),
(3, 'Monitors'),
(4, 'Mics')

insert into right_products (product_id, product_name) values
(1, 'computers'),
(2, 'laptops'),
(3, 'Monitors'),
(4, 'Mics'),
(5, 'Pens'),
(6, 'Pencils')

select * from left_products

select * from right_products

-- 3. left join the table with left join

-- common column is product_id

select
* 
from left_products
left join right_products on left_products.product_id = right_products.product_id

 -- 4. using movies table for joins

select
	d.first_name,
	d.last_name,

	mv.movie_name
from directors d
left join movies mv on mv.director_id = d.director_id 

-- 5. lets reverse the tables directors and movies

select 
	d.first_name,
	d.last_name,
	mv.movie_name
from 
	movies mv
left join directors d on d.director_id = mv.director_id

-- 6. can we add a where conditions, say get list of english and chinese movies only

select
	d.first_name,
	d.last_name,
	mv.movie_name,
	mv.movie_lang
from directors d
left join movies mv on mv.director_id = d.director_id
where 
	mv.movie_lang in ('English', 'Chinese')

-- 7. Count all movie for each directors

select
	d.first_name,
	d.last_name,
	mv.movie_name,
	mv.movie_lang
from directors d
left join movies mv on mv.director_id 

-- 7. count all movies for each directors

select 
	d.first_name,
	d.last_name,
	mv.movie_name
from directors d
left join movies mv on mv.director_id = d.director_id
group by d.first_name, d.last_name, mv.movie_name


-- 8. get all movies with age certificate for all directors where nationalities are american, chinese and japanese

select
	d.first_name,
	d.last_name
from directors d
left join movies mv on d.director_id = mv.director_id
where d.nationality in ('American', 'Chinese', 'Japanese')


-- we need total 38 records.
select
	d.first_name,
	d.last_name,
	sum(r.revenues_domestic + r.revenues_international) as "Total revenues"
from directors d
left join movies mv on mv.director_id = d.director_id
left join movies_revenues r on r.movie_id = mv.movie_id
group by d.first_name, d.last_name
having sum(r.revenues_domestic + r.revenues_international) > 0
order by 3 desc nulls last


-- RIGHT JOINS

-- 1. Lets join left products and right products using right join

select
*
from left_products
right join right_products on left_products.product_id  = right_products.product_id


-- 2. Lets run RIGHT JOINS on movies databases
-- List all movies with directors first and last names and movie name

select
	d.first_name,
	d.last_name,
	mv.movie_name
from directors d
right join movies mv on mv.director_id = d.director_id

-- 3. 	Lets reverse the tables directors and movies

select
	d.first_name,
	d.last_name,
	mv.movie_name
from movies mv
right join directors d on mv.director_id = d.director_id

-- 4. Can we add a where conditions, get list of english and chinese movies only

select 
	d.first_name,
	d.last_name,
	mv.movie_name,
	mv.movie_lang
from directors d
right join movies mv on mv.director_id = d.director_id
where
	mv.movie_lang in ('English', 'Chinese')


-- 5. Count all movies for each directors

select
	d.first_name || ' ' || d.last_name as "Full Name",
	count(*) as "Total movies"
from directors d
right join movies mv on mv.director_id = d.director_id
group by d.first_name, d.last_name
order by count(*) desc

-- Get all the total revenues done by each films for each directors

select
	d.first_name || ' ' || d.last_name as "Full Name",
	sum(r.revenues_domestic + r.revenues_international) as "total_revenues"
from directors d
right join movies mv on mv.director_id = d.director_id
right join movies_revenues r on r.movie_id = mv.movie_id
group by d.first_name || ' ' || d.last_name
having sum(r.revenues_domestic + r.revenues_international) > 100
order by sum(r.revenues_domestic + r.revenues_international) desc

-- FULL JOINS

-- 1. Lets join left_products and right_products via full joins

select
*
from left_products
full join right_products on left_products.product_id = right_products.product_id


-- 2. Lets run RIGHT JOINS on movies databases
-- List all movies with directors first and last names and movie name

select
	d.first_name,
	d.last_name,
	mv.movie_name
from directors d
full join movies mv on mv.director_id = d.director_id


-- 3. 	Lets reverse the tables directors and movies

select
	d.first_name,
	d.last_name,
	mv.movie_name
from movies mv
full join directors d on mv.director_id = d.director_id

-- 4. Can we add a where conditions, get list of english and chinese movies only

select 
	d.first_name,
	d.last_name,
	mv.movie_name,
	mv.movie_lang
from directors d
full join movies mv on mv.director_id = d.director_id
where
	mv.movie_lang in ('English', 'Chinese')

-- 5. Count all movies for each directors

select
	d.first_name || ' ' || d.last_name as "Full Name",
	count(*) as "Total movies"
from directors d
full join movies mv on mv.director_id = d.director_id
group by d.first_name, d.last_name
order by count(*) desc


-- 6. Get all the total revenues done by each films for each directors

select
	d.first_name || ' ' || d.last_name as "Full Name",
	sum(r.revenues_domestic + r.revenues_international) as "total_revenues"
from directors d
full join movies mv on mv.director_id = d.director_id
full join movies_revenues r on r.movie_id = mv.movie_id
group by d.first_name || ' ' || d.last_name
having sum(r.revenues_domestic + r.revenues_international) > 100
order by sum(r.revenues_domestic + r.revenues_international) desc

-- Joining multiple tables via JOINS

-- 1. Lets join movies, directiors and movies revenues tables

select 
*
from movies mv
join directors d on d.director_id = mv.director_id
join movies_revenues r on r.movie_id = mv.movie_id

-- 2. Do the order of the tables joining matters?

select
*
from movies mv
join movies_revenues r on r.movie_id = mv.movie_id
join directors d on d.director_id = mv.director_id

-- 3. Lets join movies actors, directos, movies revenues together

select 
*
from actors ac
join movies_actors ma on ma.actor_id = ac.actor_id
join movies mv on mv.movie_id = ma.movie_id
join directors d on d.director_id = mv.director_id
join movies_revenues r on r.movie_id = mv.movie_id

-- SELF JOINS

-- 	self = inner

-- CROSS JOINS

-- 1. LETS CROSS JOIN left_products and right_products 

select
* 
from left_products
cross join right_products

-- Does the order of the tables matters?

select
*
from right_products
cross join left_products

-- 2. Do we have an equivalent of cross join?

select
*
from left_products, right_products

--## using inner join

select *
from left_products
inner join right_products on true;

select * from actors

select
*
from actors
cross join directors

-- NATURAL JOINS

select
*
from left_products
natural left join right_products

-- 2. Left natural join movies and directors tables
select
*
from movies
natural inner join directors
