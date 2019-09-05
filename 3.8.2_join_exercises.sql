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