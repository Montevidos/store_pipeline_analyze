with prod_items_sellers as (
    select * from {{ ref('stg_products') }} 
    join {{ ref('stg_order_items') }} 
        using (product_id)
    join {{ ref('stg_sellers') }} 
        using (seller_id)
)
select * from prod_items_sellers