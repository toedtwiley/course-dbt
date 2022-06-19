{{
  config(
    materialized='view'
  )
}}

select
  order_id,
  sum(quantity) AS total_quantity_per_order
from {{ ref('fct_order_items') }}
group by 1