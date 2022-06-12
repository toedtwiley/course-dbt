{{ config(materialized='view') }}

with source as (

    select * from {{ source('public', 'order_items') }}

),

renamed as (

    select
        order_id,
        product_id,
        quantity

    from source

)

select * from renamed