//Practic Joins
1. 
SELECT * FROM invoice i
JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;
2. 
SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;
3. 
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id;
4.
SELECT al.title, ar.name FROM album al
JOIN artist ar ON al.artist_id = ar.artist_id;
5. 
SELECT pt.track_id FROM playlist_track pt
JOIN playlist p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';
6. 
SELECT t.name FROM track t
JOIN playlist_track pt ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;
7. 
SELECT t.name, p.name FROM track t
JOIN playlist_track pt ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id;
8. 
SELECT t.name, a.title FROM track t
JOIN album a ON t.album_id = a.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

//Practic Nested Queries
1.
SELECT * FROM invoice
WHERE invoice_id IN (SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99)
2. 
SELECT * FROM playlist_track
WHERE playlist_id IN (SELECT playlist_id FROM playlist WHERE name = 'Music');
3. 
SELECT name FROM track 
WHERE track_id IN (SELECT track_id FROM playlist_track WHERE playlist_id = 5);
4. 
SELECT * FROM track
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name = 'Comedy');
5. 
SELECT * FROM track
WHERE album_id IN 
(SELECT album_id FROM album WHERE name = 'Fireball');
6. 
SELECT * FROM track
WHERE album_id IN (
  SELECT album_id FROM album WHERE artist_id IN (
    SELECT artist_id FROM artist WHERE name = 'Queen')
  );

//Practice Updating Rows
1. 
UPDATE customer 
SET fax = null 
WHERE fax IS NOT null;
2. 
UPDATE customer
SET company = 'Self' 
WHERE company IS null;
3. 
UPDATE customer
SET last_name = 'Thompson' 
WHERE first_name = 'Julia' AND last_name = 'Barnett';
4. 
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';
5. 
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal') AND composer IS null;

//Group By
1. 
SELECT COUNT (*), g.name FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;
2. 
SELECT COUNT (*), g.name FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;
3. 
SELECT ar.name, COUNT (*) FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;

//Use Distinct
1. 
SELECT DISTINCT composer
FROM track;
2. 
SELECT DISTINCT billing_postal_code
FROM invoice;
3. 
SELECT DISTINCT company
FROM customer;

//Delete Rows
1. 
Created
2. 
DELETE
FROM practice_delete
WHERE type = 'bronze';
3. 
DELETE
FROM practice_delete
WHERE type = 'silver';
4. 
DELETE
FROM practice_delete
WHERE value = 150;


//eCommerce Simulation---------------------------------
//Create tables 
--users
create table users (
  user_id serial primary key,
  name VARCHAR(60),
  email text
);
--products
create table products (
  product_id serial primary key,
  name VARCHAR(60),
  price numeric(12, 2)
);
-- --orders
create table orders (
  id serial primary key,
  order_id integer,
  product_id integer references products(product_id)
);

//Add Data to fill up tables---------------------------------
// 3 users, 3 products, 3 orders
insert into users (name, email)
 values
  ('Gary Stephens', 'gary.stephens@gmail.com'),
  ('Laura Greeley', 'laura.greeley@gmail.com'),
  ('Spencer Clark', 'spencer.clark@gmail.com')
;

insert into products (name, price)
values
  ('Thinga ma bob', 18.99),
  ('Dooo hicky', 23.87),
  ('Watcham acalic', 0.99)
;

insert into orders (order_id, product_id)
values
  (1, 2),
  (1, 3),
  (2, 1),
  (3, 1),
  (3, 2),
  (3, 3)
;

--Get all products for the first order
SELECT * from orders o
join products p on o.product_id = p.product_id
where order_id = 1;

-- Get all orders
select * from orders;

--Get the total cost of an order
SELECT sum(p.price) from orders o
join products p on o.product_id = p.product_id
where order_id = 3;

--Add a foreign key reference from orders to users
alter table orders
add column user_id int 
references users(user_id);

-- Update the orders table to link a user to each order
update orders set user_id = 1
where order_id = 1;
update orders set user_id = 2
where order_id = 2;
update orders set user_id = 3
where order_id = 3;

-- Get all orders for a user.
SELECT * from orders o
join products p on o.product_id = p.product_id
where user_id = 2;

-- Get how many orders each user has.
SELECT distinct count(order_id) from orders o
join products p on o.product_id = p.product_id
where user_id = 3;