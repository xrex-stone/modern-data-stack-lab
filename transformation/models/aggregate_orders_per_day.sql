select date(order_date) as event_date, count(*) as count_of_record, sum(total_amount) as total_amount
from {{ ref('denormalized_orders') }}
group by date(order_date)