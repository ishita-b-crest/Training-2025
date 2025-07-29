-- INSERT DATA INTO A TABLE

-- 1. Create a test table called 'customers' with CREATE TABLE	


CREATE TABLE customers(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(150),
	age INT
);

-- 2. Let view the table data with SELECT

SELECT * FROM CUSTOMERS;

--3. Insert Data into table

INSERT INTO customers (first_name, last_name, email, age)
VALUES ('Adam', 'Waheed','test@test.com', 12);

SELECT * FROM CUSTOMERS;

-- 4. Insert data with multiple records into table

INSERT INTO customers(first_name, last_name)
VALUES
('ADNAN', 'WAHEED'),
('JOHN', 'ADAMS'),
('LIIN','ABE');

SELECT * FROM customers;

INSERT INTO customers(first_name)
VALUES
('Bill''0 Sullivan');


-- Fisrt see the default behaviour when adding a record into a table
INSERT INTO customers(first_name)
VALUES ('ADAM');

-- After the insert, lets return all rows
INSERT INTO customers(first_name)
VALUES ('JOSH') RETURNING *;

-- After the insert, return a single column value
INSERT INTO customers(first_name)
VALUES ('JOSH') RETURNING first_name;


-- Update data in a table

SELECT * FROM customers;

-- Update single column
UPDATE customers
SET email = 'a@b.com'
WHERE customer_id = 1


-- Update multiple columns

UPDATE customers
SET
email = 'a4@test.com',
age = 22
WHERE customer_id = 1

-- Use RETURNING to get updated row

SELECT * FROM customers;

  
UPDATE customers
SET
email = 'a4@test.com',
age = 22
WHERE customer_id = 3
RETURNING *;

-- UPDATE ALL RECORDS IN A TABLE

-- Update with no WHERE clause

SELECT * FROM customers;

UPDATE customers
SET is_enable = 'Y'


-- DELETE RECORDS FROM A TABLE

--To delete records based on a condition

DELETE FROM customers
WHERE customer_id = 8


DELETE FROM customers;

SELECT * FROM customers;


/* 
	1. The idea is that when you insert new row into the table, PostgreSQL will update the new row if it exists,
	otherwise, it will insert the new row.

	that is why we call the action is upsert (the combination of update or insert).
*/

-- create sample table

CREATE TABLE t_tags(
	id serial PRIMARY KEY, 
	tag text UNIQUE,
	update_date TIMESTAMP DEFAULT NOW()
);

-- insert some sample data

INSERT INTO t_tags(tag) VALUES
('Pen'),
('Pencils');

-- views the data

SELECT * FROM t_tags;

-- Lets insert a record, on conflict do nothing

INSERT INTO t_tags (tag)
VALUES ('Pen')
ON CONFLICT (tag) 
DO
	NOTHING


SELECT * FROM t_tags;

-- Lets insert a record, on conflict set new values

INSERT INTO t_tags (tag)
VALUES ('Pen')
ON CONFLICT (tag)
DO
	UPDATE SET 
		tag = EXCLUDED.tag || 1,
		update_date  = NOW();
		


