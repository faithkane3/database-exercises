3.9_temporary_tables.sql

-- 1. Using the example from the lesson, re-create the employees_with_departments table.

    -- a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
    -- b. Update the table so that full name column contains the correct data
    -- c. Remove the first_name and last_name columns from the table.
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

