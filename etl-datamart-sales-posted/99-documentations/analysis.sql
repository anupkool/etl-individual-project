/* 
   Query 1
   Analysis: Top 5 states for order quantity between 2007 and 2008 for the product, 800 (Road-550-W Yellow, 44), together with a gain/loss percentage of 2008 when compared to 2007 
   Findings & Business Decisions: The biggest drop happened in England. Needs stronger marketing. 
 */
SELECT b.*
  FROM (
        SELECT a.product_name, a.state, a.country
               , SUM(IF(a.the_year=2007, a.order_qty, NULL)) AS order_qty_2007
               , SUM(IF(a.the_year=2008, a.order_qty, NULL)) AS order_qty_2008
               , SUM(a.order_qty) AS order_qty_total
               , IFNULL(SUM(IF(a.the_year=2008, a.order_qty, NULL)), 0) - IFNULL(SUM(IF(a.the_year=2007, a.order_qty, NULL)),0) AS order_qty_diff_cnt
               , ROUND(CASE WHEN SUM(IF(a.the_year=2007, a.order_qty, NULL)) > 0
                      THEN (IFNULL(SUM(IF(a.the_year=2008, a.order_qty, NULL)), 0) - IFNULL(SUM(IF(a.the_year=2007, a.order_qty, NULL)),0)) / SUM(IF(a.the_year=2007, a.order_qty, NULL))
                 END*100) AS order_qty_diff_perc     
          FROM (
                SELECT p.product_name, c.home_address_state AS state, c.home_address_country AS country, d.the_year, SUM(f.order_qty) AS order_qty
                  FROM fact_sales f, dim_product p, dim_customer c, dim_date d
                 WHERE f.product_skey = p.product_skey
                   AND f.customer_skey = c.customer_skey
                   AND f.date_skey = d.date_skey
                   AND p.product_id = 800
                   AND d.the_year IN (2007, 2008)
                 GROUP BY p.product_name, c.home_address_state, d.the_year
               ) a
         GROUP BY a.product_name, a.state, a.country
         ORDER BY SUM(a.order_qty) DESC
         LIMIT 5
       ) b
 ORDER BY b.order_qty_diff_perc
 
 
 
-- Query 2
-- Analysis: Top 10 Products_Categories which has been distibuted in various states of "United States"
-- Findings & Business Decisions: Accessories is mostly famous in all the States. California is a state which has the highest sales in terms of Accessories, Bikes, Clothing. So probably a good market to invest in.

SELECT c.home_address_country AS country, c.home_address_state AS state, p.product_category AS product_category, SUM(f.order_qty) AS quantity
FROM fact_sales f,
     dim_customer c,
     dim_product p
WHERE f.customer_skey = c.customer_skey
AND   f.product_skey = p.product_skey
AND   c.home_address_country = "United States"
GROUP BY c.home_address_country, c.home_address_state, p.product_category
ORDER BY 4 DESC
LIMIT 10

-- Query 3
-- Analysis: Top 10 Product whos sales are highest in different contries and states between 2007 and 2008. The differece in the product is recorded and also the change percentage. 
-- Findings & Business Decisions: Watter Bottle - 30oz product is the one which is sold almost everywhere in all the Countries. It just shows that the bottled water is famous everywhere and the sales of the water are increasing each year.

SELECT b.*
  FROM (
        SELECT a.product_name, a.state, a.country
            , SUM(IF(a.the_year=2007, a.order_qty, NULL)) AS quantity_2007
            , SUM(IF(a.the_year=2008, a.order_qty, NULL)) AS quantity_2008
            , SUM(a.order_qty) AS total
            , IFNULL(SUM(IF(a.the_year=2008, a.order_qty, NULL)), 0) - IFNULL(SUM(IF(a.the_year=2007, a.order_qty, NULL)),0) AS quantity_diff
            , ROUND(CASE WHEN SUM(IF(a.the_year=2007, a.order_qty, NULL)) > 0
                THEN (IFNULL(SUM(IF(a.the_year=2008, a.order_qty, NULL)), 0) - IFNULL(SUM(IF(a.the_year=2007, a.order_qty, NULL)),0)) / SUM(IF(a.the_year=2007, a.order_qty, NULL))
                END*100) AS perc_difference_2007_2008      
        FROM (
            SELECT p.product_name, c.home_address_state AS state, c.home_address_country AS country, d.the_year, SUM(f.order_qty) AS order_qty
                FROM fact_sales f, dim_product p, dim_customer c, dim_date d
                WHERE f.product_skey = p.product_skey
                AND f.customer_skey = c.customer_skey
                AND f.date_skey = d.date_skey
                AND d.the_year IN (2007, 2008)
                GROUP BY p.product_name, c.home_address_state, d.the_year
               ) a
         GROUP BY a.product_name, a.state, a.country
         ORDER BY SUM(a.order_qty) DESC
         LIMIT 10
       ) b
 ORDER BY b.perc_difference_2007_2008

-- Query 4
-- Analysis: Sales in different contries between 2007 and 2008. The total sales is recorded and the differece in the product is recorded and also the change percentage. 
-- Findings & Business Decisions: It can be seen that United States has largest sales. If we look at the percentage difference between 2007 to 2008 France, Germany and Australia are the emerging Markets and should be consolidated
 
SELECT a.country
       , SUM(a.quantity) AS total
       , SUM(IF(a.the_year=2007, a.quantity, NULL)) AS quantity_2007
       , SUM(IF(a.the_year=2008, a.quantity, NULL)) AS quantity_2008
       , IFNULL(SUM(IF(a.the_year=2008, a.quantity, NULL)), 0) - IFNULL(SUM(IF(a.the_year=2007, a.quantity, NULL)),0) AS quantity_diff
       , ROUND(CASE WHEN SUM(IF(a.the_year=2007, a.quantity, NULL)) > 0
         THEN (IFNULL(SUM(IF(a.the_year=2008, a.quantity, NULL)), 0) - IFNULL(SUM(IF(a.the_year=2007, a.quantity, NULL)),0)) / SUM(IF(a.the_year=2007, a.quantity, NULL))
         END*100) AS perc_difference_2007_2008
FROM (
SELECT c.home_address_country AS country, p.product_category AS product_category, SUM(f.order_qty) AS quantity, d.the_year AS the_year
FROM fact_sales f,
     dim_customer c,
     dim_product p,
     dim_date d
WHERE f.customer_skey = c.customer_skey
AND   f.product_skey = p.product_skey
AND   f.date_skey = d.date_skey
AND   p.product_category = "Accessories"
GROUP BY c.home_address_country, p.product_category, d.the_year
) a
GROUP BY a.country
ORDER BY perc_difference_2007_2008 DESC

-- Query 5
-- Analysis: Sales in different contries according to the Product Category though all the years are listed. 
-- Findings & Business Decisions: It can be seen that United States has largest sales for all product categories. As a sales we would focus on more accessories product to be shipped and sold to the customer as it is famous (highest value) in all contries.

SELECT a.country
       , SUM(IF(a.product_category = 'Accessories', a.quantity, NULL)) AS Accessories
       , SUM(IF(a.product_category = 'Bikes', a.quantity, NULL)) AS Bikes
       , SUM(IF(a.product_category = 'Clothing', a.quantity, NULL)) AS Clothing
FROM (
SELECT c.home_address_country AS country, p.product_category AS product_category, SUM(f.order_qty) AS quantity
FROM fact_sales f,
     dim_customer c,
     dim_product p
WHERE f.customer_skey = c.customer_skey
AND   f.product_skey = p.product_skey
GROUP BY c.home_address_country, p.product_category
) a
GROUP BY a.country
ORDER BY a.quantity DESC

-- Query 6
-- Analysis: Sales in different contries according to the Product Category and according to the gender though all the years are listed. 
-- Findings & Business Decisions: It can be seen that United States has largest sales for all product categories both for Male and Female. Interestingly we can see some trends that male and Female buy clothing almost equally. And accessories irrespective of the countries and gender they are most bought

SELECT a.country
       , SUM(IF(a.product_category = 'Accessories' AND a.gender = "F", a.quantity, NULL)) AS Accessories_Female
       , SUM(IF(a.product_category = 'Accessories' AND a.gender = "M", a.quantity, NULL)) AS Accessories_Male
       , SUM(IF(a.product_category = 'Bikes' AND a.gender = "F", a.quantity, NULL)) AS Bikes_Female
       , SUM(IF(a.product_category = 'Bikes' AND a.gender = "M", a.quantity, NULL)) AS Bikes_Male
       , SUM(IF(a.product_category = 'Clothing' AND a.gender = "F", a.quantity, NULL)) AS Clothing_Female
       , SUM(IF(a.product_category = 'Clothing' AND a.gender = "M", a.quantity, NULL)) AS Clothing_Male
FROM (
SELECT c.home_address_country AS country, p.product_category AS product_category, SUM(f.order_qty) AS quantity, c.gender AS gender
FROM fact_sales f,
     dim_customer c,
     dim_product p
WHERE f.customer_skey = c.customer_skey
AND   f.product_skey = p.product_skey
GROUP BY c.home_address_country, p.product_category, c.gender
) a
GROUP BY a.country

-- Query 7
-- Analysis: Sales in United States according to the Product Category and according to the gender though each years are listed. 
-- Findings & Business Decisions: It can be argued that the data for 2005 and 2006 is not recorded for the Accessories and clothing. But looking at the stats we can find that from 2007 to 2008 Male show growth in the Accessories than the Female counterparts. Also, looking at trends we can estimate a inrease of Accessories and can reach about 5000 for male and 4800 for Females.


SELECT a.country,a.the_year
       , SUM(IF(a.product_category = 'Accessories' AND a.gender = "F", a.quantity, NULL)) AS Accessories_Female
       , SUM(IF(a.product_category = 'Accessories' AND a.gender = "M", a.quantity, NULL)) AS Accessories_Male
       , SUM(IF(a.product_category = 'Bikes' AND a.gender = "F", a.quantity, NULL)) AS Bikes_Female
       , SUM(IF(a.product_category = 'Bikes' AND a.gender = "M", a.quantity, NULL)) AS Bikes_Male
       , SUM(IF(a.product_category = 'Clothing' AND a.gender = "F", a.quantity, NULL)) AS Clothing_Female
       , SUM(IF(a.product_category = 'Clothing' AND a.gender = "M", a.quantity, NULL)) AS Clothing_Male
FROM (
SELECT c.home_address_country AS country, p.product_category AS product_category, SUM(f.order_qty) AS quantity, c.gender AS gender,d.the_year AS the_year
FROM fact_sales f,
     dim_customer c,
     dim_product p,
     dim_date d
WHERE f.customer_skey = c.customer_skey
AND   f.product_skey = p.product_skey
AND   f.date_skey = d.date_skey
AND   c.home_address_country = "United States"
GROUP BY c.home_address_country, p.product_category, c.gender,d.the_year
) a
GROUP BY a.country,a.the_year
