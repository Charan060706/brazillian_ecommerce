with source as (
    select * from {{source('olist' ,'raw_customers')}}
)

select * from source