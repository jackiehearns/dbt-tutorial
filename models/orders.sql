Select 
orders.order_id as order_id,
orders.customer_id as customer_id,
payments.amount as amount

from 
{{ ref('stg_orders') }} as orders

inner join {{ ref('stg_payments') }} as payments 
    on payments."orderID"=orders.order_id