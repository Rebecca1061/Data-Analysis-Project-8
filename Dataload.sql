select a.order_id,
concat(b.first_name,',',b.last_name) as full_name,
b.city,
b.state,
a.order_date,
sum(c.quantity) as total_units,
sum(c.quantity*c.list_price) as revenue,
d.product_name,
e.category_name,
f.store_name,
concat(g.first_name,',',g.last_name) as sales_rep
from  
sales.orders a
join
sales.customers b
on a.customer_id=b.customer_id
join sales.order_items c
on a.order_id=c.order_id
join production.products d
on c.product_id=d.product_id
join production.categories e
on d.category_id=e.category_id
join sales.stores f
on a.store_id=f.store_id
join sales.staffs g
on a.staff_id=g.staff_id
group by a.order_id,
concat(b.first_name,',',b.last_name),
b.city,
b.state,d.product_name,e.category_name,f.store_name,concat(g.first_name,',',g.last_name),
a.order_date order by 1

------------------------------------------------------------------------------
ALTER TABLE sales.customers add column customer_id int

WITH _article_favorites_rowids AS
(
    SELECT first_name, ROW_NUMBER() OVER () AS customer_id
    FROM sales.customers
)

UPDATE sales.customers a
SET customer_id = r.customer_id
FROM _article_favorites_rowids r
 where a.first_name = r.first_name


UPDATE sales.orders
SET order_date = '2018-05-01'



---------------------------------------------------------------------  

ALTER TABLE sales.stores add column store_id int

WITH _article_favorites_rowids AS
(
    SELECT store_name, ROW_NUMBER() OVER () AS store_id
    FROM sales.stores
)

UPDATE  sales.stores a
SET store_id = r.store_id
FROM 
_article_favorites_rowids r
where a.store_name = r.store_name


--------------------------------------------------

select * from sales.orders_items;

select * from  production.stocks;
select * from  production.products;
select * from  production.categories;
select * from  production.brands;

select * from  sales.staffs;
select * from sales.stores;