{{
  config(
    materialized='table'
  )
}}

select
  orders.*,
  dim_users.first_name,
  dim_users.last_name,
  dim_users.email,
  dim_users.state,
  dim_users.country,
  promos.discount,
  promos.status as promo_status,

  orders.order_total + promos.discount as order_total_before_discount,
  orders.delivered_at - orders.created_at as days_to_deliver,
  total_quantity_per_order

from {{ ref('stg_orders') }} orders
left join {{ ref('dim_users') }} dim_users
    on orders.user_id = dim_users.user_id
left join {{ ref('stg_promos') }} promos
    on orders.promo_id = promos.promo_id
left join {{ ref('int_units_per_order') }} units_per_order
    on orders.order_id = units_per_order.order_id
