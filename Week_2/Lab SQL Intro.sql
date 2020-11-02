#SHOW Tables, click database and tables

SHOW tables;

# Explore tables. (select everything from each table)

SELECT * FROM actor; 

SELECT * FROM sakila.film; 

# Select one column from a table. Get film titles.
SELECT title FROM sakila.film LIMIT 10;

# Select one column from a table and alias it. Get languages. This is interesting if I export my query
SELECT name AS language_name FROM sakila.language; 

#How many stores does the company have?
SELECT COUNT(store_id) FROM sakila.store;

#Doublecheck
SELECT * FROM sakila.store;

#Count employees
SELECT COUNT(staff_id) FROM sakila.staff;

#Show names of employees
SELECT first_name, last_name FROM sakila.staff;

#PART II

#Select all the actors with the first name ‘Scarlett’.

SELECT DISTINCT * FROM sakila.actor WHERE first_name = 'Scarlett';

#Select all the actors with the last name ‘Johansson’.

SELECT DISTINCT * FROM sakila.actor WHERE last_name = 'Johansson';

#How many films (movies) are available for rent?

SELECT DISTINCT return_date from sakila.rental ORDER BY return_date DESC; 

SELECT rental_id AS available from sakila.rental WHERE return_date < '2020-10-26 15:22:00';

#SELECT count(rental_id) AS rented from sakila.rental WHERE return_date > rental_date; 
# all of them are available for rent

#How many films have been rented?
SELECT rental_id AS rented_out FROM sakila.rental WHERE return_date > '2020-10-26 15:22:00';


#What is the shortest and longest rental period?

SELECT rental_duration FROM sakila.film ORDER BY rental_duration ASC LIMIT 1;  

SELECT rental_duration FROM sakila.film ORDER BY rental_duration DESC LIMIT 1;  


#What are the shortest and longest movie duration? Name the values max_duration and min_duration.

SELECT length AS max_duration FROM sakila.film ORDER BY length DESC LIMIT 1;  

SELECT length AS min_duration FROM sakila.film ORDER BY length ASC LIMIT 1;  


#What's the average movie duration?

SELECT AVG(length) FROM sakila.film;

#What's the average movie duration expressed in format (hours, minutes)?

SELECT CONCAT(FLOOR(AVG(length)/ 60), ":" , ROUND((AVG(length)%60), 0)) as AverageDuration from sakila.film;

#How many movies are longer than 3 hours?

SELECT count(length) FROM sakila.film WHERE length > 180; 

#Get the name and email formatted. Example: Mary SMITH - mary.smith@sakilacustomer.org.

SELECT email from sakila.customer LIMIT 20; 

SELECT lower(email) AS email from sakila.customer LIMIT 20; 

#### How to capitalize the first letter??###
SELECT CAPITALIZE(first_name) AS First_Name, CAPITALIZE(last_name) AS Last_Name FROM sakila.customer LIMIT 20; 

#What's the length of the longest film title?

SELECT LENGTH(title) AS len FROM sakila.film_text 
ORDER BY len DESC LIMIT 1;


