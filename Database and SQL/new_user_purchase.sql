with new_user_purchase AS (
select u.id user_id, u.name user_name, o.id order_id, od.delivery_date, p.name product_name, p.price product_price, od.quantity
from ku_user u
join ku_order o on u.id = o.user_id
join ku_order_detail od on o.id = od.order_id
join ku_order_detail_status ods on od.status = ods.id
join ku_product p on od.product_id = p.id
where ods.name = 'success' and od.delivery_date between u.created_at and u.created_at + INTERVAL '7 days'
)
  
select *
from new_user_purchase
order by user_id, delivery_date;
