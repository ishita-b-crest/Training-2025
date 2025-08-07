-- 1. Lets use UNION on left_products and right_products tables

select
	product_id, product_name
from left_products
union 
select
	product_id, product_name
from right_products

-- 2. Do we get duplicates records when we used UNION?

insert into right_products (product_id, product_name) values ('10', 'Pen')

-- 3. what if we need duplicate records?

select
	product_id, product_name
from left_products
union all 
select
	product_id, product_name
from right_products

-- 4. Lets combine directors and actors tables


select
	first_name,
	last_name
from directors
union 
select
	first_name,
	last_name
from actors

--5. Select all directors and actors name whose name start with 'A'
 
select
	first_name,
	last_name,
	'actors' AS "tablename"
from actors
where first_name LIKE 'A%'
union
select 
	first_name,
	last_name,
	'directors' AS "tablname"
from directors
where first_name LIKE 'A%'
order by first_name;


--6. Can we combine different number of column from each queries
 
select
	first_name,
	last_name,
	date_of_birth,
	'directors' As "tablename"
from directors
where nationality IN ('American', 'Chinese', 'Japanese')
union
select
	first_name,
	last_name,
	date_of_birth,
	'actors' As "tablename"
from actors
where gender = 'F'



--7. Create sample table
 
create table table2(

	col1 int,

	col2 int

);
 
--8. Use union with null
 
select col1,col2 from table2

union

select null as col1,col2 from table2;
 
--9. Drop sample table
 
drop table table2;
 
--10. Use intersect
 
select product_id,product_name

from left_product

intersect

select product_id,product_name

from right_product;
 
--11. Use intersect on actors and directors table
 
select first_name,last_name

from actors

intersect

select first_name,last_name

from directors

order by first_name asc;
 
--12. Use except
 
select product_id,product_name

from left_product

except

select product_id,product_name

from right_product;
 
--13. Use except on actors and directors table
 
select first_name,last_name

from actors

except

select first_name,last_name

from directors

order by first_name asc;
 





