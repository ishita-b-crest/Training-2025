-- GROUP BY functions

-- 1. Get total count of all movies group by movie language

select
	movie_lang,
	count(movie_lang)
from movies
group by movie_lang; 

-- 2. Get average movie length group by movie language

select
	movie_lang,
	avg(movie_length)
from movies
group by movie_lang
order by movie_lang

-- 3. Get the sum of total movie length per age language

select
	age_certificate,
	sum(movie_length)
from
	movies
group by age_certificate

-- 4. List minimum and maximum movie length group by movie language

select
	movie_lang,
	min(movie_length),
	max(movie_length)
from movies
group by movie_lang
order by max(movie_length)

-- 5. can we use group by without aggregate function

select 
	movie_length
from movies
group by movie_length

select
	movie_length
from movies
order by movie_length

-- 6. can we use column1, aggregate function column without specifying GROUP BY cluase?


select 
	movie_lang,
	min(movie_length),
	max(movie_length)
from
	movies
group by movie_lang
order by max(movie_length) desc

-- 7. Using more than 1 columns in  select

select
	movie_lang,
	age_certificate,
	avg(movie_length) as "Avg Movie Length"
from movies
group by movie_lang, age_certificate
order by movie_lang, 3 desc

-- 8. lets filter some records too

select
	movie_lang,
	age_certificate,
	avg(movie_length) as "Avg Movie Length"
from movies
where movie_length > 100
group by movie_lang, age_certificate

-- 10. Get avg movie length group by movie age certificate where age certificate = 10

select 
	age_certificate,
	avg(movie_length)
from movies
where age_certificate = 'PG'
group by age_certificate


-- 11. How many directors are there per each nationality

select
	nationality,
	count(*) as "Total Directors"
from directors
group by nationality
order by 2 desc;

-- 12. Get total sum movie length for each age certificate and movie langauge combination

select 
	movie_lang,
	age_certificate,
	sum(movie_length)
from movies
group by movie_lang, age_certificate

-- 1. List movies languages where sun total length of the movies is greater than 200

select
	movie_lang,
	sum(movie_length)
from movies
group by movie_lang
having sum(movie_length) > 200
order by sum(movie_length)

-- 2. List directors where their sum total movie length is greater than 200

select 
	director_id,
	sum(movie_length)
from movies
group by director_id
having sum(movie_length) > 200
order by director_id


-- Get the movie languages where their sum total movie length is greater then 200

select
	movie_lang,
	sum(movie_length)
from movies
group by movie_lang
having sum(movie_length) > 200
order by 2 desc

-- 1. Lets create our test table 'employee_test' with some data
create table employee_test	(
	employee_id serial primary key,
	employee_name varchar(100),
	department varchar(100),
	salary int
)

select * from employee_test;

insert into employee_test(employee_name, department, salary) values
('john','Finance',2500),
('Mangu','WindowsI',500),
('jon','Admin',2500),
('john',NULL,2500)

select 
	employee_name,
	department,
	salary
from employee_test
order by
	department

-- How many employees are there for each group

select 
	department,
	count(salary) as total_employees
from employee_test
group by 
	department
order by
	department

-- Lets handle the null value

select
	coalesce(department, 'NO DEPARTMENT') as department,
	count(salary) as total_employee
from employee_test
group by
	department
order by
	department





