----------------------REVIEW------------------
select address, city 
from customer 
where state = 'CA';

-- Order By----------
select first_name from customer 
order by first_name desc;

-- Limit ------------
select first_name 
from customer 
order by customer_id
limit 5;

-- SUM() ------------
select sum(total)
from invoice
where billing_state = 'CA';

-- COUNT() ------------
select count(invoice)
from invoice
where customer_id = 1;

-- AVG() ------------
select sum(total) / count(total) from invoice; -- becomes --
select AVG(total)
from invoice
where customer_id = 1;

-- MAX() ------------
select MAX(total)
from invoice
where customer_id = 1;

-- MIN() ------------
select MIN(total) AS smallest_total
from invoice
where customer_id = 1;
-- Can combine the last two, use AS to redefine, and have one sql statement
select max(total) AS largest_total , min(total) AS smallest_total
from invoice
where customer_id = 1;

-- LIKE ------------
select * from customer
where first_name like '%ron';
-- or
where first_name like '__ron';

-- Empty Data ------------
SELECT * FROM users 
WHERE name IS NULL;

SELECT * FROM users 
WHERE name IS NOT NULL;

-- Add Rows ------------
INSERT INTO users (
  first_name,
  last_name,
  email
  ) VALUES (
    'Bryan',
    'Smith',
    'bryan@devmountain.com'
    );

-- Delete Rows ------------ Be careful with this one. It is good practice to do a slect first see what data you will be updating.
DELETE FROM users
WHERE name = 'Bryan';

-- Update Rows ------------ Be careful with this one. It is good practice to do a slect first see what data you will be updating.
UPDATE users
SET name = 'Jase'
WHERE user_id = 4;
 
-- Distinct ------------
SELECT DISTINCT name
FROM users;
---below is taking the total of first names - the # of distinct names and redefining it as 'number_of_same_name'
SELECT COUNT(first_name) - count(distinct first_name) AS number_of_same_name
from customer;

-- Adding/Removing Columns
ALTER TABLE racers
ADD COLUMN team TEXT;

ALTER TABLE racers
DROP COLUMN team TEXT;

-- ALtering Data Types
ALTER TABLE racers
ALTER team
SET DATA TYPE VARCHAR(100);
-- or
ALTER TABLE racers
ALTER team
TYPE VARCHAR(100);

-- Renaming Columns/Table
ALTER TABLE racers
RENAME COLUMN team
TO "group";

ALTER TABLE racers
RENAME TO bike_racers;

----------------RELATIONAL DATABASES---------------
-------------------NORMALIZATION-------------------
Table Relationships
1. one to one  
  1 person : 1 driver license
2. one to many
  1 company : many employees
3. many to many
  many books : many authors
----- This will join the tables
SELECT * FROM album
JOIN artist 
on artist.artist_id = album.artist_id;
--or--
-------This will join the tables only showing the title and name, unlike the previous example where it showed all the ids and artist_id 2x.
SELECT title as album_title, name as artist FROM album
JOIN artist 
on artist.artist_id = album.artist_id;
--- where name = 'Accept';
--- or --- where artist.artist_id = 1;

SELECT * FROM track tr
join playlist_track pt
on tr.track_id = pt.track_id
join playlist p 
on p.playlist_id = pt.playlist_id;
---or---
SELECT p.name as playlist, tr.name as track_name FROM track tr
join playlist_track pt
on tr.track_id = pt.track_id
join playlist p 
on p.playlist_id = pt.playlist_id;

----------------Foreign Keys---------------
CREATE TABLE bikes (
  bikeId SERIAL PRIMARY KEY,
  racerId INTEGER REFERENCES racers(racerId),
  type TEXT,
  color TEXT
);

create table secret_tracks(
  secret_tracks_id serial primary key,
  track_id int references track(track_id)
);

insert into secret_tracks (track_id)
values (1), (2), (3)

select t.name as track, composer, g.name as genre from secret_tracks st
join track t
on t.track_id = st.track_id
join genre g
on g.genre_id = t.genre_id;

----------------Subqueries---------------
SELECT * from racers
WHERE racerid IN (
  SELECT racerid
  FROM bikes 
  WHERE type = 'fezzari'
  AND age >= 25
)

select * from track
where genre_id in (
	select genre_id from genre
  where name in ('Rock', 'Metal')
);
