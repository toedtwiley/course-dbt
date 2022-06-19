
{{
  config(
    materialized='table'
  )
}}

select
  user_id,
  count(order_id) AS total_orders,
  sum(case when promo_id is not null then 1 else 0 end) as promotions_used,
  sum(case when promo_id is not null and promo_status='active' then 1 else 0 end) as active_promotions_used,
  avg(order_total) as avg_order_total,
  avg(days_to_deliver) as avg_days_to_deliver,
  avg(total_quantity_per_order) as avg_quantity_per_order
from {{ ref('fct_orders') }}
group by 1