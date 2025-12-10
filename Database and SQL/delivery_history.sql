with successful_deliveries as (
select u.id user_id, u.name user_name, u.email, u.phone, od.delivery_date, p.name product_name 
c.name category_name, od.quantity, ul.address
from ku_order_detail od
join ku_order_detail_status ods on od.status = ods.id
join ku_order o on od.order_id = o.id
join ku_user u on o.user_id = u.id
join ku_product p on od.product_id = p.id
left join ku_product_category pc on p.id = pc.product_id
left join ku_category c on pc.category_id = c.id
left join ku_user_location ul on od.user_location_id = ul.id
where ods.name = 'success' and od.delivery_date between DATE '2025-09-01 00:00:00' and DATE '2025-10-01 00:00:00'
),
  
aggregated_category as (
select user_id, user_name, email, phone, delivery_date, product_name, STRING_AGG(category_name, ', ') as product_categories,
quantity, address
from successful_deliveries
group by 1,2,3,4,5,6,7,8
)

select *, sum(quantity) 
over (
partition by user_id order by delivery_date ) as total_quantity
from aggregated_category
order by delivery_date, user_id;
