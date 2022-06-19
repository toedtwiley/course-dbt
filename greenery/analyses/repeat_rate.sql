
select  
COUNT(CASE WHEN total_orders > 1 THEN user_id END) total_repeat_users,
COUNT(user_id),
COUNT(CASE WHEN total_orders > 1 THEN user_id END)::float/COUNT(user_id)::float
from {{ ref('fct_user_orders') }}