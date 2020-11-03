#How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT f.title, count(i.inventory_id) 
FROM sakila.inventory AS i, sakila.film as f
WHERE i.film_id = f.film_id AND i.film_id = 
(SELECT f.film_id FROM sakila.film AS f 
WHERE f.title = 'Hunchback Impossible')
GROUP BY f.title;

#just for checking the results
SELECT f.film_id, f.title FROM sakila.film AS f 
WHERE title = 'Hunchback Impossible';

SELECT count(inventory_id) from sakila.inventory
WHERE film_id = 439;


#List all films whose length is longer than the average of all the films.

#Define subquery: calculate average lengths of all film

SELECT AVG(length) from sakila.film;

#Main query
SELECT DISTINCT title, length from sakila.film 
WHERE length >
(SELECT AVG(length) from sakila.film)
ORDER BY length DESC;


#Use subqueries to display all actors who appear in the film Alone Trip.


#Subquery 1 
SELECT film_id FROM sakila.film
WHERE title = 'Alone Trip';

#Main Query
SELECT first_name, last_name FROM sakila.actor 
	WHERE actor_id IN (SELECT actor_id FROM film_actor
	WHERE film_id = (SELECT film_id FROM sakila.film
WHERE title = 'Alone Trip'));
        
#Alternative approach with temporary tables
#Join tables into temporary table

create temporary table sakila.actor_details
select  a.actor_id, a.first_name, a.last_name, fa.film_id
from sakila.actor AS a
join sakila.film_actor AS fa
on a.actor_id = fa.actor_id;

#Main query 
SELECT first_name, last_name FROM sakila.actor_details
WHERE film_id =
(SELECT film_id FROM sakila.film
WHERE title = 'Alone Trip');


#Sales have been lagging among young families, and you wish to target all 
#family movies for a promotion. Identify all movies categorized as family films.

#Subquery 

SELECT category_id FROM sakila.category
WHERE name = 'Family';

#Join tables as temporary table

drop temporary table if exists film_details;

create temporary table sakila.film_details
select  f.film_id, f.title, fc.category_id
from sakila.film AS f
join sakila.film_category AS fc
on f.film_id = fc.film_id;

SELECT * FROM sakila.film_details;


#Main query
SELECT title FROM sakila.film_details AS fd
WHERE fd.category_id = (SELECT c.category_id FROM sakila.category AS c
WHERE name = 'Family');


#Get name and email from customers from Canada using subqueries. 
#(I am doing it with both subsquery and temporary tables at once)

#join customer, address and city

drop temporary table if exists customer_details;

create temporary table sakila.customer_details
SELECT c.first_name, c.last_name, c.email, a.address, t.city, t.country_id
FROM sakila.customer AS c
	INNER JOIN sakila.address AS a on c.address_id = a.address_id
	INNER JOIN sakila.city AS t on t.city_id = a.city_id; 

#USE subquery on temporary table
SELECT * FROM sakila.customer_details as cd
WHERE cd.country_id = 
(SELECT c.country_id FROM sakila.country as c
WHERE country = 'Canada');


#Which are films starred by the most prolific actor? 
#Most prolific actor is defined as the actor that has acted in the most number of films. 
#First you will have to find the most prolific actor and then use that 
#actor_id to find the different films that he/she starred.

#Subquery 
SELECT actor_id from sakila.film_actor 
GROUP BY actor_id
ORDER BY count(film_id) DESC
LIMIT 1;


#Query of Subquery

SELECT film_id FROM film_actor
	WHERE actor_id = (SELECT actor_id from sakila.film_actor 
	GROUP BY actor_id
	ORDER BY count(film_id) DESC
	LIMIT 1);


#Main query
SELECT title FROM sakila.film
	WHERE film_id IN (SELECT film_id FROM film_actor
	WHERE actor_id = (SELECT actor_id from sakila.film_actor 
	GROUP BY actor_id
	ORDER BY count(film_id) DESC
	LIMIT 1));
        

#Films rented by most profitable customer. 
#You can use the customer table and payment table to find the most profitable customer 
#ie the customer that has made the largest sum of payments


#Subquery
SELECT customer_id, sum(amount) FROM payment
WHERE SUM(amount) = (SELECT MAX(amount) FROM payment)
GROUP BY customer_id;


SELECT customer_id FROM payment
GROUP BY customer_id
ORDER BY sum(amount) DESC
LIMIT 1;

drop temporary table if exists rental_details;

create temporary table sakila.rental_details
SELECT f.title, f.film_id, i.inventory_id, r.customer_id FROM sakila.film AS f
	INNER JOIN sakila.inventory AS i USING (film_id)
	INNER JOIN sakila.rental AS r USING (inventory_id);
    

SELECT title FROM film
WHERE film_id IN (SELECT inventory_id FROM inventory 
WHERE inventory_id = (SELECT customer_id FROM payment
ORDER BY sum(amount) DESC
LIMIT 1));






#Customers who spent more than the average payments.