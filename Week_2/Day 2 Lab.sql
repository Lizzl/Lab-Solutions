# How many distinct (different) actors' last names are there?

SELECT actor_id, last_name FROM sakila.actor;

SELECT DISTINCT count(last_name) FROM sakila.actor;

# In how many different languages where the films originally produced? 
#(Use the column language_id from the film table)

SELECT language_id FROM sakila.film;

SELECT DISTINCT count(language_id) FROM sakila.film;

#How many movies were released with "PG-13" rating?

SELECT count(*) FROM sakila.film WHERE rating = "PG-13";

# Get 10 the longest movies from 2006.

SELECT title, length FROM sakila.film WHERE release_year = "2006" ORDER BY length DESC LIMIT 10;

# How many days has been the company operating (check DATEDIFF() function)?
#get max and min and then use DATEDIFF

SELECT rental_date FROM sakila.rental ORDER BY rental_date ASC LIMIT 1;

SELECT  DATEDIFF('2005-05-24','2005-06-24');

# Show rental info with additional columns month and weekday. Get 20.

SELECT rental_id,  DATE_FORMAT(rental_date, '%M') AS month, DATE_FORMAT(rental_date, '%W') AS weekday from sakila.rental LIMIT 20;

# Add an additional column day_type with values 'weekend' and 'workday' depending on 
#the rental day of the week.

SELECT rental_id,  DATE_FORMAT(rental_date, '%M') AS month, DATE_FORMAT(rental_date, '%W') AS weekday, CASE
	WHEN DATE_FORMAT(rental_date, '%w') BETWEEN 1 AND 5 THEN 'workday'
    ELSE 'weekend'
END AS  day_type
from sakila.rental;


#How many rentals were in the last month of activity?
#GET MAX and MIN and then do the count

SELECT  count(*) FROM sakila.rental WHERE CONVERT(rental_date,DATE) BETWEEN '2005-08-23' AND '2006-02-14';

###########LAB PART2 #################

#Get film ratings.

SELECT DISTINCT rating FROM sakila.film;

#Get release years.

SELECT release_year FROM sakila.film;


#Get all films with ARMAGEDDON in the title.

SELECT title FROM sakila.film WHERE title REGEXP 'armageddon';


#Get all films with APOLLO in the title

SELECT title FROM sakila.film WHERE title REGEXP 'apollo';

#Get all films which title ends with APOLLO.

SELECT title FROM sakila.film WHERE title LIKE '%_apollo';

#Get all films with word DATE in the title.
SELECT title FROM sakila.film WHERE title LIKE '% date';

#Get 10 films with the longest title.

SELECT title  FROM sakila.film order by length(title) DESC LIMIT 10;

#How many films include Behind the Scenes content?

select * from sakila.film;

SELECT title, special_features FROM sakila.film WHERE special_features = 'Behind the Scenes';

#List films ordered by release year and title in alphabetical order.

SELECT title, release_year from sakila.film ORDER BY release_year, title;


