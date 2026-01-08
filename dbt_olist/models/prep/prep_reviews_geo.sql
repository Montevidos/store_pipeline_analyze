with reviews_customers_geo as 
(select * from {{ ref('stg_order_reviews') }} r
join {{ ref('stg_orders') }} o
    using (order_id)
join {{ ref('stg_customers') }} c
    using (customer_id)
join {{ ref('stg_geolocation') }} g
 on c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
)
select * from reviews_customers_geo