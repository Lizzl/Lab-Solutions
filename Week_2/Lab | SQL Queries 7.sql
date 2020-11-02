#In the table actor, which are the actors whose last names are not repeated? 
#For example if you would sort the data in the table actor by last_name, you would see that 
#there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. These three actors have the same last name. 
#So we do not want to include this last name in our output. Last name "Astaire" is present only one 
#time with actor "Angelina Astaire", hence we would want this in our output list.


SELECT min(first_name), last_name, count(*) AS unique_surnames
FROM sakila.actor
GROUP BY last_name
HAVING unique_surnames = 1
ORDER BY last_name;

#### ARASAN'S SOLUTION ###
USE sakila;
SELECT first_name, last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;


#Which last names appear more than once? 
#We would use the same logic as in the previous question but 
#this time we want to include the last names of the actors where the last name was present more than once


SELECT min(first_name), last_name, count(*) AS unique_surnames
FROM sakila.actor
GROUP BY last_name
HAVING unique_surnames > 1
ORDER BY last_name;

#Using the rental table, find out how many rentals were processed by each employee
SELECT staff_id, count(rental_id) AS number_rental
FROM sakila.rental
GROUP BY 1;

#1 refers to first column in the select statement#


## complain about the data set only one release_year### 
#Using the film table, find out how many films were released each year.

SELECT release_year, count(*) AS no_films
FROM sakila.film
GROUP BY 1;

#Using the film table, find out for each rating how many films were there.
SELECT rating, count(*) AS no_films
FROM sakila.film
GROUP BY 1;

#What is the mean length of the film for each rating type. 
#Round off the average lengths to two decimal places

SELECT rating, round(AVG(length),2) AS avg_length
FROM sakila.film
GROUP BY 1;

#Which kind of movies (rating) have a mean duration of more than two hours?

SELECT rating, round(AVG(length),2) AS avg_length
FROM sakila.film
GROUP BY 1
HAVING avg_length > 120 ;










