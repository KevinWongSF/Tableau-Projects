
-- Superstore Analysis FROM 2015 - 2019

-----------------------------------------------------------------------------------------------------------------------------------------------------

		-- *Cleaning Data* -- Converting string date to a timestamps date --
		
		UPDATE superstore 
		SET order_date = str_to_date(order_date, '%d/%m/%Y')

		UPDATE superstore 
		SET ship_date = str_to_date(ship_date, '%d/%m/%Y')
        
        
--------------------------------------------------------------------------------------------------------------------------------------------------

-- Most Common Shipping mode and average shipping time

SELECT ship_mode, COUNT(*) AS amount, AVG(TIMESTAMPDIFF(DAY, Order_date, ship_date)) AS average_ship_time FROM superstore 
GROUP BY ship_mode 
ORDER BY amount DESC

--------------------------------------------------------------------------------------------------------------------------------------------------

-- Pecentage Of shipmode used 

WITH amount_per_shipmode AS 
(
SELECT ship_mode , count(*) AS amount FROM superstore
GROUP by ship_mode
)

SELECT ship_mode, amount/(SELECT COUNT(*) FROM superstore) * 100 AS percent_per_ship_mode FROM amount_per_shipmode
ORDER BY percent_per_ship_mode DESC

--------------------------------------------------------------------------------------------------------------------------------------------------
-- Percent of Sales By Category

WITH amount_per_category AS 
(
SELECT Category , count(*) AS amount FROM superstore
GROUP by Category
)

SELECT Category, amount/(SELECT COUNT(*) FROM superstore) * 100 AS percent_per_Category FROM amount_per_Category
ORDER BY percent_per_Category DESC



--------------------------------------------------------------------------------------------------------------------------------------------------

-- Percentage of Sales by State

WITH amount_per_state AS 
(
SELECT state, count(*) AS amount FROM superstore
GROUP by state
)

SELECT state, amount/(SELECT COUNT(*) FROM superstore) * 100 AS Percent_Per_store FROM amount_per_state
ORDER BY Percent_Per_store DESC

--------------------------------------------------------------------------------------------------------------------------------------------------

-- Ranking the Top 5 spenders

SELECT ROW_NUMBER() OVER(order by FLOOR(sum(sales)) DESC ) AS Ranking, Customer_ID, customer_name, city, country, FLOOR(sum(sales)) AS sale FROM superstore
GROUP BY Customer_ID, customer_name,city,country
ORDER BY sale DESC
LIMIT 5

SELECT Customer_ID, customer_name, FLOOR(sum(sales)) AS sales FROM superstore
GROUP BY 1,2
ORDER BY sales DESC
LIMIT 5


--------------------------------------------------------------------------------------------------------------------------------------------------


-- Number of sales per Office Supplies Category

SELECT sub_category, FLOOR(SUM(sales)) as sales FROM superstore
WHERE Category = 'Office Supplies'
GROUP by sub_category
ORDER BY sales DESC

SELECT * FROM superstore
ORDER BY ship_date



