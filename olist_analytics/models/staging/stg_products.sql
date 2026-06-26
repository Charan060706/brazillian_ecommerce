with source as (
    select * from {{source('olist','raw_products')}}
)
select * from source