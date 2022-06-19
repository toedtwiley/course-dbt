{{
  config(
    materialized='table'
  )
}}

select
    order_items.order_id,
    order_items.product_id,
    order_items.quantity,

    products.name,
    products.price as price_per_product,
    order_items.quantity * products.price as price_for_product_per_order
from {{ ref('stg_order_items') }} order_items
left join {{ ref('stg_products') }} products
    on order_items.product_id = products.product_id
