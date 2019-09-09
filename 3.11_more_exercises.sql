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



