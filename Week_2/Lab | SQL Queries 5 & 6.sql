#Drop column picture from staff.

ALTER TABLE staff DROP COLUMN picture;




#A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

SELECT * FROM sakila.staff; 

SELECT * FROM sakila.customer WHERE first_name= 'TAMMY' AND last_name = 'SANDERS' ;

INSERT INTO staff (first_name,last_name,address_id, store_id,active, email, username) 
VALUES (SELECT from sakila.customer limit 1)

SELECT * FROM sakila.staff WHERE first_name= 'TAMMY' AND last_name = 'SANDERS' ;



VALUES ('Tammy', 'Sanders', 79, 2, 1, 
'tammy.sanders@sakilacustomer.org','Tammy');

SELECT * FROM sakila.staff WHERE first_name= 'TAMMY' AND last_name = 'SANDERS' ;



#Add rental for movie "Academy Dinosaur" by Charlotte Hunter(customer) from Mike Hillyer(staff) at Store 1 today.

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id) 
VALUES ('2020-10-28', 1, 130,1);

SELECT * FROM sakila.rental WHERE inventory_id = 1; 

CREATE Table test
SELECT * FROM sakila.customer;





#Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, 
#and the date the user was deleted.

DROP TABLE IF EXISTS deleted_user;

#CREATING BACKUP FOR customers 1 approach
CREATE Table deleted_user
SELECT customer_id, email  FROM sakila.customer
WHERE active = 0;

DELETE FROM customer WHERE active = 0;







