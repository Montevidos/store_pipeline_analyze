select customer_id,
    customer_state, 
    customer_city,
    count(order_id) as total_orders,
    sum(price) as total_revenue
from {{ ref('prep_order_customers_geolocation') }}
group by customer_id, customer_state, customer_city