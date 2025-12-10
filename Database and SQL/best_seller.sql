with successful_orders as (
select p.id product_id, p.name product_name, u.id user_id, p.price, od.quantity
from ku_order_detail od
join ku_order_detail_status ods on od.status = ods.id
join ku_order o on od.order_id = o.id
join ku_user u on o.user_id = u.id
join ku_product p on od.product_id = p.id
where ods.name = 'success' and od.delivery_date between DATE '2025-07-01 00:00:00' and DATE '2025-10-01 00:00:00'
)
select product_name, sum(price * quantity) total_gmv, sum(quantity) total_quantity, count(distinct user_id) user_count
from successful_orders
group by product_name
order by total_gmv desc, total_quantity desc;
