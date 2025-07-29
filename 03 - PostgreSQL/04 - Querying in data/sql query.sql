-- 1. Get all records from movies table

select * from movies;

--2. Get all records from actors table

select * from actors;

-- SELECTING SPECIFIC COLUMNS/FIELDS FROM A TABLE

-- 1. Get first_name from actors table
select first_name from actors;

-- 2. Get first_name, last_name from actors table
select first_name, last_name from actors;

--3. Get movie_name and movie_lang from movies table
select movie_name, movie_lang from movies;


-- ADDING ALIASES TO COLUMNS IN TABLE

-- Column aliases can be used for derived columns.
-- Using aliases is always helpful if you want to make your query to be more presentable and readable!

-- 1. Get first_name, last_name from actors table

select first_name, last_name from actors;

-- 2. use of || operator for concatonate the column
select first_name || last_name from actors;


-- 3. Now lets make an alias from previous expression
select first_name ||' '|| last_name as Full_name
from actors;

-- 4. Used Expressions to get output without using a table column?  
-- yes

select 2 * 20;

-- USING ORDER BY TO SORT RECORDS


SELECT 
	*
FROM movies
ORDER BY
	RELEASE_DATE ASC;


-- 2. Sort all movies records by their release_date in descending order

SELECT 
	*
FROM movies
ORDER BY
	RELEASE_DATE DESC;

-- 3. Sort based on multiple column

select 
	* 
from movies
order by 
	release_date desc,
	movie_name asc;

-- 4. Make an alias for last_name as surname

select 
	first_name,
	last_name as surname
from actors;

-- 5. Sort Rows by last_name

select 
	first_name, last_name as surname 
from actors
order by last_name; 

-- USE ORDER BY TO SORT ROWS BY EXPRESSIONS

-- 1. Lets calculate the length of the actor name with LENGTH function

select 
	first_name,
	length(first_name)
from actors

--2. Lets sort rows by length of the actor name in descending order

select 
	first_name,
	length(first_name) as len 
from actors
order by len

--How to use column name or column number in ORDER BY clause

-- 1. Let view all records of actors

select * from actors;

-- 2. sort name in asc and DOB in decs

select * from actors
order by 
	first_name asc,
	date_of_birth desc

-- 3.column number for sorting number

select * from actors
order by 
	2 asc,
	4 desc

-- USING ORDER BY WITH NULL VALUES




