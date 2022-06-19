{{
  config(
    materialized='view'
  )
}}

select
  events.event_id,
  events.session_id,
  events.user_id,
  events.product_id,
  products.name
from {{ ref('stg_events') }} events
left join {{ ref('stg_products') }} products
    on events.product_id = products.product_id
where event_type = 'page_view'
