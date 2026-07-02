with source as (
    select * from {{source('olist','raw_category_translation')}}
)
select * from source


