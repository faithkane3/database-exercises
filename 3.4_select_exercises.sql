-- 3.4_select_exercises.sql
-- use albums database
use albums_db;
-- show all tables in database
show tables;
-- list fields and data types for table 
describe albums;
-- names of all albums by Pink Floyd  The Dark Side of the Moon and The Wall
SELECT name FROM albums WHERE artist='Pink Floyd';
-- the year Sgt. Pepper's Lonely Hearts Club Band was released  1967
SELECT release_date FROM albums WHERE name='Sgt. Pepper\'s Lonely Hearts Club Band';
-- The genre for the album Nevermind  Grunge, Alternative rock
SELECT genre FROM albums WHERE name='Nevermind';
-- albums released in the 1990s   12 titles
SELECT name FROM albums WHERE release_date BETWEEN 1990 AND 2000;
-- albums that had less than 20 million certified sales    31 titles
SELECT name FROM albums WHERE sales<2e6;
-- albums with genre of Rock (only selects genre with exact match 'Rock')
SELECT name FROM albums WHERE genre='Rock';
-- this SELECT query returns album names that have 'Rock' in the genre, like 'Hard Rock'
-- 'Progressive Rock'
SELECT name FROM albums WHERE genre LIKE '%Rock%'