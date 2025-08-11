-- Using Array Functions

select
	int4range(1,6) 			                          as "Default [( = closed - opened",
	numrange(1.4325, 6.2986, '[]')                    as "[] closed - closed",
	daterange('20100101', '20201220', '()')           as "Dates () = opened - opened",
	tsrange(localtimestamp, localtimestamp + interval '8 Days', '(]') as "opened - closed"


-- constructing arrays

-- notice the curley brackets {} at beginning and end of the array
select
	array[1,2,3] as "INT arrays",
	array[2.11225::float] as "floating numbers with putting explicit typing",
	array[current_date, current_date + 5]

-- comparision operators

select
	array[1,2,3,4] = array[1,2,3,4] as "Equality",
	array[1,2,3,4] = array[2,3,4] as "Equality",
	array[1,2,3,4] <> array[1,2,3,4] as "Not Equality to",
	array[1,2,3,4] < array[2,3,4,5] as "Less than",
	array[1,2,3,4] <= array[2,3,4,5] as "Less than and equal to",
	array[1,2,3,4] > array[2,3,4,5] as "Greater than",
	array[1,2,3,4] >= array[2,3,4,5] as "Greater than and equal to";


-- inclusion operators

select
	array[1,2,3,4] @> array[2,3,4] as "Contains",
	array['a','b'] <@ array['a','b'] as "Contaned by",
	array[1,2,3,4] && array[2,3,4] as "Is overlap";

select
	int4range(1,4) @> int4range(2,3) as "Contains",
	daterange(current_date, current_date + 30) @> current_date + 15 as "Contains value",
	numrange(1.6, 5.2) && numrange(0, 4)

-- with || concatination

select
	array[1,2,4] || array[3,5,6] as "Combine array"

select
	array_cat(array[1,2,3], array[4,5,6]) as "Concat array"

-- add an item to an array

select
	4 || array[1,2,3] ass "Adding to an array"

select
	array_prepend(4, array[1,2,3]) as "Using preprend"

select
	array[1,2,3] || 4 as "Adding to an array"

select
	array_append(array[1,2,3],4) as "Using Append"


-- Array metadata functions

select
	array_ndims(array[[1],[2]]) as "Dimenstions"

select
	array_ndims(array[[1,2,3],[4,5,6]])

-- array_dim

select 
	array_dims(array[[1],[2]])

-- array length

select
	array_lower(array[1,2,3,4],1)

select
	array_lower(array[1,4], 1)

-- array_lower

select
	array_lower(array[1,2,3,4],1)

-- array_uper

select
	array_upper(array[1,2,2,4],1)

-- cardinality 

select
	cardinality(array[[1],[2],[3],[4]]),
	cardinality(array[[1],[2],[3],[4],[5]])


-- Array Search functions

select
	array_position(array['Jan','Feb','March','April'],'Feb')

-- Array CAT

select
	array_cat(array[1,2,3], array[4])
-- Array Append

select
	array_prepend(4, array[1,2,3])

-- array remove

select
	array_remove(array[1,2,3,4], 4)

-- array replace

select
	array_replace(array[1,2,3,4],2,16)


-- Formatting and converting arrays

select 
	string_to_array('1,2,3,4',',')

select 
	string_to_array('1,2,3,4,ABC',',','ABC')

-- Setting an empty value to null

select
	string_to_array('1,2,3,4,,6',',','')

-- ARRAY TO STRING

-- Array to a string

select
	array_to_string(array[1,2,3,4],'|')

select 
	array_to_string(array[1,2,NULL,4],'|')

-- array to string with NULL values

select
	array_to_string(array[1,2,NULL,4],'|')

-- Using Arrays in Tables

-- 1. Lets create a table with array data

create table teachers(
	teacher_id serial primary key,
	name varchar (150),
	phones text []
);

-- you can also use ARRAY as keywords to create a array data types

create table teachers1(
	teacher_id serial primary key,
	name varchar(150),
	phones text array
);

-- 2. Insert data into arrays

insert into teachers(name, phones) values
(
	'crest', array['9089786756','9887766554']
)

insert into teachers(name, phones) values
('Lina', '{"9877665542"}'),
('Jeff','{"7867564536","8767567687"}')


-- Query array data

-- find all phones records

select 
	name,
	phones
from 
	teachers

-- How to access array elements?

select
	name,
	phones[2]
from 
	teachers


-- can we use filter condition?

select
*
from
	teachers
where 
	phones [2] = '9887766554'


-- modify array content

select * from teachers

update teachers
set phones[2] = '9877665549'
where teacher_id = 1;

select * from teachers where teacher_id = 1


-- Dimentions are ignored by postgresql

create table teachers2(
	teacher_id serial primary key,
	name varchar(150),
	phones text array[1]
);

insert into teachers2(name, phones) values
(
	'crest', array['9089786756','9887766554']
)

-- display all array elements

select
	teacher_id,
	name,
	unnest(phones)
from
	teachers

-- Use order by for phone numbers
 
select teacher_id,name,unnest(phones) 
from teachers
order by 3;
 
-- Create table with multi dimension array
 
create table students(
	student_id serial primary key,
	student_name varchar(100),
	student_grade integer[][]
);
 
insert into students(student_name,student_grade) values ('s1','{90,2020}');
 
select * from students;
 
insert into students(student_name,student_grade) values 
('s2','{80,2020}'),
('s3','{70,2019}'),
('s4','{60,2019}');
 
-- Search in multi dimension
 
select student_grade[1] from students;
select student_grade[2] from students;
 
-- Search all students with grade year 2020
 
select * from students where student_grade @> '{2020}';
 
-- Search all students with gread greater than 70
 
select * from students where student_grade[1] > 70




















