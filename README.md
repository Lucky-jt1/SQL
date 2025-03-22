# SQL
This repository contains SQL projects along with the associated datasets. It showcases various SQL queries, data analysis techniques, and database management practices


# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

**Retail Sales Analysis SQL Project**

**Database Setup**
```
SQL
CREATE DATABASE SQL_project;
```

**Drop table if exists before creating a new one**
```
SQL
DROP TABLE IF EXISTS salestable;
```

**Create Table**
```
SQL
CREATE TABLE salestable (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(20),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

**Data Exploration & Cleaning**

**Check total number of records**
```
SQL
SELECT COUNT(*) AS total_records FROM salestable;
```

**Check unique customers**
```
SQL
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM salestable;
```

**Check unique product categories**
```
SQL
SELECT DISTINCT category FROM salestable;
```

**Check for NULL values**
```
SQL
SELECT * FROM salestable
WHERE transactions_id IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
      gender IS NULL OR age IS NULL OR category IS NULL OR 
      quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL;
```

**Remove records with NULL values**
```
SQL
DELETE FROM salestable
WHERE transactions_id IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
      gender IS NULL OR age IS NULL OR category IS NULL OR 
      quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL;
```

**Data Analysis & Findings**

**Retrieve all sales on a specific date**
```
SQL
SELECT * FROM salestable WHERE sale_date = '2022-11-05';
```

**Retrieve transactions where category is 'Clothing' and quantity sold is >= 4 in Nov 2022**
```
SQL
SELECT * FROM salestable
WHERE category = 'Clothing'
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND quantity >= 4;
```

**Calculate total sales per category**
```
SQL
SELECT category, SUM(total_sale) AS net_sales FROM salestable GROUP BY category;
```

**Find average age of customers in the 'Beauty' category**
```
SQL
SELECT ROUND(AVG(age), 2) AS average_age FROM salestable WHERE category = 'Beauty';
```

**Retrieve transactions with total sales > 1000**
```
SQL
SELECT * FROM salestable WHERE total_sale > 1000;
```

**Count total transactions per gender and category**
```
SQL
SELECT gender, category, COUNT(transactions_id) AS total_transactions
FROM salestable
GROUP BY gender, category
ORDER BY category;
```

**Find the top-selling month in each year based on average sales**
```
SQL
SELECT year, month, avg_sale FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM salestable
    GROUP BY 1, 2
) AS ranked_sales
WHERE rank = 1;
```

**Top 5 customers based on highest total sales**
```
SQL
SELECT customer_id, SUM(total_sale) AS total_sales
FROM salestable
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

**Count unique customers who purchased items in each category**
```
SQL
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers FROM salestable GROUP BY category;
```

**Classify transactions into shifts and count total orders**
```
SQL
WITH hourly_sales AS (
    SELECT *,
           CASE
               WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
               WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift
    FROM salestable
)
SELECT shift, COUNT(*) AS total_orders FROM hourly_sales GROUP BY shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


