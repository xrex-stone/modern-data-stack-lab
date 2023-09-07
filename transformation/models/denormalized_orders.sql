

select o.*,
    {{ dbt_utils.star(from=source('mydb', 'customers'), except=["customer_id"]) }},
    {{ dbt_utils.star(from=source('mydb', 'products'), except=["product_id"]) }}
from {{ source('mydb', 'orders') }} o
left join {{ source('mydb', 'customers') }} c on o.customer_id=c.customer_id
left join {{ source('mydb', 'products') }} p on o.product_id=p.product_id