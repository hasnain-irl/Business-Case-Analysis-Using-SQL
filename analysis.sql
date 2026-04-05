# Revenue Analysis

-- Total Revenue
SELECT 
    ROUND(SUM(total_price), 2) AS TotalRevenue
FROM
    retail_cleaned;
    
-- Monthly Revenue Trend
SELECT 
DATE_FORMAT(invoice_date, '%Y-%m') AS month,
ROUND(SUM(total_price), 2) AS revenue
FROM retail_cleaned
GROUP BY month
ORDER BY month;
/*Insight:
Monthly trend revenue clearly show that sales droped from good numbers to very low in the 1st 4 months of 2011 which is a conserning point → business should try to retain 
those numbers.
Sales peaked in September and October → business should prioritize these months and start marketing compaings and give some offers before the start of the month.” */
---------------------------------------------------------------------------------------------------------------------------------------------------------

# Product Analysis

-- Top Products
SELECT 
description,
ROUND(SUM(total_price), 2) AS revenue
FROM retail_cleaned
GROUP BY description
ORDER BY revenue desc
LIMIT 10;
/*Result:
Top products include: [PAPER CRAFT , LITTLE BIRDIE , AMAZON FEE , DOTCOM POSTAGE , REGENCY CAKESTAND 3 TIER, etc]
Insight:
“These top products generate the majority of revenue → business should prioritize these for marketing and inventory planning.” */

-- Low Performing Products
SELECT 
description,
ROUND(SUM(total_price), 2) AS revenue
FROM retail_cleaned
GROUP BY description
ORDER BY revenue asc
LIMIT 10;
/*Result:
Low Performing products include: [PADS TO MATCH ALL CUSHIONS , HEN HOUSE W CHICK IN NEST , SET 12 COLOURING PENCILS DOILEY , VINTAGE BLUE TINSEL REEL ,etc]
Insight:
“These low performing products are not playing role in revenue → business should monitor these products what's going wrong with these products they are effecting sales.” */

--------------------------------------------------------------------------------------------------------------------------------------------------------

#Customer Analysis

-- Top Customers
SELECT  customer_id, ROUND(SUM(total_price), 2) AS total_spent FROM retail_cleaned
group by customer_id
order by total_spent desc
limit 10; # Note: customer id 1 is the sum of all the null rows in this customer_id column, it is not an individual customer's data.

-- Repeat Customers
SELECT customer_id, COUNT(DISTINCT invoice_no) AS ORDERS FROM retail_cleaned
group by customer_id
having ORDERS > 1;
/*Insight:
Almost 31.01% customers didn't even return again after 1st purchase and in this total 3060 customers there are those 26.7% customers who
came only twice → business should try to retain them becouce these numbers are not good for sales growth. 
Only 51.30% customers who return more than 2 times it's not good → Most of our revenue is generated from our top customers,48.7% customers didn't even come back again
that's almost half of our customers */

-- New Customers (First-Time Buyers)
SELECT 
customer_id,
MIN(invoice_date) AS first_order
FROM retail_cleaned
GROUP BY customer_id;

------------------------------------------------------------------------------------------------------------------------------------------------------
# Country Analysis

SELECT 
DISTINCT country,
ROUND(SUM(total_price),2) as TotalSales
FROM retail_cleaned
group by country
order by TotalSales DESC;

/* Insight
The majority of revenue comes from UK countries.
The difference between UK and all the other countries is very big.
All top countries almost has the same sales little bit difference except UK.
We have to make sure all the things in UK must go as same as it is going but we need to focus on other countries as well 
business should prioritize these countries al well for marketing .*/

----------------------------------------------------------------------------------------------------------------------------------------------------------
# Business Metrics

-- Average Order Value
SELECT 
SUM(total_price) / COUNT(DISTINCT invoice_no) AS avg_order_value 
FROM retail_cleaned;
-------------------------------------------------------------------------------------------------------------------------------------------------------
# Customer Retention Logic

-- Repeat vs One-Time Customers
SELECT 
CASE 
    WHEN COUNT(DISTINCT invoice_no) = 1 THEN 'One-Time'
    ELSE 'Repeat'
END AS customer_type,
COUNT(*) AS total_customers FROM retail_cleaned
GROUP BY customer_id;




