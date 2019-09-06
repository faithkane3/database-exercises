3.9_temporary_tables.sql

-- 1. Using the example from the lesson, re-create the employees_with_departments table.

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no);

-- a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

ALTER TABLE employees_with_departments ADD COLUMN full_name VARCHAR(30);

 -- b. Update the table so that full name column contains the correct data

UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

-- c. Remove the first_name and last_name columns from the table.

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- d. What is another way you could have ended up with this same table?

-- 2. Create a temporary table based on the payment table from the sakila database.
-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
-- For example, 1.99 should become 199.




-- 3. Find out how the average pay in each department compares to the overall average pay. 
-- In order to make the comparison easier, you should use the Z-score for salaries. 
-- In terms of salary, what is the best department to work for? The worst?



-- 4. What is the average salary for an employee based on the number of years they have been with the company? 
-- Express your answer in terms of the Z-score of salary.
-- Since this data is a little older, scale the years of experience by subtracting the minumum from every row.



-- Lesson: Examples

CREATE TEMPORARY TABLE employee_salary AS
	select first_name, last_name, salary
	from employees.employees
	join employees.salaries using(emp_no);

SELECT *
from employee_salary;

-- Adds new column to frtuits temp table named quantity and the datatype is positive integers
ALTER TABLE fruits ADD quantity INT UNSIGNED;

ALTER TABLE fruits DROP COLUMN id;

SELECT * FROM fruits;
-- Update an entire column
UPDATE fruits
SET quantity = 10;

SELECT * FROM fruits;

-- update a specific row's column value

UPDATE fruits
SET quantity = quantity + 20
WHERE name = "Kiwi";

SELECT * FROM fruits;
-- change gala apple to red apple
UPDATE fruits
SET name = "Red Apple"
WHERE name = "Gala Apple";

SELECT * FROM fruits;