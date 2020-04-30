

{% macro test_unique(model) %}

{% set column_name = kwargs.get('column_name', kwargs.get('arg')) %}

with validation_errors as 
(
        select
        {{ column_name }}

    from {{ model }}
    where {{ column_name }} is not null
    group by {{ column_name }}
    having count(*) > 1
)

select count(*)
from validation_errors

--updated macro

{% endmacro %}