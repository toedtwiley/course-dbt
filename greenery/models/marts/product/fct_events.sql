{{
  config(
    materialized='view'
  )
}}

select
  {{ dbt_utils.star(from=ref('stg_events'), except=["page_url"],relation_alias='events') }},
  products.name
from {{ ref('stg_events') }} events
left join {{ ref('stg_products') }} products
    on events.product_id = products.product_id
