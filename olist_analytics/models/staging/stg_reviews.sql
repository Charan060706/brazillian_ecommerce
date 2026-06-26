with source as (
    select * from {{source('olist','raw_reviews')}}
)
select * from source