{% set payment_methods_query %}

select 
payment_method
from 
{{ ref('stg_stripe_payments') }} 
group by 1 
{% endset %}


{% set payment_methods = run_query(payment_methods_query) %}

{% if execute %}
{% set paymnet_method_results = payment_methods.columns[0].values() %}
{% endif %}

with payments as (
  select * 
  from {{ ref('stg_stripe_payments') }}

), 

pivot as (
  select 
    order_id,
    {% for payment_method in payment_method_results %}
    sum(case when payment_method = '{{ payment_method }}' then amount end) as {{ payment_method }}_amount,
    {% endfor %}
    'dummy' as dummy_column
  from payments
  group by 1
)


select *
from pivot



