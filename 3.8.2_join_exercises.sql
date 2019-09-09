3.8.2_join_exercises.sql
-- Join Example Database
-- 1. Use the join_example_db. Select all the records from both the users and roles tables.
use join_example_db;
SELECT * FROM users;
SELECT * FROM roles;

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
-- Before you run each query, guess the expected number of results.
-- join
SELECT users.id, users.name, users.email, roles.name as roles 
FROM users
JOIN roles
ON users.id=roles.id;
-- left join
SELECT users.id, users.name, users.email, roles.name as roles 
FROM users
LEFT JOIN roles
ON users.id=roles.id;
-- right join
SELECT users.id, users.name, users.email, roles.name as roles 
FROM users
RIGHT JOIN roles
ON users.id=roles.id;

-- 3. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
-- Hint: You will also need to use group by in the query.
SELECT roles.name as roles, count(users.id) as employee_count
FROM users
LEFT JOIN roles
ON users.role_id=roles.id
GROUP BY roles;

-- Employees Database
use employees;
-- 2. Using the example in the Associative Table Joins section as a guide, 
-- write a query that shows each department along with the name of the current manager for that department.

SELECT DISTINCT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees AS e
JOIN dept_manager AS dm
ON dm.emp_no=e.emp_no
JOIN departments AS d
ON d.dept_no=dm.dept_no
ORDER BY dept_name;
-- 3. Find the name of all departments currently managed by women. 

SELECT DISTINCT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees AS e
JOIN dept_manager AS dm
ON dm.emp_no=e.emp_no
JOIN departments AS d
ON d.dept_no=dm.dept_no
WHERE e.gender='F'
ORDER BY dept_name;
-- 4. Find the current titles of employees currently working in the Customer Service department.
-- describe departments;

SELECT t.title, COUNT(t.title) AS Count
FROM titles AS t
JOIN dept_emp AS de
ON t.emp_no=de.emp_no
JOIN departments AS d
ON de.dept_no=d.dept_no
WHERE d.dept_no='d009' AND de.to_date='9999-01-01' AND t.to_date='9999-01-01'
GROUP BY t.title;

-- 5. Find the current salary of all current managers.
SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS Name, s.salary
FROM salaries AS s
JOIN employees AS e
ON s.emp_no=e.emp_no
JOIN dept_manager AS dm
ON e.emp_no=dm.emp_no
JOIN departments AS d
ON dm.dept_no=d.dept_no
WHERE s.to_date='9999-01-01' AND dm.to_date='9999-01-01'
ORDER BY d.dept_name;

-- 6. Find the number of employees in each department.

SELECT d.dept_no, d.dept_name, COUNT(de.emp_no)
FROM departments AS d
JOIN dept_emp AS de
ON d.dept_no=de.dept_no
WHERE de.to_date='9999-01-01'
GROUP BY d.dept_no;

--- 7. Which department has the highest average salary? (Still needs to filter for MAX)

SELECT d.dept_name, AVG(s.salary) AS average_salary
FROM departments AS d
JOIN dept_emp AS de
ON d.dept_no=de.dept_no
JOIN salaries AS s
ON s.emp_no=de.emp_no
WHERE de.to_date='9999-01-01' AND s.to_date='9999-01-01'
GROUP BY d.dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?

SELECT e.first_name, e.last_name
FROM employees AS e 
JOIN salaries AS s ON e.emp_no=s.emp_no
JOIN dept_emp AS de ON s.emp_no=de.emp_no
JOIN departments AS d ON de.dept_no=d.dept_no
WHERE d.dept_no='d001' AND s.to_date='9999-01-01' AND de.to_date='9999-01-01'
ORDER BY s.salary DESC
LIMIT 1;

-- 9. Which current department manager has the highest salary?

SELECT e.first_name, e.last_name, s.salary, d.dept_name
FROM employees AS e 
JOIN salaries AS s ON e.emp_no=s.emp_no
JOIN dept_manager AS dm ON s.emp_no=dm.emp_no
JOIN departments AS d ON dm.dept_no=d.dept_no
WHERE d.dept_no='d001' AND s.to_date='9999-01-01' AND dm.to_date='9999-01-01'
ORDER BY s.salary DESC
LIMIT 1;

-- Bonus - This query returns department manager with department title
SELECT d.dept_name AS 'Department Name', CONCAT(e.first_name, ' ', e.last_name) AS 'Manager Name' 
FROM employees AS e
JOIN dept_manager AS dm ON dm.emp_no=e.emp_no
JOIN departments AS d ON dm.dept_no=d.dept_no
WHERE e.emp_no IN (
	SELECT dm.emp_no
	FROM dept_manager AS dm
	WHERE dm.to_date='9999-01-01'
);

-- This query returns employee name with department name and 'Manager Name'
SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name', d.dept_name AS 'Department Name', 'Manager Name'
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no=de.emp_no
JOIN departments AS d ON de.dept_no=d.dept_no;


-- THis query returns current manager names
SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Manager Name'
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no=dm.emp_no
WHERE dm.to_date='9999-01-01' AND e.emp_no IN (dm.emp_no);


