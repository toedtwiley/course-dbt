{{
  config(
    materialized='view'
  )
}}

select 
  products.product_id,
  name as product_name,
  number_of_views,
  num_orders,
  ROUND((100.0 *num_orders)/(100.0 *number_of_views),3) as conversion_rate
from
  {{ ref('dim_products') }} products
left join {{ ref('int_page_views_by_product') }} 
  on products.product_id = int_page_views_by_product.product_id
left join {{ ref('int_orders_per_product') }} 
  on products.product_id = int_orders_per_product.product_id
order by conversion_rate desc
