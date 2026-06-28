with customers as (
    select * from {{ref('stg_customers')}}
),
orders as (
    select * from {{ref('stg_orders')}}
),
customer_order_aggregates as (
    select 
    customer_key,
    count(order_id) as total_orders,
    min(purchased_at) as first_order_at,
    max(purchased_at) as most_recent_order_at
    from orders
    group by customer_key
)

select 
  c.customer_id,c.customer_key,c.city,c.state,coalesce(coa.total_orders,0) as total_orders,coa.first_order_at,coa.most_recent_order_at
  from customers as c
  left join customer_order_aggregates as coa using (customer_key)