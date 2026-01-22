-- This macro is called discounted_amount

-- The formula takes extended_price and discount_percentage to generate discounted_amount

{% macro discounted_amount(extended_price, discount_percentage, scale=2) %}
    ( -1 * {{ extended_price }} * {{discount_percentage}})::decimal(16, {{ scale }})
{% endmacro %}

