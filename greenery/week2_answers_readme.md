## What is our user repeat rate?
- 79.83%
----

## What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

- I would imagine that users who have a good experience on the website (no reloads,accepts credit card on first try) would be someone who comes back. If the user is sent a promo code. I would like to see page load times and what ad channel brought them to our site.
---
## Explain the marts models you added. Why did you organize the models in the way you did?

-  added 3 folders to marts, core,marketing and product. In the marketing I tried to answer questions about the user_order information. In product I focused on events and top products based off views. In core I had more generic models around the user and orders.
---
## What assumptions are you making about each model? (i.e. why are you adding each test?)
- I am assuming that the primary key should be not null and unique. I didn't add this for every test but this would probably be a fair assumption.
---
## Did you find any “bad” data as you added and ran tests on your models?
- I did not but I'm sure I could have found something. 
---
## Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
- I would add more loaded_at fields to my sources and do more source freshness tests. I only added it for events and orders. I would notify stakeholders via slack bots since dbt cloud has a hookup to slacks api.