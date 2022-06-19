-- for each products how many people bought,
-- how many units were sold
-- how many page views,


{{
  config(
    materialized='table'
  )
}}

select
    products.product_id,
    products.name,
    products.price,
    products.inventory,
    product_popularity.total_units_sold,
    product_popularity.product_popularity

from {{ ref('stg_products') }} products
left join {{ ref('int_units_by_product') }} product_popularity
    on products.product_id = product_popularity.product_id
left join {{ ref('int_page_views_by_product') }} int_page_views_by_product
    on products.product_id = int_page_views_by_product.product_id
