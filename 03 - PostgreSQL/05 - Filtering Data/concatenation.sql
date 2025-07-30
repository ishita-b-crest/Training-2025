-- LIKE AND ILIKE OPERATIONS
-- Operators to query data using 'Pattern matchings'
-- Return true or false

-- 	% 	(%) matches any sequence of zero or more characters
--  _   (_) matches any single character


-- 1. Full character search

select 'hello' like 'hello';

-- 2. Partial character search using '%'

select 'hello' like 'h%';

select 'hello' like '%e%'

select 'hello' like 'hell%'

select 'hello' like '%ll'

-- 3. single character search using '_'

select 'hello' like '_ello';

-- 4. checking occurance of search using '_'

select 'hello' like '__ll_'


-- 5. using % and _ together

select 'hello' like '%ll_'

-- 6. Get all actors names where first name starting with 'A'

select 
* 
from actors
where 
	first_name like 'A%'
order by first_name

-- 7. get all actors names where last name ending with 'a'


select
*
from actors
where
	last_name like '%a'
order by first_name


-- 8. get all actors names where first name with 5 characters only

select
*
from actors
where
	first_name like '_____'
order by first_name


-- 9. get all actors name where first name contains 'l' on the second place

select
*
from actors
where
	first_name like '_l%'
order by first_name

-- 10. Is like is case-sensitive?

-- get record from actors  where actor name is 'Tim'

select 
* 
from actors
where
	first_name like '%Tim%'
	
-- like is case sensitive

select 
* 
from actors
where
	first_name like '%tim%'

-- get record from actors where actor is 'Tim'

select
*
from actors
where
	first_name ilike '%Tim%'


-- USING IS NULL AND IS NOT NULL KEYWORS

-- 1. Find list of actors with missing birth date

select 
* 
from actors
where
	date_of_birth is null
order by date_of_birth;

-- 2. find list of actors with missing birth date or missing first name

select
*
from actors
order by first_name


select 
* 
from actors
where 
	date_of_birth is null
	or first_name is null


-- 3. get list of movies where domestic revenues is NULL

select 
*
from  movies_revenues
where 
	revenues_domestic is null
order by revenues_domestic


-- 4. get list of movies where either domestic or international revenues is NULL

select 
*
from movies_revenues
where 
	revenues_domestic is null
	and revenues_international is null

-- 5. get list of movies where either domestic and international revenues are NULL

select
*
from movies_revenues
where
	revenues_domestic is not null

-- 	CONCATENATE TECHNIQUE

-- 1. LETS CONCATENATE THE STRING HELLO AND WORLD

select 'Hello'  || 'world' as new_string;


select 'Hello' || ' ' || 'world' as new_string;


-- 2. lets combine actor first_name and last name as fi\ull name

select * from actors

--3. lets add separator between first name and last name

select concat(first_name, ' ', last_name) as "Actor name"
from actors
order by first_name

-- 4. lets print first name, last name and date of birth of all actors separator by comma
select 
	concat_ws(', ',first_name, last_name, date_of_birth)
from actors
order by first_name

-- when concatenation, hoe null values are handled

-- using ||

select 'hello' || 'Null' || 'world';


-- using concat

select 
	revenues_domestic, 
	revenues_international,
	concat(revenues_domestic,' | ', revenues_international) as profits
from movies_revenues	


-- using concat_ws

select
	revenues_domestic, 
	revenues_international,
	concat_ws('|', revenues_domestic, revenues_international) as profits
from movies_revenues
