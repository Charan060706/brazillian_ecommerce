with source as (
    select * from {{source('olist','raw_order_items')}}
)
select * from source