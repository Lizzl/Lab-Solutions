#List number of films per category.

SELECT c.category_id, c.name, count(f.category_id) as Number_Films 
FROM sakila.film_category AS f 
LEFT JOIN sakila.category AS c
on f.category_id = c.category_id
GROUP BY c.category_id;


#Display the first and last names, as well as the address, of each staff member.

SELECT s.first_name , s.last_name, a.address
FROM sakila.staff AS s
LEFT JOIN sakila.address AS a
on s.address_id = a.address_id;


#Display the total amount rung up by each staff member in August of 2005.

SELECT sum(amount) as Amount From sakila.payment
WHERE payment_date LIKE "2005-08%";

SELECT s.staff_id, s.first_name , s.last_name, sum(p.amount) AS Total_Amount
FROM sakila.staff AS s
LEFT JOIN sakila.payment AS p
on s.staff_id = p.staff_id
WHERE payment_date LIKE "2005-08%" 
group by s.staff_id;


#List each film and the number of actors who are listed for that film.

SELECT f.film_id, f.title, count(a.actor_id) AS Number_Actors
FROM sakila.film AS f
LEFT JOIN sakila.film_actor AS a
on f.film_id = a.film_id
group by f.film_id, f.title;


#Using the tables payment and customer and the JOIN command, 
#list the total paid by each customer. 
#List the customers alphabetically by last name.

SELECT c.customer_id, c.first_name, c.last_name, sum(amount) AS Total_Amount
FROM sakila.customer AS c
LEFT JOIN sakila.payment AS p
on p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name ASC;


# Write a query to display for each store its store ID, city, and country.

SELECT s.store_id, t.city, n.country  
FROM sakila.store AS s
	INNER JOIN sakila.address AS a on s.address_id = a.address_id
	INNER JOIN sakila.city AS t on t.city_id = a.city_id
	INNER JOIN sakila.country AS n on n.country_id = t.country_id
GROUP BY s.store_id; 


#Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, sum(p.amount) AS Total_Amount
FROM sakila.customer AS c
	INNER JOIN sakila.store AS s on c.store_id = s.store_id
	INNER JOIN sakila.payment AS p on p.customer_id = c.customer_id
GROUP BY s.store_id;

#What is the average running time of films by category?
SELECT name AS category, round(avg(f.length)) AS Avg_Running_Time
FROM sakila.film AS f
	INNER JOIN sakila.film_category AS fc on f.film_id = fc.film_id
	INNER JOIN sakila.category AS c on c.category_id = fc.category_id
GROUP BY category;


#Which film categories are longest?

SELECT name AS category, round(avg(f.length)) AS Avg_Running_Time
FROM sakila.film AS f
	INNER JOIN sakila.film_category AS fc on f.film_id = fc.film_id
	INNER JOIN sakila.category AS c on c.category_id = fc.category_id
GROUP BY category
order by Avg_Running_Time DESC;

#Display the most frequently rented movies in descending order.

SELECT f.title, count(r.rental_id) AS Rental_Frequency
FROM sakila.film AS f
	INNER JOIN sakila.inventory AS i on f.film_id = i.film_id
	INNER JOIN sakila.rental AS r on i.inventory_id = r.inventory_id
GROUP BY f.title
order by Rental_Frequency DESC;

#List the top five genres in gross revenue in descending order.

SELECT c.name AS Genre, round(sum(p.amount)) AS Gross_Revenue
FROM sakila.category AS c
	INNER JOIN sakila.film_category AS fc on c.category_id = fc.category_id
	INNER JOIN sakila.film AS f on f.film_id = fc.film_id
	INNER JOIN sakila.inventory AS i on f.film_id = i.film_id
	INNER JOIN sakila.rental AS r on i.inventory_id = r.inventory_id
	INNER JOIN sakila.payment AS p on r.rental_id = p.rental_id
GROUP BY name
ORDER BY Gross_Revenue DESC
Limit 5;

#Is "Academy Dinosaur" available for rent from Store 1?

SELECT DISTINCT f.title, s.store_id
FROM sakila.film AS f
	INNER JOIN sakila.inventory AS i on f.film_id = i.film_id
	INNER JOIN sakila.store AS s on i.store_id = s.store_id
WHERE s.store_id = 1 AND f.title = 'Academy Dinosaur';


#Yes it is :)