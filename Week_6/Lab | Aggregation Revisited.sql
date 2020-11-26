#Select the first name, last name, and email address of all 
#the customers who have rented a movie.

SELECT c.first_name, c.last_name, c.email, count(r.rental_id) AS Number_Rentals
FROM customer AS c
LEFT JOIN rental AS r
ON c.customer_id = r.customer_id
WHERE rental_id <> 0 
GROUP BY c.last_name, c.first_name, c.email
ORDER BY Number_Rentals DESC;

#What is the average payment made by each customer (display the customer id, 
#customer name (concatenated), 
#and the average payment made).

SELECT round(AVG(amount),2) AS AVG_Payment, c.customer_id, CONCAT(c.first_name, " ", c.last_name) AS Customer_Name
FROM customer AS c
LEFT JOIN payment AS p
USING (customer_id)
GROUP BY Customer_Name, customer_id;

SELECT * FROM category;


#Select the name and email address of all the customers who have rented the "Action" movies.
#Write the query using multiple join statements

#Write the query using sub queries with multiple WHERE clause and IN condition


#Verify if the above two queries produce the same results or not
#Action movies have category_id = 1


#Write the query using multiple join statements
SELECT CONCAT(c.first_name, " ", c.last_name) AS Customer_Name, c.email, fc.category_id
FROM customer AS c
	INNER JOIN rental AS r USING (customer_id)
    INNER JOIN inventory AS i USING (inventory_id)
    INNER JOIN film AS f USING (film_id)
	INNER JOIN film_category AS fc USING (film_id)
WHERE category_id = 1
GROUP BY  Customer_Name, c.email
ORDER BY Customer_Name;

#returns 510 rows




#Subquery 1

SELECT fc.film_id FROM film_category as fc
WHERE fc.category_id = 1;


#Subquery 2

SELECT i.inventory_id FROM inventory AS i 
WHERE i.film_id IN 
(
SELECT fc.film_id FROM film_category as fc
WHERE fc.category_id = 1
);


#Subquery 3
SELECT r.customer_id FROM rental as r
WHERE r.customer_id IN
(
SELECT i.inventory_id FROM inventory AS i 
WHERE i.film_id IN 
(
SELECT fc.film_id FROM film_category as fc
WHERE fc.category_id = 1
)
);

#Main query

SELECT CONCAT(c.first_name, " ", c.last_name) AS Customer_Name, c.email
FROM customer AS c
WHERE c.customer_id IN
(
SELECT r.customer_id FROM rental as r
WHERE r.inventory_id IN
(
SELECT i.inventory_id FROM inventory AS i 
WHERE i.film_id IN 
(
SELECT fc.film_id FROM film_category as fc
WHERE fc.category_id = 1
)
)
)
;

SELECT DISTINCT(CONCAT(first_name, " ", last_name)) AS customer_name, email
FROM customer
WHERE customer_id IN
(
SELECT customer_id
FROM rental
WHERE inventory_ID IN
(
SELECT inventory_id
FROM inventory
WHERE film_id IN
(
SELECT film_id
FROM film_category
WHERE category_id = 1
)
)
);



#Returns 18 rows, they don't produce the same results. 
#I assume this is because I used IN, which does not take into account
#that 1 customer could have rented different movies with the genre Actions
#(I would never use so many subqueries anyway, that is very messy
#probably I made a mistake along the wa...)




#Use the case statement to create a new column classifying existing 
#columns as either or high value transactions based on the amount of payment. 
#If the amount is between 0 and 2, label should be low and if the amount is between 
#2 and 4, the label should be medium, and if it is more than 4, then it should be high


#DIdn't work....
#ALTER TABLE payment
#ADD COLUMN transaction_class VARCHAR(59);

#SELECT amount, transaction_class
#CASE
    #WHEN amount BETWEEN 0 AND 2 THEN INSERT INTO transaction_class VALUES ('low')
    #WHEN amount BETWEEN 0 AND 2T INTO transaction_class VALUES ('medium')
    #ELSE INSERT INTO transaction_class  VALUES ('high')
#END
#FROM payment;


SELECT amount, CASE WHEN amount BETWEEN 0 AND 2 THEN "low"
WHEN amount BETWEEN 0 AND 2 THEN "medium"
else "high" END AS label
from payment;


