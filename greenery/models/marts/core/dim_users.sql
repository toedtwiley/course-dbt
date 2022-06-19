{{
  config(
    materialized='table'
  )
}}

select
    users.user_id,
    users.first_name,
    users.last_name,
    users.email,
    users.phone_number,
    users.created_at,
    users.updated_at,
    users.address_id,
    addresses.address,
    addresses.zipcode,
    addresses.state,
    addresses.country

    -- orders_per_user

from {{ ref('stg_users') }} users
left join {{ ref('stg_addresses') }} addresses
    on users.address_id = addresses.address_id
