select 
session_id,
user_id,
date_trunc('day',created_at) as created_at_day,
{{ aggregate_event_type('page_view') }},
{{ aggregate_event_type('add_to_cart') }},
{{ aggregate_event_type('checkout') }},
{{ aggregate_event_type('package_shipped') }},
min(created_at) as session_start,
max(created_at) as session_end,
max(created_at) - min(created_at) as session_length
from {{ ref('stg_events') }} events
group by 1,2,3