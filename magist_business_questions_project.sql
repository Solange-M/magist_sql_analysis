/* Magist business questions for Eniac

   Purpose. Eniac sells high-end tech products and has to decide whether to sign a three-year contract with Magist, 
		a Brazilian online marketplace. These queries look at two concerns, whether Magist is a good fit for high-end tech 
		and whether it delivers on time.
   Data. The Magist database from the WBS Coding School data science course, 
		with orders from September 2016 to 17 October 2018. Prices are in euros.
   Authors. Solange Mekamgoum and Samer Odeh, WBS Coding School, November 2026.
	How to run. Import the magist database in MySQL Workbench first, then run the queries one by one with Ctrl+Enter. */

use magist;
      
    
    /* How many products of these tech categories have been sold (within the time window of the database snapshot)? 
		What percentage does that represent from the overall number of products sold? 
		1. Join order_items and products and count the rows, only to check that the join works.
		2. Keep only the tech categories, to get the number of tech products sold.
		3. Get the number of all products sold, with no category filter.
		4. Calculate the percentage, tech sold divided by all sold. */
select count(*) from order_items join products on order_items.product_id = products.product_id;
	/* Answer: 112650 products were actually sold */
    
select count(*) from order_items
join products on order_items.product_id = products.product_id
where product_category_name in ('audio', 'informatica_acessorios', 'cine_foto', 
'eletronicos', 'pcs', 'pc_gamer', 'tablets_impressao_imagem', 
'telefonia', 'telefonia_fixa', 'consoles_games');
	/* Answer, 17271 tech items sold */

select 17271 / 112650 * 100 as tech_percentage;
	/* Answer, 15.33 percent of the items sold are tech (17271 of 112650), against about 12 percent of the catalogue. */
select count(*) from products;
select count(*) from products
where product_category_name in ('audio', 'informatica_acessorios', 'cine_foto', 
'eletronicos', 'pcs', 'pc_gamer', 'tablets_impressao_imagem', 
'telefonia', 'telefonia_fixa', 'consoles_games');
select round(3851 / 32951 * 100, 2) as tech_share_of_catalogue;
	/* Answer: 3851 of the 32951 products in the catalogue are tech, making 11.69 percent. 
		This confirms the 12 percent mentioned above. 
		Tech is 15.33 percent of the items sold but only 11.69 percent of the catalogue. */

	/* What’s the average price of the products being sold? */
select round(avg(price), 2) from order_items;
		/* Answer, the average price of an item sold is 120.65 euros. */

	/* Are expensive tech products popular? */
select round(avg(price), 2) from order_items
join products on order_items.product_id = products.product_id
where product_category_name in ('audio', 'informatica_acessorios', 'cine_foto', 
'eletronicos', 'pcs', 'pc_gamer', 'tablets_impressao_imagem', 
'telefonia', 'telefonia_fixa', 'consoles_games');
		-- Answer, the average price of a tech item is 110.16 euros.
select count(*) from order_items
join products on order_items.product_id = products.product_id
where product_category_name in ('audio', 'informatica_acessorios', 'cine_foto', 
'eletronicos', 'pcs', 'pc_gamer', 'tablets_impressao_imagem', 
'telefonia', 'telefonia_fixa', 'consoles_games') and price > 3000; -- 6 tech items above 3000

select count(*) from order_items
join products on order_items.product_id = products.product_id
where product_category_name in ('audio', 'informatica_acessorios', 'cine_foto', 
'eletronicos', 'pcs', 'pc_gamer', 'tablets_impressao_imagem', 
'telefonia', 'telefonia_fixa', 'consoles_games') and price > 500; -- 567 tech items above 500

select count(*) from order_items
join products on order_items.product_id = products.product_id
where product_category_name in ('audio', 'informatica_acessorios', 'cine_foto', 
'eletronicos', 'pcs', 'pc_gamer', 'tablets_impressao_imagem', 
'telefonia', 'telefonia_fixa', 'consoles_games') and price > 1000;  -- 208 tech items above 1000
	-- Assumption, a tech item is expensive if its price is above 500.
	-- Are expensive tech products popular? 
select
  case when price > 500 then 'expensive' else 'cheap' end as price_group,
  count(*)
from order_items
join products on order_items.product_id = products.product_id
where product_category_name in ('audio', 'informatica_acessorios', 'cine_foto', 
'eletronicos', 'pcs', 'pc_gamer', 'tablets_impressao_imagem', 
'telefonia', 'telefonia_fixa', 'consoles_games')
group by price_group;
	/* Answer Q 2.1(4), expensive tech items (above 500) are only 567 of 17271 tech items sold, 
    about 3.3 percent, so they are not popular. 
    For the Eniac project this is an important finding, 
    because Eniac sells high-end products and Magist’s tech sales are dominated by cheap items. 
    We should keep it in mind for the recommendation, 
    not forgetting that what we measured are items, and not revenue.*/
    
    /* 2.2. In relation to the sellers:
			1. How many months of data are included in the magist database?
			2. How many sellers are there? How many Tech sellers are there? What percentage 
				of overall sellers are Tech sellers?
			3. What is the total amount earned by all sellers? What is the total amount earned by all Tech sellers?
			4. Can you work out the average monthly income of all sellers? 
				Can you work out the average monthly income of Tech sellers? */
                
 -- 1. How many months of data are included in the magist database?           
 select min(order_purchase_timestamp), max(order_purchase_timestamp) from orders;
	/* The first order was on 2016-09-04 at 23:15:19 and the last on 2018-10-17 at 19:30:18 */
select timestampdiff(month, min(order_purchase_timestamp), max(order_purchase_timestamp)) from orders;
	/* Answer, about 25 months of data, 
				from 4 September 2016 to 17 October 2018 (26 calendar months, 
				with no orders in November 2016) */
	
    
-- 2. How many sellers are there? How many Tech sellers are there? What percentage of overall sellers are Tech sellers?
select count(distinct seller_id) from sellers;
	-- Answer, there are 3095 sellers in total.
select count(distinct seller_id) from order_items
join products on order_items.product_id = products.product_id
where product_category_name in ('audio', 'informatica_acessorios', 'cine_foto', 
'eletronicos', 'pcs', 'pc_gamer', 'tablets_impressao_imagem', 
'telefonia', 'telefonia_fixa', 'consoles_games');
	/* Answer, there are 493 tech sellers.*/
select  round(493 / 3095 * 100, 2) as tech_seller_percentage;
	/* Answer, 15.93 percent of the sellers are tech sellers (493 of 3095). */
    
	/* What is the total amount earned by all sellers? */
select sum(price) from order_items
join sellers on order_items.seller_id = sellers.seller_id;
		/* Answer, all sellers earned about 13,591,643.70 euros in total. */
    -- or better the following simple request. 
			-- The join is not necessary, because both price and seller_id are in the order_items table:
select round(sum(price), 2) from order_items;
   -- 13591643.7

	/* What is the total amount earned by all Tech sellers? */
select sum(price) from order_items
join products on order_items.product_id = products.product_id
where product_category_name in ('audio', 'informatica_acessorios', 'cine_foto', 
'eletronicos', 'pcs', 'pc_gamer', 'tablets_impressao_imagem', 
'telefonia', 'telefonia_fixa', 'consoles_games');
	/* Answer, tech sellers earned about 1,902,576.26 euros from tech items. */
    
select round(1902576.26 / 13591643.70 * 100, 2) as total_price_percentage;
select 1902576.26 / 13591643.70 * 100 as order_items_percentage; -- same calculation as above, without rounding
	/* Answer: tech items bring in 14.00 percent of all the money earned. */

	/* Can you work out the average monthly income of all sellers?
		Total amount earned by all sellers: 13591643.7.
		Total number of sellers: 3095.
		Total number of months with data, 25. */
select round(13591643.70 / 3095 / 25, 2) as avg_monthly_income_per_seller;
	/* Answer, the average monthly income of a seller is 175.66 (total 13591643.7 / 3095 sellers / 25 months). */
    
	/* Can you work out the average monthly income of Tech sellers? */
select round(1902576.26 / 493 / 25, 2) as avg_monthly_income_per_tech_seller;
	/* Answer, the average monthly income of a tech seller is 154.37 (1902576.26 / 493 sellers / 25 months) */



/* 2.3. In relation to the delivery time: 
	1. What’s the average time between the order being placed and the product being delivered?
	2. How many orders are delivered on time vs orders delivered with a delay?
	3. Is there any pattern for delayed orders, e.g. big products being delayed more often? */
    
select avg(datediff(order_delivered_customer_date, order_purchase_timestamp)) from orders;
	/* Answer, on average an order is delivered 12.5 days after it was placed. */
select
  case when order_delivered_customer_date <= order_estimated_delivery_date then 'on time' else 'delayed' end as delivery_group,
  count(*) 
from orders
where order_delivered_customer_date is not null
group by delivery_group;
		/* Answer, 88649 orders were delivered on time and 7827 with a delay (about 8 percent). */
        
select
  case when order_delivered_customer_date <= order_estimated_delivery_date 
  then 'on time' else 'delayed' end as delivery_group,
  round(avg(product_weight_g), 2) as avg_weight_g,
  count(*) from orders
join order_items on orders.order_id = order_items.order_id
join products on order_items.product_id = products.product_id
where order_delivered_customer_date is not null
group by delivery_group;
    /* Answer, delayed items are heavier on average, 2381 g against 2065 g for items delivered on time. */


select product_category_name, count(*) as items_sold,
sum(price > 500) as expensive_items
from order_items
join products on order_items.product_id = products.product_id
where product_category_name in ('audio', 'informatica_acessorios', 'cine_foto', 
'eletronicos', 'pcs', 'pc_gamer', 'tablets_impressao_imagem', 
'telefonia', 'telefonia_fixa', 'consoles_games')
group by product_category_name
order by items_sold desc;
	/* category                    items_sold  expensive_items
   informatica_acessorios            7827              161
   telefonia                         4545               75
   eletronicos                       2767               20
   consoles_games                    1137               60
   audio                              364               19
   telefonia_fixa                     264               27
   pcs                                203              202
   tablets_impressao_imagem            83                1
   cine_foto                           72                2
   pc_gamer                             9                0   */
            
	/* Exploring the geo table before joining it to customers. 
    The zip prefix is unique (19177 rows, 19177 distinct zip prefixes), 
    so the join does not duplicate orders. */
select count(*), count(distinct zip_code_prefix) from geo;
select distinct city from geo; -- the city names are in geo, not in customers
describe customers; -- customers only has the zip code prefix, so we join through geo to get the state
    
select g.state,
count(*) as delivered_orders,
round(avg(datediff(o.order_delivered_customer_date, o.order_purchase_timestamp)), 1) as avg_delivery_days,
round(100 * sum(o.order_delivered_customer_date > o.order_estimated_delivery_date) / count(*), 1) as delayed_percent
from orders o
join customers c on o.customer_id = c.customer_id
join geo g on c.customer_zip_code_prefix = g.zip_code_prefix
where o.order_delivered_customer_date is not null
group by g.state
order by avg_delivery_days desc;
	/* Are deliveries slower in remote areas? Delivery time and delays by customer state, 
    delivered orders only (orders joined with customers and geo).
	-- Answer: yes. The remote northern states wait about three times longer than Sao Paulo, 
			RR 29.5 days (41 orders), AP 27.1 (67 orders), AM 26.4 (145 orders), 
            against 8.7 days in SP (40494 orders).
			-- Late deliveries (after the estimated date) are highest in the Northeast, 
                AL 23.9 percent, MA 19.7, PI 16.0, against 5.9 percent in SP. 
                The remote northern states have low rates, AM 4.1 and AC 3.8 percent, 
                because their estimated dates are already long.
			-- SP, RJ and MG together are 64202 of the 96476 delivered orders, about two thirds. 
			-- The total matches the 96476 delivered orders found before, and 4 orders have no state.
			-- Small states such as RR and AP have few orders, so their numbers are less reliable. */


select round(avg(datediff(order_estimated_delivery_date, order_purchase_timestamp)), 1) from orders;
		/* Answer, Magist promises 24.3 days on average between purchase and the estimated delivery date,
		while the real average delivery time is 12.5 days. 
		The 92 percent on-time rate is helped by these cautious estimates. */
