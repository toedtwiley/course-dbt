## Part 1. dbt Snapshots:
After inserting the new records we now see two additional rows along with the original 2 statues for that particular order_id. Below is what I added to order snapshots 
```sql
{% snapshot order_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='order_id',
      strategy='check',
      check_cols=['status'],
    )
  }}

  SELECT * FROM {{ source('public', 'orders') }}

{% endsnapshot %}
```
Here is how you can see the additional two rows:
```sql
select 
  * 
from snapshots.order_snapshot
  where order_id in  ('05202733-0e17-4726-97c2-0520c024ab85','914b8929-e04a-40f8-86ee-357f2be3a2a2');
```

## Part 2. Modeling challenge:
How are our users moving through the product funnel?
> Currently we have about an 81% add to cart rate from our page views. From those who add to cart about 77% checkout after adding to cart.

Which steps in the funnel have largest drop off points?
> Add to cart to checkout have the bigger dropoff currently. This is an area where we can start running A/B tests and see how promo pop ups or follow up emails effect the conversion rates.

#### additional dbt models:
I ended up creating a product_funnel model. The below exposure is what I defined for it.

```yml
version: 2

exposures:  
  - name: Product Funnel Dashboard
    description: >
      Models that are critical to our product funnel dashboard
    type: dashboard
    maturity: high
    owner:
      name: Andrew Wiley
      email: awiley@greenery.com
    depends_on:
      - ref('product_funnel')
```

## Part 3: Reflection questions:
### 3A. dbt next steps for you 
1. If your organization is thinking about using dbt, how would you pitch the value of dbt analytics engineering to a decision maker at your organization?
  > dbt allows you to define metrics in one central place as opposed to having a variety of reports with mismatched metric definitions. It allows for an analyst to implement software engineering practices to their analytics workflow easily. This allows for modularity, consistency, and knowledge sharing across the organizations.
2. If your organization is using dbt, what are 1-2 things you might do differently recommend to your organization based on learning from this course?
> I really want to start using more of the packages. The community has created some awesome stuff. I am also interested in trying to leverage some of the artifacts and use this for various SLA KPIs that our org has.

3. If you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?
> Currently doing analytics engineering :).
### 3B. Setting up for production / scheduled dbt run of your project
1. Currently my organization is using dbt cloud which has made it rather easy to upgrade, and configure our jobs. We still have to implement source freshness tests along with other tests. I also need to implement some post hooks to grant additional permissions for our users.
2. In my past organization the way we set it up was with airflow. Everything was done via dbt cli. We ran our main job on a nightly schecule at 8pm. Airflow was set up on AWS EKS (Kubernetes Services), we then created a docker image that had dbt set up and had created a variety of tags in the config of our models. These tags then ran against a specific airflow job. After dbt was updated we reran our BI layer to refresh all the workbooks.