-- 3.6_functions_exercises.sql
show tables;
describe employees;
-- 2. Update your queries for employees whose names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
SELECT CONCAT(first_name, ' ', last_name) 
AS full_name FROM employees
WHERE CONCAT(first_name, ' ', last_name) LIKE'E%'
ORDER BY emp_no;
-- 3. Convert the names produced in your last query to all uppercase.
SELECT UPPER(CONCAT(first_name, ' ', last_name)) 
AS full_name FROM employees
WHERE CONCAT(first_name, ' ', last_name) LIKE'E%'
ORDER BY emp_no;
-- 4. For your query of employees born on Christmas and hired in the 90s, use datediff() to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE())
SELECT first_name, last_name, DATEDIFF(CURDATE(), hire_date) AS employment_length FROM employees
WHERE hire_date BETWEEN '90-01-01' AND '99-12-31'
AND birth_date LIKE'%-12-25'
ORDER BY birth_date ASC, hire_date DESC;
-- 5. Find the smallest and largest salary from the salaries table.
describe salaries;
SELECT MIN(salary) AS smallest salary, MAX(salary) AS largest salary FROM salaries;
-- 6. Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like
SELECT LOWER(
			CONCAT(
				SUBSTR(first_name, 1, 1), 
				SUBSTR(last_name, 1, 4), 
				'_', 
				DATE_FORMAT(birth_date,'%m%y')
			)
		) 
AS username, first_name, last_name, birth_date
FROM employees;
