#Get number of monthly active customers.
#We want to know month to month how many customers did rentals. 

-- Get for each rental, the corresponding date, year and month

#wouldn't choose active from the customer table here, because I cannot clearly specify 
#at what time the user was active, whether it is a general characteristic, I would still
#probably link it to the rental table --> rental_dates to get an explicit time frame for the activity, 

#rental dates aer aready in sql datetime format

create view customer_activity as
SELECT customer_id, date_format(rental_date, '%m') as Activity_Month,
date_format(rental_date, '%Y') as Activity_year
from sakila.rental;

SELECT * FROM customer_activity;

-- get for every combination of year and month how many distinct customers where renting movies called “Active_users”.

create or replace view Monthly_active_users as
select Activity_Year, Activity_Month, count(distinct customer_id) as Active_Customers
from customer_activity
group by Activity_year, Activity_Month
order by Activity_year, Activity_Month;

SELECT * FROM Monthly_active_users;


#Active users in the previous month.

##lag(col1, n, default_value) over (partition by col2)

#there is null values, because the month are not continious


create or replace view Previous_ActU as 
  select Activity_year, Activity_Month, Active_Customers, 
  
  lag(Active_customers,1) over (partition by Activity_year) as Previous_Month 
  
  from Monthly_active_users;


Select * from Previous_ActU
where Previous_Month is not null;


#Percentage change in the number of active customers. this is wrong!!!

SELECT Activity_year, Activity_Month, Active_Customers, 
Previous_Month, Round(((Active_Customers - Previous_Month) / Active_Customers) * 100 , 2) AS Perc_Change
FROM Previous_ActU
where Previous_Month is not null;


#Retained customers every month / active users, which were still active the next month

with retained_customer as (
  select distinct customer_id , Activity_Month, Activity_year
  from customer_activity
)
select r1.Activity_year, r1.Activity_Month, count(distinct r1.customer_id) as Retained_customers
from retained_customer r1
join retained_customer r2
on r1.customer_id = r2.customer_id and r1.Activity_Month = r2.Activity_Month + 1
group by r1.Activity_Month, r1.Activity_year
order by r1.Activity_year, r1.Activity_Month;


