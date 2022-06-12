
{{ config(materialized='view') }}

with source as (

    select * from {{ source('public', 'addresses') }}

),

renamed as (

    select
        address_id,
        address,
        zipcode,
        state,
        country

    from source

)

select * from renamed