with products as (
    select * from {{ref('stg_products')}}
),
translations as (
    select * from {{ref('stg_translations')}}
)

select p.product_id,
coalesce(t.product_category_name_english,p.product_category_name) as product_category_name,
p.product_name_lenght as product_name_length,
p.product_description_lenght as product_descreption_length,
p.product_photos_qty as product_photos_count,
p.product_weight_g as weight_grams,
p.product_length_cm as length_cm,
p.product_height_cm as height_cm,
p.product_width_cm as width_cm
from products as p
left join translations as t on p.product_category_name = t.product_category_name