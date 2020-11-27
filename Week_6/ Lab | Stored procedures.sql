
delimiter //
create procedure customer_action_movie ()
begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
end;
// delimiter ; 

#Now keep working on the previous stored procedure to make it more dynamic. 
#Update the stored procedure in a such manner that it can take a string argument for the category name and return the 
#results for all customers that rented movie of that category/genre. For eg., 
#it could be action, animation, children, classics, etc.

drop procedure if exists customer_category_movie;
delimiter //
create procedure customer_category_movie (in param1 VARCHAR(100))
begin
  select first_name, last_name, email 
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = param1
  group by first_name, last_name, email;
end;
// delimiter ; 

call customer_category_movie('Animation');



#Write a query to check the number of movies released in each movie category. 
#Convert the query in to a stored procedure to filter only those categories that have movies 
#released greater than a certain number. Pass that number as an argument in the stored procedure.

drop procedure if exists number_p_category;
delimiter //

create procedure number_p_category (IN param2 int)
begin
select c.name, count(*) as category_counts from film_category fc
join category c using (category_id)
group by category_id
Having category_counts > param2;
end;
//
delimiter ;


call number_p_category(30);


 #HINT : insert an IN param2 int into your initial definition of the stored procedure, and a clause into the query 
 #where category_counts > param2
 # before calling the procedure with that param 
 
 

