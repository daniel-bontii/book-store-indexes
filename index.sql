--Show first ten customers
SELECT
    *
FROM
    customers
LIMIT
    10;

--Show first ten orders
SELECT
    *
FROM
    orders
LIMIT
    10;

--Show first ten books
SELECT
    *
FROM
    books
LIMIT
    10;

--Examine what indexes exist on customers table
SELECT
    *
FROM
    pg_Indexes
WHERE
    tablename = 'customers';

--Examine what indexes exist on books table
SELECT
    *
FROM
    pg_Indexes
WHERE
    tablename = 'books';

--Examine what indexes exist on orders table
SELECT
    *
FROM
    pg_Indexes
WHERE
    tablename = 'orders';

--Create an index on customer_id in orders table
CREATE INDEX orders_customer_id_idx ON orders (customer_id);

--Create an index on book_id in orders table
CREATE INDEX orders_book_id_idx ON orders (book_id);

--analyze query to see if an index would be a good idea
EXPLAIN ANALYZE
SELECT
    original_language,
    title,
    sales_in_millions
FROM
    books
WHERE
    original_language = 'French';

--inspect table size
SELECT
    pg_size_pretty (pg_total_relation_size ('books'));

--create multicolumn index on original_language, title and sales_in_millions
CREATE INDEX books_original_language_title_sales_in_millions_idx ON books (original_language, title, sales_in_millions);

--Examine what indexes exist on books table
SELECT
    *
FROM
    pg_Indexes
WHERE
    tablename = 'books';

--analyze query to see if an index would be a good idea after indexing
EXPLAIN ANALYZE
SELECT
    original_language,
    title,
    sales_in_millions
FROM
    books
WHERE
    original_language = 'French';

--inspect table size after indexing
SELECT
    pg_size_pretty (pg_total_relation_size ('books'));

--drop multicolumn index on original_language, title and sales_in_millions
DROP INDEX IF EXISTS books_original_language_title_sales_in_millions_idx;

--Examine what indexes exist on books table after deleting index
SELECT
    *
FROM
    pg_Indexes
WHERE
    tablename = 'books';

--drop all indexes on orders table
DROP INDEX IF EXISTS orders_customer_id_idx;

DROP INDEX IF EXISTS orders_book_id_idx;

SELECT
    NOW();

\ COPY orders
FROM
    'orders_add.txt' DELIMITER ',' CSV HEADER;

SELECT
    NOW();

--recreate all indexes on orders table after bulk insert to see time difference
--Create an index on customer_id in orders table
CREATE INDEX orders_customer_id_idx ON orders (customer_id);

--Create an index on book_id in orders table
CREATE INDEX orders_book_id_idx ON orders (book_id);

--Create index on first_name and email_address in customers table
CREATE INDEX customers_first_name_email_address_idx ON customers (first_name, email_address);

--Examine what indexes exist on customers table
SELECT
    *
FROM
    pg_Indexes
WHERE
    tablename = 'customers';