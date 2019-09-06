-- 3.8.3_subqueries_exercises.sql 

-- 1. Find all the employees with the same hire date as employee 101010 using a sub-query.
-- 69 Rows

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date IN (
	SELECT hire_date
	FROM employees
	WHERE emp_no='101010');

-- 2. Find all the titles held by all employees with the first name Aamod.
-- 314 total titles, 6 unique titles

SELECT titles.title
FROM titles
JOIN employees ON titles.emp_no=employees.emp_no
WHERE employees.first_name IN (
			SELECT first_name
			FROM employees
			WHERE first_name='Aamod'

);

-- 2. Same query as above with added Count and Group By showing the 6 unique titles with counts.

SELECT titles.title AS Title, COUNT(titles.title) AS 'Aamods with Title'
FROM titles
JOIN employees ON titles.emp_no=employees.emp_no
WHERE employees.first_name IN (
			SELECT first_name
			FROM employees
			WHERE first_name='Aamod'

)
GROUP BY titles.title;

-- 3. Sub query for current employees by name 85,108

SELECT COUNT(e.emp_no) AS 'Employees - Not Current'
FROM employees AS e
WHERE e.emp_no IN
			
			(SELECT de.emp_no
			FROM dept_emp AS de
			WHERE NOT de.to_date='9999-01-01');
-- 4. Find all the current department managers that are female.

-- Answer as a sub query
SELECT e.first_name, e.last_name
FROM employees AS e
WHERE e.emp_no IN
(
	SELECT dm.emp_no
	FROM dept_manager AS dm
	WHERE dm.to_date='9999-01-01' AND e.gender='F'
);

-- Answer as a JOIN
SELECT e.first_name, e.last_name
FROM employees AS e
JOIN dept_manager AS dm
ON e.emp_no=dm.emp_no
WHERE dm.to_date='9999-01-01' AND e.gender='F';

-- 5. Find all the employees that currently have a higher than average salary.
-- 154543 rows in total. Here is what the first 5 rows will look like:

SELECT e.first_name, e.last_name, ROUND(s.salary) AS salary
FROM employees AS e
JOIN salaries AS s
ON e.emp_no=s.emp_no
WHERE s.to_date='9999-01-01' AND s.salary >
				(SELECT AVG(s.salary)
				FROM salaries AS s
				);

-- 6. How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
-- 78 salaries

-- BONUS 1. Find all the department names that currently have female managers.
SELECT d.dept_name
FROM departments AS d
JOIN dept_manager AS dm 
ON d.dept_no=dm.dept_no
JOIN employees AS e
ON e.emp_no=dm.emp_no
WHERE e.gender='F' AND dm.emp_no IN (SELECT dm.emp_no
FROM dept_manager AS dm
WHERE dm.to_date='9999-01-01');

