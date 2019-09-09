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