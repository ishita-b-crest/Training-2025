-- Creating a view

-- CREATE or REPLACE VIEW view_name as query

create or replace view v_movie_quick as
select 
	movie_name,
	movie_length,
	release_date
from movies mv 

create or replace view v_movies_directors_all as
select 
mv.*
from movies mv
inner join directors d on d.director_id = mv.director_id


select * from v_movie_quick

select * from v_movies_directors_all

-- Rename a view

-- ALTER VIEW view_name RENAME TO  new_view_name

alter view v_movie_quick2 rename to v_movie_quick

-- delete a view

drop view v_movie_quick

-- using conditions/filters with views

-- 1. Create a view to list all movies released after 1947

create or replace view v_movies_after_1997 as
select 
*
from movies
where release_date >= '1997-12-31'
order by release_date desc


select 
*
from v_movies_after_1997
order by movie_lang

select 
*
from movies
where release_date >= '1997-12-31'
and movie_lang = 'English'
order by release_date desc

-- Select all movies with directors with American, and Japanese nationalities

select 
*
from movies mv
inner join directors d on d.director_id = mv.director_id
where d.nationality in ('American', 'Japanese')


-- Lets have a view for all peoples in a movies like actors and directors with first, last names

create view v_all_actors_directors as
select 
	first_name,
	last_name,
	'actors' as people_type
from actors 
union all 
select
	first_name,
	last_name,
	'directors' as people_type
from directors

select
*
from v_all_actors_directors
where first_name = 'John'
order by people_type, first_name

-- connecting multiple table with a single view

-- lets connect movies, directors, movies revenues tables with a single view

select
*
from movies mv
inner join directors d on d.director_id = mv.director_id
inner join movies_revenues r on r.movie_id = mv.movie_id

-- the above query contains multiple same column like movie_id, can we use CREATE VIEW?

create view v_movies_directors_revenues as
select
	mv.movie_id,
	mv.movie_name,
	mv.movie_length,
	mv.movie_lang,
	mv.age_certificate,
	mv.release_date,
	d.director_id,
	d.first_name,
	d.last_name,
	d.nationality,
	d.date_of_birth,
	r.revenue_id,
	r.revenues_domestic,
	r.revenues_international
from movies mv
inner join directors d on d.director_id = mv.director_id
inner join movies_revenues r on r.movie_id = mv.movie_id

-- without views
select
	mv.movie_id,
	mv.movie_name,
	mv.movie_length,
	mv.movie_lang,
	mv.age_certificate,
	mv.release_date,
	d.director_id,
	d.first_name,
	d.last_name,
	d.nationality,
	d.date_of_birth,
	r.revenue_id,
	r.revenues_domestic,
	r.revenues_international
from movies mv
inner join directors d on d.director_id = mv.director_id
inner join movies_revenues r on r.movie_id = mv.movie_id
where age_certificate = '12'

-- with views
select
*
from v_movies_directors_revenues 
where age_certificate = '12'

-- Changing views

-- can i re-arrange a cloumn to an existing view?

create view v_directors as
select
	first_name,
	last_name
from directors

select * from v_directors

-- can i remove a column from an existing view?

create view v_directors as
select
	first_name
from directors

-- can i add a column to an existing view?

create or replace view v_directors as
select
	first_name,
	last_name,
	nationality
from directors

-- you can append additional columns at the end of the column list.

-- A regular view;
-- * does not store data physically
-- * always give updated data


select * from v_directors

insert into directors (first_name) values ('test name1')

select * from directors

delete from directors where director_id = 39 

-- lets create an updated view for directors table

create or replace view vu_directors as
select
	first_name,
	last_name
from directors

-- lets add some records via a view and not from the underlying table

insert into vu_directors (first_name) values ('dir1'), ('dir2')

-- lets check the contents of directors table via view

select
*
from vu_directors

select * from directors

-- lets delete some records via a view and not from the underlying table

delete from vu_directors
where first_name = 'dir1'

delete from vu_directors
where first_name = 'dir2'

-- lets create a table for countries

create table countries(
	country_id serial primary key,
	country_code varchar(4),
	city_name varchar(100)
)


insert into countries (country_code, city_name) values
('us', 'new york'),
('us', 'new jersey'),
('uk', 'london')

select * from countries

create or replace view v_cities_us as
select
	country_id,
	country_code,
	city_name
from countries
where country_code = 'us'

-- lets view the contents of v_cities_us

select * from v_cities_us

insert into v_cities_us (country_code, city_name) values
('us','california');

select * from v_cities_us

insert into v_cities_us (country_code, city_name) values
('uk','greater manchester')

select * from countries

-- lets update our view v_cities_us using with check option

create or replace view v_cities_us as
select 
	country_id,
	country_code,
	city_name
from countries
where country_code = 'us'
with check option

insert into v_cities_us (country_code, city_name) values
('uk', 'leeds')

-- lets try the update operations on view having with check option, can we add the data

select * from v_cities_us

update v_cities_us
set country_code = 'uk'
where city_name = 'new york'

insert into v_cities_us (country_code, city_name) values
('us', 'chicago')

update v_cities_us
set country_code = 'uk'

-- using local and cascaded in with check option

create or replace view v_cities_c as
select
	country_id,
	country_code,
	city_name
from countries
where
	city_name like 'c%'

select * from v_cities_c

CREATE OR REPLACE VIEW v_cities_c_us AS
SELECT
    country_id,
    country_code,
    city_name
FROM countries
WHERE city_name LIKE 'c%' AND country_code = 'us'
WITH LOCAL CHECK OPTION;

insert into v_cities_c_us (country_code, city_name) values
('us', 'connecticut')

select * from v_cities_c_us

INSERT INTO v_cities_c_us (country_code, city_name)
VALUES ('us', 'los anglese');

select * from v_cities_c_us

select * from countries

-- what is materialized View

-- create a materialized view

create materialized view if not exists mv_directors as
select
	first_name,
	last_name
from directors
with data

select
*
from mv_directors

create materialized view if not exists mv_directors_nodata as
select
	first_name,
	last_name
from directors
with no data 

select * from mv_directors_nodata

refresh materialized view mv_directors_nodata

-- drop a materializrd view

drop materialized view mv_directors;

-- changing material view data

select * from mv_directors

insert into mv_directors (first_name) values ('dir1'), ('dir2')
refresh materialized view mv_directors

delete from mv_directors where first_time = 'dir1'


