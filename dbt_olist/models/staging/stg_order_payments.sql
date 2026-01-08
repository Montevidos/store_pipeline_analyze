select order_id,
    payment_sequential::integer as payment_sequential,
    payment_type,
    payment_installments::integer as payment_installments,
    payment_value::float as payment_value   
from {{ source('olist', 'raw_order_payments') }}