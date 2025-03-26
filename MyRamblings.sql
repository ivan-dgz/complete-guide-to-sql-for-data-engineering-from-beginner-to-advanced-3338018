/*
SELECT name, price FROM products;

-- Look for orders where price is > 
SELECT order_id, total_amount
FROM orders
WHERE total_amount > 100;
*/

-- Find customers where name starts with 'A'
/*
SELECT *
FROM customer
WHERE customer_name like 'A%'; -- like is used to compare a record with something, the something 'A%' indicates that it starts with the letter A, followed by an indefinite lenght of characters

 arrange products based on price from low to high
SELECT *
FROM products
ORDER BY price;
*/

-- order results (desc) by two columns (that are in the same table) first by price (costs more than 100) then by name
/*
SELECT *
FROM products
WHERE price > 100
ORDER BY price, name DESC;
*/

-- combining conditions all products where price is over 100 and category = 1
/*
SELECT *
FROM products
WHERE price > 100 AND category_id = 1;
*/

-- searching for results where the record can be TRUE on any of two conditions (price higher than 100 or cat 2)
/*
SELECT *
FROM products
WHERE price > 100 OR category_id = 2;
*/

-- challenge, list of customers who live in new york and order by names
/*
SELECT *
FROM customer
WHERE city = 'New York' OR city = 'NY'
ORDER BY customer_name;
*/

-- data manupulation (insert, update, delete)
/*
INSERT INTO products (name, price, description, tags, category_id, Supplier)
VALUES ('Ipad', 100, 'High-performance ipad for professionals', 'electronics, portable, tech', 1, 'SupplierA');
*/

/*
UPDATE products
SET price = 500
WHERE product_id = 6;
*/

/*
delete from products
where product_id = 6;
*/

/*
SELECT *
FROM orders;
*/

-- products purchased
/*
SELECT customer_name, name, description, total_amount
FROM orders
JOIN products
ON orders.product_id = products.product_id
RIGHT JOIN customer
ON customer.customer_id = orders.customer_id
ORDER BY orders.total_amount DESC;
*/

/*
SELECT name, total_quantity
FROM orders
RIGHT JOIN products
ON orders.product_id = products.product_id;
*/

-- outer joins
/*
SELECT customer_name, total_quantity
FROM customer
FULL OUTER JOIN orders
ON customer.customer_id = orders.customer_id;

SELECT customer_name, total_quantity
FROM customer
LEFT OUTER JOIN orders
ON customer.customer_id = orders.customer_id;

SELECT customer_name, total_quantity
FROM customer
RIGHT OUTER JOIN orders
ON customer.customer_id = orders.customer_id;

SELECT customer_name, total_quantity
FROM customer
LEFT JOIN orders
ON customer.customer_id = orders.customer_id;

SELECT customer_name, total_quantity
FROM customer
RIGHT JOIN orders
ON customer.customer_id = orders.customer_id;

SELECT customer_name, total_quantity
FROM customer
JOIN orders
ON customer.customer_id = orders.customer_id;

SELECT customer_name, total_quantity
FROM customer
FULL JOIN orders
ON customer.customer_id = orders.customer_id;
*/

-- FULL OUTER JOIN
/*
SELECT COALESCE(customer.customer_name, 'No customers') AS Customer, COALESCE(products.name, 'No purchases') AS Product, COALESCE(orders.total_quantity, 0) AS Purchases
FROM customer
FULL OUTER JOIN orders
ON customer.customer_id = orders.customer_id
FULL OUTER JOIN products
ON orders.product_id = products.product_id
ORDER BY orders.total_quantity DESC NULLS LAST, customer.customer_name;
*/

-- all products under a specific category, must have sold at least 10 in qty
/*
SELECT *
FROM categories;
*/

/*
SELECT name
FROM products
WHERE category_id = 1;

SELECT name
FROM products
INNER JOIN orders
ON products.product_id = orders.product_id
WHERE orders.total_quantity > 4;

SELECT NAME
FROM products
WHERE category_id = 1
UNION -- this will add to a single column the result of both queries, will not include duplicates
SELECT NAME
FROM products
INNER JOIN orders
ON products.product_id = orders.product_id
WHERE orders.total_quantity > 4;

SELECT NAME
FROM products
WHERE category_id = 1
UNION ALL -- this will add to a single column the result of both queries, will also include duplicate values
SELECT NAME
FROM products
INNER JOIN orders
ON products.product_id = orders.product_id
WHERE orders.total_quantity > 4;
*/

-- CASE
-- Can have multiple conditions
-- Looks for the first match
-- Return value in else clause if no match on the initial conditions
-- If not match with conditions nor else clause, will return a NULL

-- CASE Syntax
-- SELECT column_name
--  CASE
--    WHEN condition1 THEN result1
--    WHEN condition2 THEN result2
--    ELSE  defaul_result
--  END AS alias_name
-- FROM 

/*
SELECT name, description
CASE
  WHEN price < 100 THEN 'Cheap'
  WHEN price > 100 AND price < 500 THEN 'Affordable'
  ELSE 'Expensive'
  END AS ProductType

FROM products;
*/

/*
SELECT name, description, price,
  CASE
    WHEN price IS NULL THEN 'Dunno'
    WHEN price < 100 THEN 'Cheap'
    WHEN price > 100 AND price < 500 THEN 'Affordable'
        ELSE 'Expensive'
  END AS ProductType
FROM products;
*/

/* Group By
Categorize the data
Data reduction
Enhanced reporting
Used with aggregate functions:
  COUNT()
  MAX()
  MIN()
  SUM()
  AVG()

SELECT city, COUNT(customer_id)
FROM customer
GROUP BY city;
*/

/*
SELECT COUNT(customer_id) AS Total_Row_Count -- will count customer_id
FROM customer;

SELECT COUNT(DISTINCT customer_id) AS Total_Row_Count -- will count customer_id that are unique, repeated ones will not be aggregated
FROM customer;
*/

/*
SELECT SUM(total_amount)
FROM orders;

SELECT MAX(total_amount)
FROM orders;

SELECT MIN(total_amount)
FROM orders;

SELECT AVG(total_amount)
FROM orders;

SELECT STDDEV(total_amount)
FROM orders;
*/

/* Filtering GROUP BY and HAVING clause
Combining aggregation and filtering
NOTES on using WHERE and HAVING while using GROUP BY
Should use WHERE before the GROUP BY
Should use HAVING after the GROUP By
WHERE is used on non filtered data
HAVING is used on grouped data
*/

/*
SELECT city, COUNT(*)
FROM customer
GROUP BY city
HAVING COUNT(*) > 0;
*/

/*
SELECT categories.name, categories.category_id, COUNT(products.product_id)
FROM categories
JOIN products
ON categories.category_id = products.category_id
GROUP BY categories.category_id
HAVING COUNT(products.product_id) > 1;
*/

/* Challenge
Find all the products names along with their ID numbers that belong to the category called "electronics"

SELECT products.name, products.product_id
FROM products
JOIN categories
ON products.category_id = categories.category_id
GROUP BY categories.category_id
HAVING categories.category_id = 1;

SELECT name, product_id, category_id
FROM products
WHERE category_id =1;

SELECT products.name, products.product_id, categories.name
FROM products
JOIN categories
ON products.category_id = categories.category_id
WHERE categories.name = 'Electronics';
*/

---- CHALLENGE
-- Find all product names along with their ID numbers that belong to the category named 'Electronics'

/*
SELECT products.product_id, products.name
FROM products
JOIN categories
ON products.category_id = categories.category_id
WHERE categories.name = 'Electronics';
*/

---- MATHEMATICAL FUNCTIONS

/*
SELECT ABS(-2.6); -- Absolute value

SELECT CEIL(2.3); -- Highest integer possible (round up)

SELECT FLOOR(2.7); -- Lowest integer possible (round down)

SELECT ROUND(2.3456, 2); -- The first term is the number to round, the scond term indicates the total number of decimal places requiered for the output.

SELECT SQRT(4.0); -- the output will also include decimals

SELECT ROUND(SQRT(4.0), 0); -- can nest functions to have specific results
*/

---- DATE FUNCTIONS
/*
SELECT CURRENT_DATE;
SELECT EXTRACT(DAY FROM CURRENT_DATE); -- The output will be the number of calendar day of the month
SELECT EXTRACT(MONTH FROM CURRENT_DATE); -- The output will be the number of the month per calendar year
SELECT EXTRACT(YEAR FROM CURRENT_DATE); -- The output will be the current year in a 4 digit format
*/

/*
-- This uses another function(date specific) instead of extract
SELECT date_part('day', CURRENT_DATE); 
SELECT date_part('month', CURRENT_DATE);
SELECT date_part('year', CURRENT_DATE);
*/

-- Date Truncate will indicate the start of the [variable] period, full date + time
/*
SELECT date_trunc('day', CURRENT_DATE); -- Start of the day (the hour)
SELECT date_trunc('month', CURRENT_DATE); -- Start of Month (the day and hour)
SELECT date_trunc('year', CURRENT_DATE); -- Start of Year (the month, day and hour)
*/

-- Finding the age of someone or something
/*
SELECT age(timestamp '2019-06-03'); -- The output will give how many years, months and days
*/

-- Calculating the age between two dates
/*
SELECT age(timestamp '2025-01-01', timestamp '2025-01-31');
*/

-- Converting string into date (enabling date functions)
/*
SELECT to_date('01/01/2025', 'DD/MM/YYYY'); -- The output will be a date in the system format, not in the order that was written. The written order indcates which section of the string belongs to which part of the date.
*/

-- Applying a specific order to the date
/*
SELECT to_char(CURRENT_DATE, 'DD-MM-YYYY'); -- The output will arrange the current date as defined in the function.
*/

---- TIME FUNCTIONS
/*
SELECT current_time; -- time with timezone
SELECT current_timestamp; -- date with time and timezone
SELECT localtime; -- just the time
SELECT localtimestamp; -- date and time (no timezone)
*/
-- Notes
-- extract: Extracts a specific part of a date/time value. Useful for retrieving individual components of a date/time value
/*
SELECT extract(hour from order_timestamp) from orders;
SELECT extract(minute from order_timestamp) from orders;
SELECT EXTRACT(second from order_timestamp) from orders;
*/
-- Notes
-- date_trunc: Truncates a date/time value to a specified precision (hour, day, month, etc). Useful for rounding down to the nearest specified unit
/*
SELECT date_trunc('day', order_timestamp) from orders; -- focuses on the day, updating the time to the start of day
SELECT date_trunc('month', order_timestamp) from orders; -- focuses on the month, updating the day and time to the start of the month
SELECT date_trunc('year', order_timestamp) from orders; -- focuses on the year, updating the month, day and time to the start of the year
SELECT age(order_timestamp) FROM orders; -- how old is the data
SELECT age(delivery_timestamp, order_timestamp) from orders;
SELECT CURRENT_TIMESTAMP at time zone 'America/New_York';
*/

---- STRING FUNCTIONS: CONCATENATION AND TRIMMING
/*
SELECT city || address from customer; -- Concatenates the defined columns
SELECT city || '--' || address from customer; -- Concatenates the defined columns and includes a separator in between
SELECT concat(city, address) from customer;
SELECT concat_ws('-', city, address) from customer;
select trim('   hello   ');
SELECT ltrim('   hello   ');
SELECT rtrim('   hello   ');
SELECT btrim('   hello   ');
SELECT trim('xX' from 'XxHelloxX'); -- case sensitive, if the data trying to be trimmed is not on the edge it will not trim it
SELECT TRIM('#' from '##test##');
*/

---- STRING FUNCTIONS: CHANGING CASE AND EXTRACTING SUBSTRINGS
/*
SELECT upper(customer_name) from customer; -- all characters are capitalized
SELECT lower(customer_name) from customer; -- all characters are in lower case
SELECT initcap(customer_name) from customer; -- each first letter will be capitalized and the rest in lower case
SELECT SUBSTRING('Hello from here' from 1 for 5); -- (from #) start position, (for #) the number of characters
SELECT SUBSTRING('Hello from here' from 7 for 4);
SELECT LEFT('Hello from here', 5); -- will return the first 5 characters from the string
SELECT RIGHT('Hello from here', 4); -- will return the last 4 characters from the sting
SELECT POSITION('here' in 'Hello from here'); -- if the string we are searching for exist on the string we are searchong on, then it will return the position of where the searched string starts in the string being searched on.
SELECT position('not' in 'Hello from here'); -- if the string we are searching for does not exist within the string we are lookin into, then it will return 0
SELECT length('Hello from here'); -- will return how many characters the string is comprised of
*/

---- CHALLENGE: PLANY WITH STRINGS
-- tags in products need to be init cap
/*
SELECT initcap(tags) 
from products;
*/

