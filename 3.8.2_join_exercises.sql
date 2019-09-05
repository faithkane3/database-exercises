3.8.2_join_exercises.sql

-- 1. Use the join_example_db. Select all the records from both the users and roles tables.
use join_example_db;
SELECT * FROM users;
SELECT * FROM roles;
-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
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
-- 3. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT roles.name as roles, count(users.id) as employee_count
FROM users
LEFT JOIN roles
ON users.role_id=roles.id
GROUP BY roles;