# PART 1
## What is our overall conversion rate?
``` sql 
SELECT 
ROUND(SUM(checkout)/COUNT(distinct session_id),3) as conversion_rate
FROM
dbt_andrew_w.int_session_events_agg
```
> 62.5%

## What is our conversion rate by product?
``` sql 
select * from 
dbt_andrew_w.int_conversion_rate_by_product......

```
Just listing the top 5 for convenience.

| Product Name      | Conversion Rate |
| ----------- | ----------- |
| String of pearls      | 60%       |
| 	Arrow Head   | 55%        |
| 	Cactus   | 55%        |
| 	ZZ Plant   | 52%        |
| 	Bamboo   | 52%        |

---

# Part 2:
## Create a macro to simplify part of a model(s)
The macro that I created was called aggregate_event_type.
It is just a helper function that calculates the number of event types that happen per session.

---
# Part 3:
## Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running CREATE ROLE reporting in your database instance.

Running  
```sql
SELECT grantee, privilege_type
FROM information_schema.role_table_grants
WHERE table_name='stg_events'
```

---
Part 4:
## Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project

I installed 3 and ended up using
the star macro from dbt_utils package. I also used some tests. I see a lot of use case for the codegen package though and if I had to make more staging tables I would use this.