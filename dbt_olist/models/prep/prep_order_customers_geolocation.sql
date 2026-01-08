with order_items as (
    select * from {{ ref('stg_order_items')}} ),
orders as (
    select * from {{ ref('stg_orders')}} ),
customers as (
    select * from {{ ref('stg_customers')}} ),
geolocation as (
    select * from {{ ref('stg_geolocation')}})
select * from order_items 
join orders 
    using (order_id)
join customers c
    using (customer_id)
join geolocation g
on c.customer_zip_code_prefix = g.geolocation_zip_code_prefix 