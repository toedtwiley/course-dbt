
{{ config(materialized='view') }}

with source as (

    select * from {{ source('public', 'products') }}

),

renamed as (

    select
        product_id,
        name,
        price,
        inventory

    from source

)

select * from renamed
