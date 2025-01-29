---------------------- Gett Taxi Project ----------------------------------
--- Creating Table taxi orders

CREATE TABLE taxi_orders (
	order_datetime varchar(50),
	order_longitude decimal(10,7),
	order_latitude  decimal(10,7),
	order_eta  decimal(10,4) ,
	order_id varchar(50),
    order_status  varchar(50),
    is_driver_assigned   varchar(50),
    cancellation_time_in_sec  varchar(10) );
	

--- creating table taxi_offers

CREATE TABLE taxi_offers (
	order_id varchar(50),
	offer_id varchar(50));
	
--- Then imported data into taxi_orders , taxi_offers
------------------------------------------------------------------------------------------------------
	
--- Check for Total Duplicates Across All Columns (taxi_orders)

select 
	order_datetime,
	order_longitude,
	order_latitude,
	order_id,
	order_eta,
	order_status,
	is_driver_assigned,
	cancellation_time_in_sec , count(*) as duplicate_num
from taxi_orders
group by order_datetime,
	order_longitude,
	order_latitude,
	order_id,
	order_eta,
	order_status,
	is_driver_assigned,
	cancellation_time_in_sec
having count(*) > 1 ;

--- has per result no duplicates 

--- check for duplicates in order_id column has each order_id is supposed to be unique (taxi_orders)

SELECT order_id, 
       COUNT(*) AS duplicate_num
FROM taxi_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

---- No duplicates in order_id 

---- Check for duplicates in taxi_offers table

-- check for total duplicates across all columns (taxi_offers)

select order_id  , offer_id , count(*) as duplicate_num
from taxi_offers 
group by 1,2
having count(*) > 1 ;
	
--- no duplicates return 

--- lets check for duplicates in offer_id 
select 
*
from taxi_offers 
where offer_id in 
			(select offer_id 
			 from taxi_offers 
			 group by offer_id 
			 having count(*) > 1) 
order by offer_id ;

--- no values return means no duplicates

--- will not check for duplicates in order_id in taxi_offers table because a single taxi booking order_id 
--- can have multiple offers 

-----------------------------------------------------------------------------------------------------------------------------------------------------

---- lets check for missing values in both tables 

--- missing rows count in each column of taxi_orders

select 
  sum(case when order_datetime isnull then 1 else 0 end) as order_datetime_nulls,
  sum(case when order_longitude isnull then 1 else 0 end) as order_longitude_nulls,
  sum(case when order_latitude isnull then 1 else 0 end) as order_latitude_nulls,
  sum(case when order_eta isnull then 1 else 0 end) as order_eta_nulls,
  sum(case when order_id isnull then 1 else 0 end) as order_id_nulls,
  sum(case when order_status isnull then 1 else 0 end) as order_status_nulls,
  sum(case when is_driver_assigned isnull then 1 else 0 end ) as is_driver_assigned_nulls,
  sum(case when cancellation_time_in_sec isnull then 1 else 0 end) as cancellation_time_in_sec_nulls
from taxi_orders;

--- Null values are  present in order_eta column (7902) and cancellation_time_in_sec_nulls (3409)

--- checking count of nulls when driver was not assigned 
select 	
	sum(case when order_eta isnull then 1 else 0 end) as order_eta_nulls,
    sum(case when order_id isnull then 1 else 0 end) as order_id_nulls,
    sum(case when is_driver_assigned isnull then 1 else 0 end ) as is_driver_assigned_nulls,
    sum(case when cancellation_time_in_sec isnull then 1 else 0 end) as cancellation_time_in_sec_nulls
from taxi_orders
where order_status = '9' ;


--- checking count of nulls when order was rejected by system 
select 
	sum(case when order_eta isnull then 1 else 0 end) as order_eta_nulls,
	sum(case when cancellation_time_in_sec isnull then 1 else 0 end) as cancellation_time_in_sec_nulls
from taxi_orders 
where order_status = '4' 

--- Leaving the cancellation_time_in_sec as NULL for rejected orders the number of such order is 3409 that is all nulls in cancellation_time_in_sec
--- Leaving the order_eta nulls as is because 3406 null are there when order was rejected by system as order is rejected it will be null and 
--- when rest are when the driver was not assigned to users , so it makes sense it leave it as is.


--- checking for nulls in taxi_offers table
select 
	sum(case when order_id isnull then 1 else 0 end) as order_id_nulls,
	sum(case when offer_id isnull then 1 else 0 end) as offer_id_nulls
from taxi_offers

-- has zero nulls in both the columns 

-----------------------------------------------------------------------------------------------------------------------------------------------------

--- updating values in order_status & is_driver_assigned to text for better readibility

UPDATE taxi_orders
SET order_status = 'client cancellation'
WHERE order_status = '4';

UPDATE taxi_orders
SET order_status = 'system rejection'
WHERE order_status = '9';

UPDATE taxi_orders
SET is_driver_assigned = 'yes'
WHERE is_driver_assigned = '1';

UPDATE taxi_orders
SET is_driver_assigned = 'no'
WHERE is_driver_assigned = '0';

----------------------------------------------------------------------------------------------------------------------------------------------------

--- changing column name & setting right data type to columns

--- changing order_datetime to order_time
ALTER TABLE taxi_orders
RENAME COLUMN order_datetime TO order_time;

--- Formatting Data Correctly 
UPDATE taxi_orders
SET cancellation_time_in_sec = split_part(cancellation_time_in_sec, '.', 1);

UPDATE taxi_orders
SET order_eta = ROUND(order_eta);

--- changing data types 
ALTER TABLE taxi_orders
ALTER COLUMN order_eta TYPE smallint;

ALTER TABLE taxi_orders
ALTER COLUMN cancellation_time_in_sec
TYPE smallint
USING cancellation_time_in_sec::smallint;

--- This checks for a valid time format
SELECT order_time
FROM taxi_orders
WHERE order_time NOT LIKE '__:__:__'; 

--- changing data type of order time to time only 

ALTER TABLE taxi_orders
ALTER COLUMN order_time TYPE TIME USING order_time::TIME;
----------------------------------------------------------------------------------------------------------------------------------------------------

--- checking for outliers or errors &  data validation in the data

select distinct order_status from taxi_orders;       --- order_status free from error & outliers

select distinct is_driver_assigned from taxi_orders;     --- is_driver_assigned free from error & outliers

SELECT DISTINCT EXTRACT(HOUR FROM TO_TIMESTAMP(order_time,'HH24:MI:SS')::time) AS order_hour
FROM taxi_orders
order by 1;         ---- hours are in the 24-hour format  , no outliers or error

SELECT * FROM taxi_orders ; 
SELECT * FROM taxi_offers ;
----------------------------------------------------------------------------------------------------------------------------------------------------





