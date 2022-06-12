
{{ config(materialized='view') }}

with source as (

    select * from {{ source('public', 'promos') }}

),

renamed as (

    select
        promo_id,
        discount,
        status

    from source

)

select * from renamed
