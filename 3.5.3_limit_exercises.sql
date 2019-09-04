-- 3.5.3_limit_exercises.sql
-- copy in the contents of your exercise from the previous lesson and modify using order by
use employees;
show tables;
describe employees;
-- 2. List the first 10 distinct last name sorted in descending order. 
SELECT DISTINCT last_name FROM employees
ORDER BY last_name DESC
LIMIT 10;
-- 3. Find all employees hired in the 90s and born on Christmas, and Order By — 362 rows.
SELECT * FROM employees
WHERE hire_date BETWEEN '90-01-01' AND '99-12-31'
AND birth_date LIKE'%-12-25'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5;
-- 4. update the above query to find the tenth page if five results on each page
SELECT * FROM employees
WHERE hire_date BETWEEN '90-01-01' AND '99-12-31'
AND birth_date LIKE'%-12-25'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5 OFFSET 45;
-- LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
-- Limit * (desired page number results - 1) = OFFSET number to see what is on your desired page results
-- For example, if you limit 5 results, and you want to see what is on the tenth page, you multiply 9, the first 9 pages,
-- by the number of 5, records per page, and you get 45 records. Your OFFSET should be set at 45 to skip the first 9
-- pages of results.  
