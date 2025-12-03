show databases;
use meg;
SHOW TABLES;
SELECT * from `sql - retail sales analysis_utf`;
select count(*) from  `sql - retail sales analysis_utf`;
SHOW TABLES;
RENAME TABLE  `sql - retail sales analysis_utf` TO raj;
SHOW TABLES;
SELECT * FROM raj
where ï»¿transactions_id is null;

##data exploration

describe raj;
select count(*) from raj;

select count(*) as total_sale from raj;


SELECT COUNT(DISTINCT customer_id) as total_sale from raj;

select distinct category from raj;

####data analysis and business key problems question and answer
 
## Q.1 write a sql query to retrieve all columns for sales made on 22-11-05
select * from raj
where sale_date = '2022-11-05'; 

#write a sql query to retrieve all transactions  where the category is 'clothing' and the quantity solad is more than 10 in the month of nov 22

SELECT *
FROM raj
WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND quantiy >= 4;
 describe raj;
 
 ##Q.3 write a sql quey to calculate the total sales(total_sales) fro each category
 select category , sum(total_sale) as net_sale ,count(*) as total_orders 
 FROM raj
 group by category;
 
 ###4. write a sql query to find the average age of customers who purchased items from the 'beauty' category;
 
SELECT AVG(age)
from raj
where category = 'Beauty' ;

###6.write a sql query to find all transactions where the total_sale  is greater than 10000

select * from raj
where total_sale > 1000 ;

### Q7.write a sql query to find the total number of transactions (transaction_id) made by each gender in eacch category

Select
category,gender,
count(*) as total_trans
from raj
group by category,gender
order by 1 ;

###8.write a sql query to calculate the average sale for each month .find out best selling month in each year

SELECT 
    yr,
    mn,
    avg_sale,
    RANK() OVER (
        PARTITION BY yr
        ORDER BY avg_sale DESC
    ) AS rnk
FROM (
    SELECT 
        YEAR(sale_date) AS yr,
        MONTH(sale_date) AS mn,
        AVG(total_sale) AS avg_sale
    FROM raj
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t
ORDER BY yr, mn; 

## Q9.write a sql query to find the top 5 customers based on thr highest total sales

select customer_id,
sum(total_sale)as total_sales from raj
group by 1
order by 2 DESC
LIMIT 5;

##Q9.write a sql query to find  the number of unique customers who purchased items from each category
SELECT category,
count(distinct customer_id) as cnt_unique_cs 
 FROM raj
 group by category;
 
 ### Q!0.write a ssql query to create each shift and number of orders (wxample morning<=12 ,afternoon between12 &17 evening>17)
 
 SELECT 
    CASE
        WHEN HOUR(STR_TO_DATE(sale_time, '%H:%i:%s')) < 12 THEN 'Morning'
        WHEN HOUR(STR_TO_DATE(sale_time, '%H:%i:%s')) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM raj
GROUP BY shift
ORDER BY total_orders DESC;






 
 