-- 3.5.1_where_exercises.sql
use employees;
show tables;
describe employees;
-- selecting all employees with first names Irena, Vidya, or Maya 709
SELECT * FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya');
-- select all employees with last names starting with Even
SELECT * FROM employees
WHERE last_name LIKE('E%');
-- select all employees hired in the 90s  135,214
SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
-- select all employees born on Christmas 842
SELECT * FROM employees
WHERE birth_date LIKE '%-12-25';
-- select all employees with a q in their last names  1873
SELECT * FROM employees
WHERE last_name LIKE '%q%';
-- use or instead of in for number 2
SELECT * FROM employees
WHERE (first_name='Irena' OR first_name='Vidya' OR first_name='Maya')
AND gender='M';
-- Find all employees whose last name starts or ends with 'E' — 30,723 rows.
SELECT * FROM employees
WHERE last_name LIKE('E%') OR last_name LIKE('%E');
--  Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' — 899 rows.
SELECT * FROM employees
WHERE last_name LIKE('E%') AND last_name LIKE('%E');
-- Find all employees hired in the 90s and born on Christmas — 362 rows.
SELECT * FROM employees
WHERE (hire_date BETWEEN '90-01-01' AND '99-12-31')
AND birth_date LIKE('%-12-25');
-- Find all employees with a 'q' in their last name but not 'qu' — 547 rows.
SELECT * FROM employees
WHERE last_name LIKE('%q%') AND last_name NOT LIKE('%qu%');
