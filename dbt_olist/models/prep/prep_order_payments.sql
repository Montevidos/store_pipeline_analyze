select * from {{ref('stg_order_payments')}}
join {{ref('stg_orders')}}
    using (order_id)
    