{{
  config(
    materialized='view'
  )
}}

select
    product_id,
    count(distinct order_id) as num_orders
from {{ ref('fct_order_items') }} 
group by 1
