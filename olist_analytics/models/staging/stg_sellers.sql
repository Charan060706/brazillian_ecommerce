with source as (
    select * from {{source('olist','raw_sellers')}}
)
select * from source