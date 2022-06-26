{{
  config(
    materialized='view'
  )
}}

select
    product_id,
    count(event_id) as number_of_views
from {{ ref('fct_page_views') }} 
group by 1