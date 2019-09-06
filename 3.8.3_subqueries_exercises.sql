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