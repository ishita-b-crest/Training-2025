--1. select first and last 10 records
 
select *
from stocks_prices
where symbol_id = 1
order by price_date asc
offset 10
limit 10;
 
--2. select first and last 10 record per each group
 
select symbol_id,min(price_date)
from stocks_prices
group by symbol_id;

select symbol_id,max(price_date)
from stocks_prices
group by symbol_id;
 
--3. Calculate cube root
 
select close_price,cbrt(close_price)
from stocks_prices
where symbol_id = 1
order by price_date desc;

select cbrt(27) as "cube root";
 