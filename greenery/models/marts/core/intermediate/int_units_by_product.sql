{{
  config(
    materialized='view'
  )
}}

with total_units_by_product as (
select
    order_items.product_id,
    sum(quantity) as total_units_sold
from {{ ref('fct_order_items') }} order_items
group by 1
)
select 
  total_units_by_product.*,
  row_number() over(order by total_units_sold desc) as product_popularity
from total_units_by_product
