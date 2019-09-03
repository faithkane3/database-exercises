-- show all databases I have access to
show databases;

-- mysql.user means use the mysql database and read from the user TABLE
select * from mysql.user;

-- select the user and host columns from the user table
select user, host from mysql.user;

-- select all columns from the help_topic table on the mysql database
select * from mysql.help_topic;

-- select only the help_topic_id, help_category_id, and url columns from help_topic table on mysql db
select help_topic_id, help_category_id, url from mysql.help_topic;