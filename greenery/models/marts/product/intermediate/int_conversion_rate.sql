{{
  config(
    materialized='view'
  )
}}

select
   ROUND(SUM(checkout)/COUNT(distinct session_id),3) as conversion_rate
from {{ ref('int_session_events_agg') }} 