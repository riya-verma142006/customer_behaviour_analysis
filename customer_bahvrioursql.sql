select * from customer;

--
select gender, sum(purchase_amount) 
from customer
group by gender;

select item_purchased,
round(100* sum(case when discount_applied = 'Yes' then 1 else 0 end)/ count(*) , 2) as discount_rate
from customer
group by item_purchased
order by discount_rate desc 
limit 5;

select * from customer;

WITH
	CUSTOMER_TYPE AS (
		SELECT
			CUSTOMER_ID,
			PREVIOUS_PURCHASES,
			CASE
				WHEN PREVIOUS_PURCHASES = 1 THEN 'new'
				WHEN PREVIOUS_PURCHASES BETWEEN 1 AND 3  THEN 'returning'
				ELSE 'loyal'
			END AS CUSTOMER_SEGMENT
		FROM
			CUSTOMER
	)

select customer_segment, count(*) as "number_of_customer"
from customer_type
group by customer_segment;

select * from customer;

select category ,max(purchase_amount) as nn
from customer
group by category
limit 5;

with item_count as (
select category, item_purchased,
count (customer_id) as total_orders,
row_number() over (partition by category order by count(customer_id) desc) as item_rank
from customer
group by category, item_purchased
)

select category,item_purchased, item_rank,total_orders
 from item_count
 where item_rank <= 3;


select subscription_status,
count(customer_id) as repeat_buyer
from customer
where previous_purchases >= 5
group by subscription_status;

select age_group,
sum(purchase_amount) as total_revenue
from customer
group by age_group
order by total_revenue;





