with source as (
    select * from {{source('olist','raw_geolocation')}}
)
select * from source