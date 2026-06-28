with orders as (
    select * from {{ref('stg_orders')}}
),
items as (
    select * from {{ref('stg_order_items')}}
),
payments as (
    select * from {{ref('stg_payments')}}
),

order_item_totals as (
    select order_id,count(product_id) as total_items_ordered,sum(price) as total_revenue,
    sum(freight_value) as total_freight_count
    from items
    group by order_id
),
order_payment_totals as (
    select order_id,sum(payment_value) as total_amount_paid
    from payments
    group by order_id
)

select 
 o.order_id,o.customer_key,o.order_status,o.purchased_at,o.delivered_at,
 coalesce(i.total_items_ordered,0) as total_items_ordered,
 coalesce(i.total_revenue,0) as item_revenue,
 coalesce(i.total_freight_count,0) as freight_cost,
 coalesce(p.total_amount_paid,0) as total_amount_paid,

 (coalesce(i.total_revenue,0) + coalesce(i.total_freight_count,0)) - COALESCE(p.total_amount_paid,0) as payment_deficit 

from orders as o
left join order_item_totals as i using (order_id)
left join order_payment_totals as p using (order_id)

