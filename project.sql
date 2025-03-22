-- Retail sales analysis
create database SQL_project; 

-- Drop table if exists salestable;
create table salestable
(
	transactions_id int primary key,
	sale_date date,	
	sale_time Time,
	customer_id	int,
	gender	varchar(20),
	age	int,
	category varchar(20),
	quantiy	int,
	price_per_unit float,
	cogs float,
	total_sale float
);

select * from salestable;

-- import data from the laptop
-- check to ensure the date is in format or not

-- database>schema>table

-- check all the rows are imported or not
select count(*) 
from salestable;


--      DATA CLEANING
-- check about NULL values
select * from salestable
WHERE transactions_id ISNULL;

select * from salestable
WHERE salestable.sale_data IS NULL;

select * from salestable
WHERE transactions_id ISNULL
	OR sale_time ISNULL
	OR customer_id ISNULL
	OR gender ISNULL
	OR age ISNULL
	OR category ISNULL
	OR quantiy ISNULL
	OR price_per_unit ISNULL
	OR cogs ISNULL
	OR total_sale ISNULL;
	
	
-- dealing with Null values

DELETE from salestable
WHERE transactions_id ISNULL
	OR sale_time ISNULL
	OR customer_id ISNULL
	OR gender ISNULL
	OR age ISNULL
	OR category ISNULL
	OR quantiy ISNULL
	OR price_per_unit ISNULL
	OR cogs ISNULL
	OR total_sale ISNULL;

-- DATA EXPLORATION

-- no of sales??
SELECT count(*) as total_sales from salestable;
-- no of unique customers??
SELECT COUNT(DISTINCT customer_id) as customers from salestable;
-- no of category
SELECT DISTINCT category from salestable;

select sale_date from salestable;
-- Q&A
-- count no of sales per day
SELECT salestable.sale_date,count(*) FROM salestable
group by sale_date;
-- wAqT retrive all the transactions of statisfy the conditions 
-- category 'clothing', quantity is >=4 ,in the month of NOV 2022
select sale_date from salestable
where TO_CHAR(sale_date,'YYYY-MM')='2022-11';

SELECT * from salestable
WHERE category='Clothing'
	and
	quantiy>=3
	and
	TO_CHAR(sale_date,'YYYY-MM')='2022-11';
	
-- total sales for each category
SELECT category,SUM(total_sale) as net_sales from salestable
group by category;

-- find avg age og beauty category
SELECT round(avg(age),2) as AVERAGE_AGE FROM salestable
WHERE category='Beauty';

-- total sale >1000
SELECT * FROM salestable
WHERE total_sale>=1000;

-- no of total transactiond in each category and each gender
SELECT gender,category,count(transactions_id) FROM salestable
GROUP BY gender,category 
order by category;

-- avg sale in each month,find highest selling month in each year
-- learn rank, extract, CTE

-- top 5 customers based on total sale
Select
	customer_id,
	sum(total_sale)
 from salestable
 group by customer_id
 order by sum desc
 limit 5;
 
 -- calculate no of customers who purchased items in each category
 SELECT 
 	category,
	count(distinct customer_id)
 from salestable
 GROUP BY category;
 
 
-- calculate no of based on shifts time>12,<=15,<=24
CREATE TABLE SHIFT AS
SELECT 
COUNT(*) AS sales_count,
CASE
	WHEN EXTRACT(hour from sale_time)<12 THEN 'Morning'
	WHEN EXTRACT(hour from sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
	END 
	as shift
FROM salestable
GROUP BY SHIFT;
SELECT * FROM SHIFT;
