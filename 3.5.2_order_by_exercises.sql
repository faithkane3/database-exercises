3.5.2_order_by_exercises.sql

-- 1. copy in the contents of your exercise from the previous lesson and modify using order by
use employees;
show tables;
describe employees;
-- 2. selecting all employees with first names Irena, Vidya, or Maya, Order By first_name
SELECT * FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY first_name;
-- 3. selecting all employees with first names Irena, Vidya, or Maya, Order By first_name, last_name
SELECT * FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;
-- 4. selecting all employees with first names Irena, Vidya, or Maya, Order By last_name, first_name
SELECT * FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;
-- 5. select all employees with last names starting with Even, 
SELECT * FROM employees
WHERE last_name LIKE'E%'
ORDER BY emp_no;
-- 5. Find all employees whose last name starts or ends with 'E' — 30,723 rows.
SELECT * FROM employees
WHERE last_name LIKE'E%' 
OR last_name LIKE '%E'
ORDER BY emp_no;
-- 5. Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' — 899 rows.
SELECT * FROM employees
WHERE last_name LIKE'E%E'
ORDER BY emp_no;
-- 6. select all employees with last names starting with Even, Order By emp_no reversed
SELECT * FROM employees
WHERE last_name LIKE'E%'
ORDER BY emp_no DESC;
-- 6. Find all employees whose last name starts or ends with 'E' Order By emp_np reversed — 30,723 rows.
SELECT * FROM employees
WHERE last_name LIKE'E%' 
OR last_name LIKE '%E'
ORDER BY emp_no DESC;
-- 6. Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' Order By emp_no reversed — 899 rows.
SELECT * FROM employees
WHERE last_name LIKE'E%E'
ORDER BY emp_no DESC;
-- 7. Find all employees hired in the 90s and born on Christmas, and Order By — 362 rows.
SELECT * FROM employees
WHERE hire_date BETWEEN '90-01-01' AND '99-12-31'
AND birth_date LIKE'%-12-25'
ORDER BY birth_date, hire_date DESC;
