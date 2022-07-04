
WITH events_aggregated as (
  SELECT
  SUM(CASE WHEN page_view>0 THEN 1 ELSE 0 END) as total_page_views,
  SUM(CASE WHEN add_to_cart>0 THEN 1 ELSE 0 END) as total_add_to_carts,
  SUM(CASE WHEN checkout>0 THEN 1 ELSE 0 END) as total_checkouts
  FROM
    {{ ref('int_session_events_agg') }}
)

SELECT 
  ROUND((total_add_to_carts*100.00)/(total_page_views*100.00),2) as add_to_cart_rate,
  ROUND((total_checkouts*100.00)/(total_page_views*100.00),2) as checkout_rate,
  total_page_views,
  total_add_to_carts,
  total_checkouts
FROM
events_aggregated
