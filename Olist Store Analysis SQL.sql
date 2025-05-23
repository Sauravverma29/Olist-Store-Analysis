create database E_Commerce_Dataset;

use e_commerce_dataset;

/* Weekday vs Weekend Payment Statistic */
select
      case
          when dayofweek(order_purchase_timestamp) IN (1,7) then "weekend"
          else "weekday"
          end as Day_Type,
          count(*) as order_count,
          sum(payment_value) as Total_payment,
          avg(payment_value) as Average_Payment
          from olist_orders_dataset o
          join olist_order_payments_dataset p on o.order_id = p.order_id
          group by Day_Type;
          
/* Number of Orders with review score 5 and payment type as Credit Card */

select 
      count(distinct o.order_id) as order_review5_credit_card
      from olist_orders_dataset o
      join olist_order_reviews_dataset r on o.order_id = r.order_id
      join olist_order_payments_dataset p on o.order_id = p.order_id
      where review_score = 5 and payment_type = "credit_card";
      
/* Average number of days taken for delivery for pet_shop */
select
      avg(datediff(order_delivered_customer_date, order_purchase_timestamp)) as Avg_Delivery_Days
      from olist_orders_dataset o
      join olist_order_items_dataset i on i.order_id = o.order_id
      join olist_products_dataset p on i.product_id = p.product_id
      where p.product_category_name = 'Pet_Shop';
      
/* . Average Price and Payment Values for Customers from São Paulo City */
select 
      avg(i.price) as average_price,
      avg(p.payment_value) as average_payment
      from olist_orders_dataset o
      join olist_customers_dataset c on o.customer_id = c.customer_id
      join olist_order_items_dataset i on i.order_id = o.order_id
      join olist_order_payments_dataset p on o.order_id = p.order_id
      where c.customer_city = "Sao Paulo";
            
/* Relationship between Shipping Days vs Review Scores */

select 
      r.review_score,
      avg(datediff(order_delivered_customer_date, order_delivered_carrier_date)) as AVG_Shipping_days
      from olist_orders_dataset o
      join olist_order_reviews_dataset r on o.order_id = r.order_id
      group by r.review_score
      order by r.review_score;
      
/* Top 5 Cities by Number of Orders */
select
      customer_city,
      count(*) as Order_count
      from olist_customers_dataset c 
      join olist_orders_dataset o on c.customer_id = o.customer_id
      group by customer_city
      order by order_count desc
      limit 5;
      
/* Payment Method Distribution */
select
      payment_type,
      count(*) as Payment_count
      from olist_order_payments_dataset
      group by payment_type
      order by payment_count desc;
      
/* Average Review Score by Product Category */
SELECT 
  p.product_category_name,
  AVG(r.review_score) AS Avg_Review_Score
FROM olist_order_reviews_dataset r
JOIN olist_orders_dataset o ON r.order_id = o.order_id
JOIN olist_order_items_dataset i ON o.order_id = i.order_id
JOIN olist_products_dataset p ON i.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY Avg_Review_Score DESC;

/* Cancellation Rate */
select 
      concat(round(sum(case when order_status = "Canceled" then 1 else 0 end)/ count(*), 4), "%") as Cancellation_Rate_Percentage
      from olist_orders_dataset;
      
/* Average Payment Installments for Credit Card Payments */
select
      avg(payment_installments)
      from olist_order_payments_dataset
      where payment_type = "Credit_card";
      
      
      

      
      

          
          







