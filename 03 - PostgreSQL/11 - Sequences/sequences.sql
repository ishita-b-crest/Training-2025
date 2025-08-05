-- Sequences

-- 1. create a sequence
-- create sequence name
create sequence if not exists test_seq

-- 2. Advance sequence and return new value

select nextval('test_seq')

--3. Return most current value of the sequence
select currval('test_seq')

-- 4. set a sequence
select setval('test_seq',100)

-- 5. set a sequence and do not skip over
select setval('test_seq',200, false)

--6. control the sequence start value
create sequence if not exists test_seq2 start with 100

-- 7. Use multiple sequence parameters to create a sequence

create sequence if not exists test_seq3
increment 50
minvalue 400
maxvalue 6000
start with 500

select nextval('test_seq3')

-- 8. Specify the data type of a sequence (SMALLINT | INT | BIGINT)
create sequence if not exists test_seq_smallint as SMALLINT
create sequence if not exists test_seq_smallint as INT

create sequence if not exists test_seq4

select nextval('test_seq_smallint')

-- 9. create a descending sequence and CYCLE | NO CYCLE

create sequence seq_asc
select nextval('seq_asc')

create sequence seq_des
increment -1
minvalue 1
maxvalue 3
start 3
cycle;

select nextval('seq_des')

-- 10. Alter a sequence 
select nextval('test_seq')	

alter sequence test_seq restart with 100

alter sequence test_seq rename to my_sequence4

-- 11. Delete/Drop a sequnce 

drop sequence test_seq3

-- 13. attaching sequence to a table

create table users(
	user_id serial primary key,
	user_name varchar(50)
)

insert into users (user_name) values ('ADNAN')

select * from users

alter sequence users_user_id_seq restart with 100

-- create a sequence and attached to a table

create table users2(
	user2_id int primary key,
	user2_name varchar(50)
)

create sequence users2_user2_id_seq
start with 100 owned by users2.user2_id


-- step 2 > Alter table column and set sequence

alter table users2
alter column user2_id set default nextval('users2_user2_id_seq')

insert into users2 (user2_name) values ('ADAM')
select * from users2

-- 12. Listing all sequence

select relname sequence_name
from pg_class
where relkind = 'S'

-- 13. Share sequence among tables

create sequence common_fruits_seq start with 100

create table apples(
	fruit_id int default nextval('common_fruits_seq') not null,
	fruit_name varchar(50)
)

create table mangoes
(
	fruit_id int default nextval('common_fruits_seq') not null,
	fruit_name varchar(50)
)

insert into apples (fruit_name) values ('big apple')

select * from apples
select * from mangoes

-- create a table with serial data type for sequence

create table contacts(
	contact_id serial primary key,
	contact_name varchar(150)
)
insert into contacts (contact_name) values ('ADNAM')

select * from contacts


drop table contacts

create sequence table_seq;


create table contacts(
	contact_id text not null default ()
);


-- file updated recently


