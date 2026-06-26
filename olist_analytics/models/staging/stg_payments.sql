with source as (
    select * from {{source('olist','raw_payments')}}
)
select * from source