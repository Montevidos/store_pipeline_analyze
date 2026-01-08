with category_sales as (
    select product_id,
    PRODUCT_CATEGORY_NAME,
    order_id,
    (price+freight_value) as total_revenue
from {{ ref('prep_products_sales_sellers') }}
)
select product_id,
    PRODUCT_CATEGORY_NAME,
    count(order_id) as items_sold,
    sum(total_revenue) as total_revenue
from category_sales
group by product_id, PRODUCT_CATEGORY_NAME
order by 2 desc