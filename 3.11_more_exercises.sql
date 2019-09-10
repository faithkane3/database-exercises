3.11_more_exercises.sql

/*Employees Database
How much do the current managers of each department get paid, relative to the average salary for the department? 
Is there any department where the department manager gets paid less than the average salary?*/

SELECT salary,
	   CONCAT(first_name, ' ', last_name) AS dept_manager
	 
	 FROM salaries AS s
	 JOIN dept_manager AS dm
	 USING(emp_no)
	 JOIN employees AS e
	 USING(emp_no)
	 WHERE s.to_date>NOW() AND 
	 	   emp_no IN (
				SELECT emp_no 
				FROM dept_manager
				WHERE to_date>NOW());


/*World Database
Use the world database for the questions below.

What languages are spoken in Santa Monica*/

SELECT Language, Percentage
	FROM countrylanguage
	JOIN city
	USING(CountryCode)
WHERE name="Santa Monica"
ORDER BY Percentage ASC;

/* How many different countries are in each region?*/

SELECT Region,
	   COUNT(name)
	   AS num_countries
FROM country
GROUP BY region
ORDER BY num_countries ASC;


/*What is the population for each region?*/

SELECT Region, SUM(Population) AS population
FROM country
GROUP BY Region
ORDER BY population DESC;

/*What is the population for each continent?*/

SELECT Continent, SUM(Population) AS population
FROM country
GROUP BY Continent
ORDER BY population DESC;

/*What is the average life expectancy globally?*/

SELECT AVG(LifeExpectancy)
FROM country;

/*What is the average life expectancy for each region, each continent? Sort the results from shortest to longest*/

SELECT Continent,
	   AVG(LifeExpectancy) AS life_expectancy
FROM country
GROUP BY Continent
ORDER BY life_expectancy;

/*By Region*/

SELECT Region,
	   AVG(LifeExpectancy) AS life_expectancy
FROM country
GROUP BY Region
ORDER BY life_expectancy;

/*Bonus
Find all the countries whose local name is different from the official name*/

SELECT Name
FROM country
WHERE Name<>LocalName AND LocalName<>'-';

/*How many countries have a life expectancy less than x?*/

SELECT COUNT(name)
FROM country
WHERE LifeExpectancy<500000;

/*What state is city x located in?*/

SELECT district
FROM city
WHERE name='San Antonio';

/*What region of the world is city x located in?*/

SELECT region
FROM country
JOIN city
ON city.CountryCode=country.Code
WHERE city.name='San Antonio';


/*What country (use the human readable name) city x located in?*/

SELECT country.name
FROM country
JOIN city
ON country.code=city.countrycode
WHERE city.name='San Antonio';

/*What is the life expectancy in city x?*/

SELECT lifeexpectancy
FROM country
JOIN city
ON city.countrycode=country.code
WHERE city.name='San Antonio';

/*Sakila Database

Display the first and last names in all lowercase of all the actors.*/

SELECT LOWER(first_name),
	   LOWER(last_name)
FROM actor;


/*You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
What is one query would you could use to obtain this information?*/

SELECT actor_id,
	   first_name,
	   last_name
FROM actor
WHERE first_name='Joe';


/*Find all actors whose last name contain the letters "gen":*/

SELECT first_name,
	   last_name
FROM actor
WHERE last_name LIKE "%gen%";


/*Find all actors whose last names contain the letters "li". 
This time, order the rows by last name and first name, in that order.*/

SELECT last_name, 
	   first_name
FROM actor
WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name;


/*Using IN, display the country_id and country columns for the following countries: 
Afghanistan, Bangladesh, and China:*/

SELECT country_id,
	   country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');


/*List the last names of all the actors, as well as how many actors have that last name.*/

SELECT last_name,
	   COUNT(last_name)
FROM actor
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;


/*List last names of actors and the number of actors who have that last name, 
but only for names that are shared by at least two actors*/

SELECT last_name,
	   COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name)>1
ORDER BY COUNT(last_name) DESC;


/*You cannot locate the schema of the address table. Which query would you use to re-create it?*/


describe address;

/*Use JOIN to display the first and last names, as well as the address, of each staff member.*/

SELECT first_name,
	   last_name,
	   address
FROM staff
JOIN address USING(address_id);


/*Use JOIN to display the total amount rung up by each staff member in August of 2005.*/

SELECT first_name,
	   last_name,
	   SUM(amount) AS total
	FROM staff AS s
	JOIN payment AS p
	USING(staff_id)
	WHERE p.payment_date BETWEEN '2005-08-01 08:51:04' AND '2005-08-31 20:03:46'
	GROUP BY last_name, first_name;


/*List each film and the number of actors who are listed for that film.*/

SELECT title,
	   COUNT(actor_id)
    FROM film
    LEFT JOIN film_actor USING(film_id)
    GROUP BY title
    ORDER BY COUNT(actor_id) DESC;


/*How many copies of the film Hunchback Impossible exist in the inventory system?*/

SELECT COUNT(film_id),
	   title
FROM inventory
JOIN film USING(film_id)
WHERE title='Hunchback Impossible';


/*The music of Queen and Kris Kristofferson have seen an unlikely resurgence. 
As an unintended consequence, films starting with the letters K and Q have also soared in popularity. 
Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.*/

SELECT title
FROM film
WHERE title IN
			(SELECT title
			FROM film
			WHERE title LIKE'K%' OR title LIKE'Q%'
			);


/*Use subqueries to display all actors who appear in the film Alone Trip.*/

SELECT CONCAT(first_name, ' ',
	   last_name) AS actor_name
FROM actor
JOIN film_actor USING(actor_id)
WHERE film_id IN
			(SELECT film_id
			FROM film
			WHERE title="Alone Trip"
			);


/*You want to run an email marketing campaign in Canada, 
for which you will need the names and email addresses of all Canadian customers.*/

SELECT CONCAT(first_name, " ",
	   		  last_name) AS name,
	   		  email
	   FROM customer
	   JOIN address USING(address_id)
	   JOIN city USING(city_id)
	   JOIN country USING(country_id)
	   WHERE country_id=20;


/*Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
Identify all movies categorized as famiy films.*/

SELECT title
	FROM film
	JOIN film_category USING(film_id)
	JOIN category USING(category_id)
	WHERE category.name='Family';


/*Write a query to display how much business, in dollars, each store brought in.*/

SELECT SUM(amount),
	   staff_id AS store
	FROM payment
	GROUP BY store;


/*Write a query to display for each store its store ID, city, and country.*/

SELECT store_id,
	   city,
	   country
	FROM store
	JOIN address USING(address_id)
	JOIN city USING(city_id)
	JOIN country USING(country_id);


/*List the top five genres in gross revenue in descending order. 
(Hint: you may need to use the following tables: 
category, film_category, inventory, payment, and rental.)*/


SELECT  name,
		SUM(amount) AS gross_revenue
	FROM category
	JOIN film_category USING(category_id)
	JOIN inventory USING(film_id)
	JOIN rental USING(inventory_id)
	JOIN payment USING(rental_id)
	GROUP BY name
	ORDER BY gross_revenue DESC;
/*1. SELECT statements*/

/*Select all columns from the actor table.*/

SELECT *
FROM actor;

/*Select only the last_name column from the actor table.*/

SELECT DISTINCT last_name
FROM actor;

/*Select only the following columns from the film table.*/

SELECT DISTINCT title, 
				release_year
FROM film;

/*2. DISTINCT operator

Select all distinct (different) last names from the actor table.*/

SELECT DISTINCT last_name
FROM actor;


/*Select all distinct (different) postal codes from the address table.*/

SELECT DISTINCT postal_code
FROM address;

/*Select all distinct (different) ratings from the film table.*/

SELECT DISTINCT rating
FROM film;

/*WHERE clause

Select the title, description, rating, movie length columns from the films table 
that last 3 hours or longer.*/

SELECT title,
	   description,
	   rating,
	   length
	FROM film
	WHERE length>=180;

/*Select the payment id, amount, and payment date columns from the payments table 
for payments made on or after 05/27/2005.*/

SELECT payment_id,
	   amount,
	   payment_date
	FROM payment
	WHERE payment_date>"2005-05-26";

/*Select the primary key, amount, and payment date columns from the payment table 
for payments made on 05/27/2005.*/

SELECT payment_id,
	   amount,
	   payment_date
	FROM payment
	WHERE payment_date>"2005-05-26";

/*Select all columns from the customer table 
for rows that have a last names beginning with S and a first names ending with N.*/

SELECT *
	FROM customer
	WHERE last_name LIKE 'S%' AND first_name LIKE '%N';

/*Select all columns from the customer table 
for rows where the customer is inactive or has a last name beginning with "M".*/


SELECT *
	FROM customer
	WHERE last_name LIKE 'M%' AND active=0;


/*Select all columns from the category table for rows where 
the primary key is greater than 4 and the name field begins with either C, S or T.*/

SELECT *
	FROM category
	WHERE category_id>4 AND name LIKE 'C%' OR name LIKE 'S%' OR name LIKE 'T%';

/*Select all columns minus the password column from the staff table 
for rows that contain a password.*/

SELECT staff_id,
	   last_name,
	   first_name,
	   address_id,
	   picture,
	   email,
	   store_id,
	   active,
	   username,
	   last_update
	FROM staff
	WHERE password IS NOT NULL;

/*Select all columns minus the password column from the staff table f
or rows that do not contain a password.*/

SELECT staff_id,
	   last_name,
	   first_name,
	   address_id,
	   picture,
	   email,
	   store_id,
	   active,
	   username,
	   last_update
	FROM staff
	WHERE password IS Null;

/*IN operator

Select the phone and district columns from the address table 
for addresses in California, England, Taipei, or West Java.*/

SELECT phone,
	   district
	FROM address
	WHERE district IN ('California', 'England', 'Taipei', 'West Java');

/*Select the payment id, amount, and payment date columns from the payment table 
for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. 
(Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)*/

SELECT payment_id,
	   amount,
	   payment_date
	FROM payment
	WHERE DATE(payment_date) IN ('2005-05-25', '2005-05-27', '2005-05-29');

/*Select all columns from the film table for films rated G, PG-13 or NC-17.*/

SELECT *
	FROM film
	WHERE rating IN ('G', 'PG-13', 'NC-17');

/*BETWEEN operator

Select all columns from the payment table for payments 
made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.*/

SELECT *
	FROM payment
	WHERE DATE(payment_date) BETWEEN '2005-05-25' AND '2005-05-26 23:59:59';

/*Select the following columns from the film table for films where the length of the description 
is between 100 and 120.*/

SELECT title,
	   rental_duration * rental_rate AS total_rental_cost
	FROM film
	WHERE CHAR_LENGTH(description) BETWEEN 100 AND 120;

/*LIKE operator

Select the following columns from the film table 
for rows where the description begins with "A Thoughtful".*/

SELECT *
	FROM film
	WHERE description LIKE 'A Thoughtful%';

/*Select the following columns from the film table 
for rows where the description ends with the word "Boat".*/

SELECT *
	FROM film
	WHERE description LIKE '%Boat';

/*Select the following columns from the film table 
where the description contains the word "Database" 
and the length of the film is greater than 3 hours.*/

SELECT *
	FROM film
	WHERE description LIKE '%Database%';

/*LIMIT Operator

Select all columns from the payment table and only include the first 20 rows.*/

SELECT *
	FROM payment
	LIMIT 20;

/*Select the payment date and amount columns from the payment table 
for rows where the payment amount is greater than 5, 
and only select rows whose zero-based index in the result set is between 1000-2000.*/

SELECT payment_date,
	   amount
	FROM payment
	WHERE amount > 5
	LIMIT 1001
	OFFSET 999;

/*Select all columns from the customer table, l
imiting results to those where the zero-based index is between 101-200.*/

SELECT *
	FROM customer
	LIMIT 99
	OFFSET 100;

/*ORDER BY statement

Select all columns from the film table and order rows by the length field 
in ascending order.*/

SELECT *
	FROM film
	ORDER BY length;

/*Select all distinct ratings from the film table ordered by rating 
in descending order.*/

SELECT DISTINCT rating
	FROM film
	ORDER BY rating DESC;

/*Select the payment date and amount columns from the payment table 
for the first 20 payments ordered by payment amount in descending order.*/

SELECT payment_date,
	   amount
	FROM payment
	ORDER BY amount DESC
	LIMIT 20;

/*Select the title, description, special features, length, and rental duration columns 
from the film table for the first 10 films with behind the scenes footage 
under 2 hours in length and a rental duration between 5 and 7 days, 
ordered by length in descending order.*/

SELECT title,
	   description,
	   special_features,
	   length,
	   rental_duration
	FROM film
		WHERE special_features LIKE '%Behind the Scenes%' 
			AND length<120 
				AND rental_duration BETWEEN 5 AND 7
		ORDER BY length DESC
		LIMIT 10;

/*JOINs

Select customer first_name/last_name and actor first_name/last_name columns 
from performing a left join between the customer and actor column 
on the last_name column in each table. (i.e. customer.last_name = actor.last_name)

Label customer first_name/last_name columns as customer_first_name/customer_last_name

Label actor first_name/last_name columns in a similar fashion.
returns correct number of records: 599*/

SELECT c.first_name AS customer_first_name,
	   c.last_name AS customer_last_name,
	   a.first_name AS actor_first_name,
	   a.last_name AS actor_last_name
	FROM customer AS c
	LEFT JOIN actor AS a USING(last_name);

/*Select the customer first_name/last_name and actor first_name/last_name columns 
from performing a /right join between the customer and actor column 
on the last_name column in each table. (i.e. customer.last_name = actor.last_name)

returns correct number of records: 200*/

SELECT c.first_name AS customer_first_name,
	   c.last_name AS customer_last_name,
	   a.first_name AS actor_first_name,
	   a.last_name AS actor_last_name
	FROM customer AS c
	RIGHT JOIN actor AS a USING(last_name);

/*Select the customer first_name/last_name and actor first_name/last_name columns 
from performing an inner join between the customer and actor column 
on the last_name column in each table. (i.e. customer.last_name = actor.last_name)

returns correct number of records: 43*/

SELECT c.first_name AS customer_first_name,
	   c.last_name AS customer_last_name,
	   a.first_name AS actor_first_name,
	   a.last_name AS actor_last_name
	FROM customer AS c
	JOIN actor AS a USING(last_name);

/*Select the city name and country name columns from the city table, 
performing a left join with the country table to get the country name column.

Returns correct records: 600*/

SELECT city,
	   country
	FROM city
	LEFT JOIN country USING(country_id);

/*Select the title, description, release year, and language name columns 
from the film table, performing a left join with the language table 
to get the "language" column.

Label the language.name column as "language"

Returns 1000 rows*/

SELECT title,
	   description,
	   release_year,
	   name AS language
	FROM film
	LEFT JOIN language USING(language_id);


/*Select the first_name, last_name, address, address2, city name, district, 
and postal code columns from the staff table, performing 2 left joins 
with the address table then the city table to get the address and city related 
columns.

returns correct number of rows: 2*/

SELECT first_name,
	   last_name,
	   address,
	   address2,
	   city,
	   district,
	   postal_code
	FROM staff
	LEFT JOIN address USING(address_id)
	LEFT JOIN city USING(city_id);

/* 1. What is the average replacement cost of a film? */

SELECT AVG(replacement_cost)
	FROM film;

/*Does this change depending on the rating of the film?  Yes, the replacement cost changes by rating.*/

SELECT AVG(replacement_cost),
	   rating
	FROM film
	GROUP BY rating;

/* 2.  How many different films of each genre are in the database?*/

SELECT name,
	   COUNT(name)
	FROM category
	JOIN film_category USING(category_id)
	JOIN film USING(film_id)
	GROUP BY name;

/* 3. What are the 5 frequently rented films?*/

SELECT f.title,
	   COUNT(*) AS total
	FROM film AS f
	JOIN inventory AS i USING(film_id)
	JOIN rental AS r USING(inventory_id)
	GROUP BY title
	ORDER BY total DESC
	LIMIT 5;

/* 4. What are the most most profitable films (in terms of gross revenue)?*/

SELECT  f.title,
		SUM(p.amount) AS gross_revenue
	FROM film AS f
	JOIN inventory AS i USING(film_id)
	JOIN rental AS r USING(inventory_id)
	JOIN payment AS p USING(rental_id)
	GROUP BY title
	ORDER BY gross_revenue DESC
	LIMIT 5;

/* 5. Who is the best customer?*/

SELECT CONCAT(c.last_name, ', ', c.first_name) AS name,
	   SUM(p.amount) AS total
	FROM customer AS c
	JOIN rental AS r USING(customer_id)
	JOIN payment AS p USING(rental_id)
	GROUP BY CONCAT(last_name, ', ', first_name)
	ORDER BY total DESC
	LIMIT 1;

/* 6. Who are the most popular actors (that have appeared in the most films)?*/

SELECT CONCAT(a.last_name, ', ', a.first_name) AS actor_name,
	   COUNT(*) AS total
	FROM actor AS a
	JOIN film_actor AS fa USING(actor_id)
	JOIN film AS f USING(film_id)
	GROUP BY CONCAT(a.last_name, ', ', a.first_name)
	ORDER BY total DESC
	LIMIT 5;

/* 7. What are the sales for each store for each month in 2005?*/

SELECT SUBSTR(payment_date,1,7) AS month,
	   store_id,
	   SUM(amount) AS sales
	FROM payment
	JOIN staff USING(staff_id)
	GROUP BY SUBSTR(payment_date,1,7), store_id;