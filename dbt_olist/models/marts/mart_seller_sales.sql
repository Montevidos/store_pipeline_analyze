select seller_id,
    seller_city,
    seller_state,
    count(order_id) as total_orders,
    sum(price + freight_value) as total_revenue
from {{ref('prep_products_sales_sellers') }}
group by seller_id, seller_city, seller_state