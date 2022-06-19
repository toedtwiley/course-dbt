select 
session_id,
user_id,
date_trunc('day',created_at) as created_at_day,
sum(case when event_type = 'page_view' then 1 else 0 end) as page_views,
sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart,
sum(case when event_type = 'checkout' then 1 else 0 end) as checkout,
sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped,
min(created_at) as session_start,
max(created_at) as session_end,
max(created_at) - min(created_at) as session_length
from {{ ref('stg_events') }} events
group by 1,2,3