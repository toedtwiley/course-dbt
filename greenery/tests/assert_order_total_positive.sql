select
    order_id,
    sum(order_total_before_discount) as total_amount
from {{ ref('fct_orders' )}}
group by 1
having not(sum(order_total_before_discount) >= 0)