3.11_more_exercises.sql

/*Employees Database
How much do the current managers of each department get paid, relative to the average salary for the department? 
Is there any department where the department manager gets paid less than the average salary?*/



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
