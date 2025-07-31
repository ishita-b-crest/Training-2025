-- What is a type conversion?
-- two type conversion: Implicit and explicit

select * from movies;

--  1. 'Type conversion' Examples

select * from movies
where movie_id = 1

-- integer = string

select * from movies
where movie_id = '1'

-- 2. what if we want to use Explicit conversion?

select * from movies
where movie_id = integer '1'


-- Using CAST for data conversions

CAST (expression AS target_data_type);

-- 1. String to integer conversion

select 
	CAST('10' AS INTEGER);

select
	CAST('10n' AS INTEGER);
	

-- 2. String to date 

select 
	cast('2020-01-01' as date)

-- 3. string to boolean

select 
	cast('true' as boolean),
	cast('false' as boolean),
	cast('T' as boolean),
	cast('F' as boolean),
	cast('0' as boolean),
	cast('1' as boolean)


-- 4. String to double

select 
	cast('14.7888' as double precision);
	
expression::type

select
	'10'::INTEGER,
	'2020-01-01'::DATE,
	'01-01-2020'::DATE

-- 5. string to timestamp

select  '2020-02-20 10:30:25.456'::TIMESTAMP;

-- with timezone
select '20202-02-20 10:23:12.432'::timestamptz;

--6. interval

select
	'10 minute'::interval,
	'4 hour'::interval,
	'1 day'::interval,
	'2 week'::interval,
	'5 month'::interval
	
-- IMPLICIT TO EXPLICIT CONVERSIONS

-- 1. Using integere and factorial

SELECT factorial(20);
SELECT factorial(20) as result;


select factorial(cast(20 as bigint)) as "result";

-- 2. Round with numeric

select round(10,4) as result;

select round(cast(10 as numeric), 4) as "result";


-- 3. CAST with text

select substr('123456', 2) as "result"


select 
	substr('123456', 2) as "Implicit",
	substr(cast('123456' as text),2) as "Explicit"


-- TABLE DATA CONVERSION

-- 	1. Lets create a table called 'ratings' with initial data as character

create table ratings(
	rating_id serial primary key,
	rating varchar(1) not null
);

--2. let's insert some data

insert into ratings (rating) values
('A'),
('B'),
('C'),
('D');

select * from ratings;

-- 3. now rating want in integer

insert into ratings (rating) values
(1),
(2),
(3),
(4);

select * from ratings;

-- 4. now, we have to convert all values in the rating column into integers

select
	rating_id,
	case
		when rating~E'^\\d+$' then 
			cast (rating as integer)
		else
			0
		end as rating
from 
	ratings
	
-- convert integer into string

select
	to_char(
		100870,
		'9,9999'
	); 

-- let's view movie  release  data in DD-MM-YYYY format

select
	release_date,
	TO_CHAR(release_date, 'DD-MM-YYYY'),
	TO_CHAR(release_date, 'Dy, MM, YYYY')
from movies;

-- convertig timestamp literal to a string

select 
	TO_CHAR(
		timestaMp '2020-01-01 10:30:45',
		'HH24:MI:SS'
	);

-- Adding currency symbol to say movie revenues
select * from movies_revenues

select 
	movie_id,
	revenues_domestic,
	TO_CHAR(revenues_domestic, '$99999D99')
from movies_revenues;

-- TO_NUMBER

-- convert a string to a number

select TO_NUMBER(
	'1456.76',
	'9999.'
);

select TO_NUMBER(
	'10,654.78-',
	'99G999D99S'
);

-- formating

select to_number(
	'$1,423.65',
	'L9G999D99'
);

select to_number(
	'1,234,546.89',
	'9G999g999'
)

select to_number(
	'1,234,432.88',
	'9G999g999D99'
);

-- converting say money number

select
	to_number(
		'1,987,288.87',
		'L9G999g999.99'
	);


-- string to date

select TO_DATE(
	'2020/10/22',
	'YYYY/MM/DD'
)

select TO_DATE(
	'022199',
	'MMDDYY'
);

SELECT TO_DATE(
	'March 07, 1999',
	'Month DD, YYYY'
);

-- Error Handling

select TO_DATE(
	'2020/10/30',
	'YYYY/MM/DD'
);


-- To timestamp

select to_timestamp(
	'2020-10-28 10:30:23',
	'YYYY-MM-DD HH:MI:SS'
)

-- It skip spaces

select
	to_timestamp('2020     may', 'YYYY MON');

-- minimal erro is checking!!

select 
	to_timestamp('2020-01-01 22:8:00', 'YYYY-MM-DD HH24:MI:SS');


 