with customers as (
    select * from {{ref('stg_customers')}}
),
orders as (
    select * from {{ref('stg_orders')}}
),
orders_with_human_id as (
    select
    o.order_id,c.customer_id,o.purchased_at from orders as o
    join customers as c using (customer_key)
),
customer_order_aggregates as (
    select 
    customer_id,
    count(order_id) as total_orders,
    min(purchased_at) as first_order_at,
    max(purchased_at) as most_recent_order_at
    from orders_with_human_id
    group by customer_id
),
deduplicated_customer_profile as (
    select customer_id,city,state,
    row_number()over(partition by customer_id order by customer_key) as rn
    from customers
)

select 
  p.customer_id,p.city,p.state,coalesce(coa.total_orders,0) as total_orders,coa.first_order_at,coa.most_recent_order_at
  from deduplicated_customer_profile as p
  left join customer_order_aggregates as coa using (customer_id)
  where p.rn = 1