{{
  config(
    materialized='view'
  )
}}

select
    product_id,
    count(event_id)
from {{ ref('fct_page_views') }} 
group by 1