## 1.How many users do we have?
``` sql 
SELECT 
  COUNT(user_id) AS user_count
FROM dbt_andrew_w.stg_users
```
>**ANSWER**: 130

---
## 2. On average, how many orders do we receive per hour?
``` sql 
WITH base AS (
  SELECT 
    DATE_TRUNC('hour',created_at) AS the_hour,
    COUNT(DISTINCT order_id) AS num_orders
  FROM dbt_andrew_w.stg_orders
    GROUP BY 1
)

SELECT 
  AVG(num_orders)
FROM base
```
>**ANSWER**: 7.5208333333333333
---
## 3. On average, how long does an order take from being placed to being delivered?
``` sql 

WITH base AS (
  SELECT 
    order_id,
    created_at,
    delivered_at,
    delivered_at - created_at AS difference
  FROM dbt_andrew_w.stg_orders
    WHERE delivered_at IS NOT NULL
)

SELECT 
  AVG(difference)
FROM base
```
>**ANSWER**: 3 days 21:24:11.803279
---
## 4. How many users have only made one purchase? Two purchases? Three+ purchases?
 **Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.**
``` sql 
WITH orders_per_user_id AS (
  SELECT
    user_id,
    COUNT(order_id) AS users_total_orders
  FROM dbt_andrew_w.stg_orders
    GROUP BY 1
)

SELECT
  users_total_orders number_of_purchases,
  COUNT(user_id) total_users
FROM orders_per_user_id
  GROUP BY 1
  ORDER BY 1 ASC
```
**ANSWER**: 
| # of Purchases| # of Users |
| ------------- |:-------------:|
| 1 |25|
| 2 |28|
| 3 |34|
| 4 |20|
| 5 |10|
| 6 |2|
| 7 |4|
| 8 |1|
---
## 5. On average, how many unique sessions do we have per hour?
``` sql 
WITH unique_sessions_by_hour AS (
 SELECT 
    DATE_TRUNC('hour',created_at) AS the_hour,
    COUNT(distinct session_id) AS unique_sessions
  FROM dbt_andrew_w.stg_events
    GROUP BY 1
)
SELECT 
  AVG(unique_sessions)
FROM unique_sessions_by_hour
```
>**ANSWER**: 16.3275862068965517