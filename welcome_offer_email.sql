with customers as (select customer_id, email, first_name, last_name, birth_date, language, country)
from el),

orders as (select order_id, customer_id, order_ts, tickets_quantity, voucher_code, travel_to_country, travel_from_country, travel_to_city, travel_from_city, time_of_departure, time_of_arrival, order_ts, order_date
from el),

passengers as (select order_id, first_name, last_name, email, seat_id, travel_to_country, travel_from_country, travel_to_city, travel_from_city)
from el)


select a.customer_id, a.email, a.first_name, a.language, a.country, min(b.order_ts) as first_order_ts, b.travel_from_country, b.travel_from_city
from customers a
left join orders b
on a.customer_id and b.customer_id
left join passengers c
on b.order_id and c.order_id
where first_order_ts > current_timestamp - interval '24 hour'