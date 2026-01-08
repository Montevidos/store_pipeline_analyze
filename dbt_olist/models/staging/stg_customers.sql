select customer_id,
         customer_unique_id,
         replace(trim(customer_zip_code_prefix), '"', '')::integer as customer_zip_code_prefix,
         customer_city,
         customer_state
from {{source('olist', 'raw_customers')}}