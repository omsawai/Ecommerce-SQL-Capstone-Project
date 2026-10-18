-- BUSINESS PROBLEMS

-- 1. Total Customer Base Analysis
-- Business Problem:
-- The company wants to understand its overall user base. As a data analyst, you are asked to calculate the total
-- number of registered customers in the system.

-- Explaination: This query retriving total customer in database

select * from customers;

-- 
-- Business Problem:
-- The marketing team wants to run a campaign specifically in Pune. Retrieve all customers who belong to Pune so
-- they can be targeted.

-- Explaination: This query retriving total customer belonging to Pune

select * from customers where city = 'Pune';

-- 3. Order Volume Tracking
-- Business Problem:
-- Management wants to know how many total orders have been placed on the platform so far to measure
-- platform activity.

-- Explaination: This query calculating total orders in orders table.

select count(*) as Total_orders from orders ;

-- 4. Recent Customer Activity
-- Business Problem:
-- To analyze current trends, the business wants to see all orders placed in the last 30 days.

-- Explaination: This query retriving orders placed in last 30 days.

select * from orders where order_date >= date_sub((select max(order_date) from orders), interval 30 day) ;


-- 5. High-Value Product Identification
-- Business Problem:
-- The company wants to identify premium products. Retrieve all products with a price greater than ₹50,000.

-- Explaination: This query retriving products whose price is greater than 50000.

select * from products where price > 50000 ;

-- 6. Product Category Overview
-- Business Problem:
-- To understand product diversity, list all unique product categories available on the platform.

-- Explaination : GIVING THE LIST OF UNIQUE PRODUCT CATEGORIES

select distinct category from products ;

-- 7. Total Revenue Calculation
-- Business Problem:
-- Finance team needs to know total revenue generated from all orders using order item data.

-- Explaination: GIVES THE TOTAL REVENUE OF ALL ORDERS  
select format(sum(quantity * price) ,2) as Total_revenue from order_items ;

-- 8. Order Status Distribution
-- Business Problem:
-- Operations team wants to understand how orders are distributed across statuses (Delivered, Pending,
-- Cancelled).

-- Explaination: GIVES THE COUNT OF ORDER BELONGING TO DELIVERED , PENDING AND CANCELLED
select shipping_status , count(order_id) as no_of_orders from shipping group by shipping_status ;

-- 9. Product Inventory Distribution
-- Business Problem:
-- Warehouse team wants to know how many products exist in each category.

-- Explaination:  IT GIVES COUNT OF OF EACH PRODUCT CATEGORY
select category, count(product_id) from products group by category;

-- 10. Customer Order Mapping
-- Business Problem:
-- To understand customer engagement, display each customer along with the orders they have placed.

-- Explaination: IT GIVES EACH CUSTOMER TOTAL ORDERS
select c.customer_id ,c.name, o.order_id from customers c left join orders o 
on c.customer_id = o.customer_id order by c.customer_id;

-- 11. Low Inventory Alert
-- Business Problem:
-- Identify products where stock is below 20 units so that restocking can be planned.

-- Explaination: IT GIVES LIST WHICH HAS STOCK QUANTITY LESS THAN 20
select * from products where stock_quantity < 20 ;

-- Business Insight:
-- This output indicates two side of these products which depends on purchasing volume.One side  is restock and explore category of products
-- having high purchasing valume in last 30 days and another side is try to sell other products with discount and hold restocking for while .

-- 12. Successful Payment Transactions
-- Business Problem:
-- Finance team wants to analyze only successful payments.

-- Explaination: GIVING LIST WHICH HAS ONLY SUCESSFUL PAYMENTS
select * from payments where payment_status = 'Success' ;

-- 13. Completed Orders Analysis
-- Business Problem:
-- Find all orders that have been successfully delivered to customers.

-- Explaination: GIVES LIST OF ONLY SUCCESSFULLY DELIVERED ORDERS TO CUSTOMERS

select order_id from shipping where shipping_status = 'Delivered';	

-- 14. Customer Order Frequency
-- Business Problem:
-- Calculate how many orders each customer has placed.

-- Explaination: GIVES COUNT OF ORDERS THAT EACH CUSTOMER HAS PLACED
select c.customer_id , c.name , count(o.order_id )as Total_orders from customers c
left join orders o on c.customer_id = o.customer_id group by c.customer_id 
order by c.customer_id;

-- Business Insight: From this we categorize customer with high and low orders placed.The following action need to provide 
-- offers and rewards to customers with low orders and find out the reason for low orders placed by them in terms of choice, varity of items.

-- 15. Order Product Details
-- Business Problem:
-- Display all products included in each order to understand order composition.


-- Explaination: DISPLAYS ALL PRODUCTS INCLUDED IN EACH ORDER ALONG WITH ORDER DETAILS
select order_id , product_id from order_items ;

-- 16. Top Customers by Revenue Contribution
-- Business Problem:
-- Identify top 10 customers who have contributed the highest revenue to the business.

-- Explaination: GIVES TOP 10 CUSTOMERS WITH HIGHEST REVENUE

select c.customer_id , c.name , sum(oi.quantity*oi.price) as Total_revenue
from customers c join orders o on c.customer_id = o.customer_id 
join order_items oi on o.order_id = oi.order_id group by c.customer_id , c.name
order by Total_revenue desc limit 10 ; 

-- 17. Monthly Sales Trend Analysis
-- Business Problem:
-- Analyze how revenue changes month by month to detect trends and seasonality.

-- Explaination:  CALCULATES AND TRACKS TOTAL REVENUE MONTH-BY-MONTH TO DETECT SALES TRENDS AND SEASONALITY

select date_format(o.order_date, '%Y-%m') as mnth, sum(oi.quantity * oi.price) as Total_revenue from orders o left join 
order_items oi on o.order_id = oi.order_id group by mnth order by mnth;

-- 18. High-Value Orders Identification
-- Business Problem:
-- Find orders where total value exceeds ₹50,000. These are considered premium orders.

-- Explaination: GIVES ORDER HAVING TOTAL VALUE(QUANTITY* SUM) GREATER THAH 50 K

select order_id , sum(quantity * price) as Total_value from order_items 
group by order_id having Total_value > 50000 ;

-- 19. Repeat Customer Identification
-- Business Problem:
-- Identify customers who have placed more than 5 orders. These are loyal customers.

-- Explaination: GIVES CUSTOMER WHICH HAS PLACED MORE THAN 5 ORDERS TERMED AS LOYOL CUSTOMER

select c.customer_id ,c.name ,  count(o.order_id) as Total_orders 
from customers c join orders o on c.customer_id = o.customer_id 
group by c.customer_id having Total_orders > 5 order by c.customer_id ;

-- 20. Product-Level Revenue Analysis
-- Business Problem:
-- Calculate how much revenue each product generates.

-- Explaination: CALCULATES REVENUE OF EACH PRODUCT
select p.product_id , p.product_name , sum(oi.quantity * oi.price) as revenue from 
products p join order_items oi on p.product_id = oi.product_id
group by p.product_id order by p.product_id ;

-- 21. Payment Method Popularity
-- Business Problem:
-- Find which payment method is used most frequently by customers.

-- Explaination:GIVES WHICH PAYMENT METHOD IS USED MOST BY CUSTOMERS (NETBANKING)
select payment_method from payments group by payment_method 
order by count(payment_method) desc limit 1;

-- 22. Failed Payment Impact
-- Business Problem:
-- Identify orders that had at least one failed payment attempt.

-- Explaination: IDENTIFIES ORDERS THAT EXPERIENCED AT LEAST ONE FAILED PAYMENT ATTEMPT

select distinct order_id from payments where payment_status = 'Failed' ;

-- 23. City-wise Order Distribution
-- Business Problem:
-- Determine how many orders come from each city.

-- Explaination:GIVES COUNT OF ORDERS FROM EACH CITY

select c.city , count(o.order_id) as Order_count from customers c
join orders o on c.customer_id = o.customer_id group by c.city order by c.city;

-- 24. Most Sold Product Category
-- Business Problem:
-- Identify which category has the highest number of items sold.

-- Explaination:IDENTIFIES WHICH PRODUCT CATEGORY HAS THE HIGHEST TOTAL NUMBER OF ITEMS SOLD

select p.category from products p join order_items oi on p.product_id = oi.product_id 
group by p.category order by sum(oi.quantity) desc limit 1 ;

-- 25. Delivery Performance Analysis
-- Business Problem:
-- Calculate the average delivery time for delivered orders.

-- Explaination:GIVES AVGERAGE DELIVERY TIME FOR DELIVERED ORDERS

select floor(avg(datediff(s.delivery_date, o.order_date))) as average_delivery_time_days
from orders o 
join shipping s on o.order_id = s.order_id 
where s.delivery_date is not null;

-- 26. Customer Ranking Based on Spending
-- Business Problem:
-- Rank all customers based on total money spent to identify VIP customers.

-- Explaination :RANKS ALL CUSTOMERS BASED ON TOTAL MONEY SPENT FROM HIGHEST TO LOWEST TO IDENTIFY VIP CUSTOMERS
select c.customer_id , c.name ,sum(oi.quantity * oi.price) as money_spent ,  rank() over(order by sum(oi.quantity * oi.price) desc) as rnk
from customers c join orders o on c.customer_id = o.customer_id join order_items oi on o.order_id = oi.order_id
group by c.customer_id, c.name ;

-- 27. Running Revenue Analysis
-- Business Problem:
-- Track cumulative revenue over time to understand business growth.

-- Explaination:TRACKS CUMULATIVE RUNNING REVENUE CHRONOLOGICALLY OVER TIME TO MONITOR BUSINESS GROWTH

with daily_revenue as (
    select date(o.order_date) as order_date, sum(oi.quantity * oi.price) as daily_sales
    from orders o join order_items oi on o.order_id = oi.order_id group by date(o.order_date)
    )
select order_date, daily_sales, sum(daily_sales) over (order by order_date) 
as cumulative_revenue from daily_revenue order by order_date;

-- 28. Top Customers per City
-- Business Problem:
-- Identify top 3 customers in each city based on spending.

-- Explaination: GIVES TOP 3 CUSTOMER FROM EACH CITY

with cust_info as (
	select c.customer_id ,c.city as city, c.name , sum(oi.quantity * oi.price) as spending ,
    rank() over (partition by city order by sum(oi.quantity * oi.price) desc ) as rnk from customers c join orders o on 
    c.customer_id = o.customer_id join order_items oi on o.order_id = oi.order_id
    group by c.customer_id , c.name 
    )
select customer_id , name ,spending , city , rnk  from cust_info where rnk < 4;

-- 29. Product Revenue Contribution Percentage
-- Business Problem:
-- Calculate how much each product contributes to total revenue in percentage terms.

-- Explaination: CALCULATES EACH PRODUCT'S REVENUE CONTRIBUTION AS A PERCENTAGE OF TOTAL REVENUE TO IDENTIFY TOP-SELLING ITEMS

select product_id,product_name,product_revenue,(product_revenue * 100.0 / sum(product_revenue) over ()) as revenue_percentage from (select p.product_id,p.product_name,sum(oi.quantity * oi.price) as product_revenue from products as p inner join order_items as oi on p.product_id = oi.product_id group by p.product_id, p.product_name) as subquery order by revenue_percentage desc;


-- 30. Customer Behavior Pattern Analysis
-- Business Problem:
-- Find customers who have both delivered and cancelled orders, indicating mixed behavior.

-- Explaination: FINDS CUSTOMERS WHO HAVE BOTH SUCCESSFULLY DELIVERED AND CANCELLED ORDERS TO SPOT MIXED BEHAVIOR PATTERNS

select distinct c.customer_id, c.name
from customers c
join orders o on c.customer_id = o.customer_id
where o.status = 'Delivered'
  and c.customer_id in (
      select customer_id 
      from orders 
      where status = 'Cancelled'
  ) order by c.customer_id;
  
  -- E-Commerce Business Performance & Analytics Insights

-- 1. User Base Scale: The platform has a registered user base of **650 customers** distributed across major cities.
-- 2. Order Volume: A total of **2,500 orders** have been processed, indicating healthy platform activity.
-- 3. Revenue Generation The business has generated a cumulative lifetime revenue of **₹93,02,59,948.43.
-- 4. Top Customer (VIP): **Deepak Mishra** is the highest-contributing customer, with total spending of ₹46,63,040.34.
-- 5. Sales Seasonality & Trends: **May 2024** recorded peak monthly revenue (₹17.1 Cr), while February 2024 experienced the lowest seasonal dip (**₹14.03 Cr**).
-- 6. Cumulative Growth: Running revenue analysis demonstrates steady, uninterrupted business expansion since launch.
-- 7. Payment Preferences: **Net Banking** is the most frequently utilized payment method by customers.
-- 8. Logistics & Delivery: The average delivery time for successfully fulfilled orders stands efficiently at 5.6 days
-- 9. Top-Selling Category:** The **Sports** category leads platform sales with the highest physical unit volume (**3,811 items sold**).
-- 10. Top Revenue Product:** The **Decathlon Yoga Mat** holds the highest individual revenue share across the entire product catalog.
-- 11. Geographic Distribution: **Hyderabad** represents the city with the highest order concentration.
