
-- Ex 1: 'addr' domain  with VARCHAR(100)

create domain addr VARCHAR(100) not null;

create table locations(
	address addr
);


select * from locations;
insert into locations (address) values ('123 London');

-- Ex 2: 'positive_numeric' domain with a positive NUMERIC 

create domain positive_numeric int not null check (value >0);

create table sample(
	sample_id serial primary key,
	value_num positive_numeric
);

insert into sample (value_num) values (10);

select * from sample;


-- Ex 3: 'us_pastel_code' domain to check for valid us postal code fromate

create domain us_pastel_code as text
check (
	value ~'^\d{5}$'
	or value ~'^\D{5}-\d{4}$'
)

create table addresses
(
	address_id serial primary key,
	postal_code us_pastel_code
)

insert into addresses (postal_code) values('10000')


select * from addresses

-- Ex 4: 'proper_mail' domain to check  for a valid email address

create domain proper_email VARCHAR(150)
check (value ~* '^[A-Za-z0-9,_%-]+@[A-Za-z0-9,_%-]+[.][A-Za-z]+$')

create table clients_names
(
	client_name_id serial primary key,
	email proper_email
)

insert into clients_names (email) values ('a@b.com');

select * from clients_names
