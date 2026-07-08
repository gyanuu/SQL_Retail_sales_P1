
-- SQL Reatail Sales Analysis p1--
CREATE DATABASE sql_project_p1

-- create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
               (
                transactions_id	INT PRIMARY KEY,
				sale_date DATE,
				sale_time	TIME,
				customer_id	INT,
				gender	VARCHAR(15),
				age	INT,
				category	VARCHAR(15),
				quantiy	INT,
				price_per_unit	FLOAT,
				cogs	FLOAT,
				total_sale FLOAT
				
			);

			
-- TABLE WITH  10 r0ws
SELECT * FROM retail_sales
LIMIT 10;

-- Check the data is imported in correct manner or not
SELECT COUNT(*) FROM retail_sales

        ---------- DATA CLEANING-------
	   
-- Check the NULL Value in dataset--
SELECT * FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date is NULL
   OR sale_time is NULL
   OR customer_id is NULL
   OR gender is NULL
   OR age is NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- DELETE the null value rows__
DELETE  FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date is NULL
   OR sale_time is NULL
   OR customer_id is NULL
   OR gender is NULL
   OR age is NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

   ----------- DATA EXPLORATION----
   --How many sales we have?
   SELECT COUNT(*) AS total_sale FROM retail_sales;
   -- How many customer we have?
   SELECT COUNT( DISTINCT customer_id) FROM retail_sales;


   -------- Data Analysis and Business Analystics Problem and Answers-----
   
--Q1 -> Write a SQL querry to retrieve all columns form sales made on "2022-11-05"?
   SELECT * 
   FROM retail_sales
   WHERE sale_date = '2022-11-05';

--Q2 -> Write a SQL query to retrive all the transactions where the category is 'Clothing' and qunatity sold is more than 4 in the month of Nov-2022

   SELECT * 
   FROM retail_sales
   WHERE
        category = 'Clothing'
		AND
		quantiy >=4
		AND
		TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'

-- Q3 -> Write a SQL query to calculate the total sales(total_sale) for each category.
	SELECT 
	      category,
		  SUM(total_sale) as net_sale,
		  COUNT(*) AS total_order
	FROM retail_sales
	GROUP BY category;

--Q4 -> Write a SQL query to find the average age of customers who purchased items from the 'Beauty category'
   SELECT ROUND(AVG(age),0) AS Average_age
   FROM retail_sales
   WHERE category = 'Beauty';

--Q5 -> Write a SQL query to find all transactions where the total sale is greater than 1000.
   SELECT *
   FROM retail_sales
   WHERE total_sale > 1000;

-- Q6-> Write a SQL query to find the total number of transaction(transaction_id) made by each gender in each category
   SELECT category, 
          gender,
   COUNT(transactions_id) AS transctions
   FROM retail_sales
   GROUP BY category,gender;

-- Q7-> Write a SQL query to calculate the average sale of each month.Find out the best selling month in each year.
    SELECT
	      EXTRACT(year FROM sale_date) AS YEAR,
		  EXTRACT(month FROM sale_date) AS MONTH,
	ROUND(AVG(total_sale)::numeric, 1) AS avg_sale
	FROM retail_sales
	GROUP BY 1,2
	ORDER BY 1,2,3;

--Q8 -> Write a SQL query to find the top customers based on highest total sales
   SELECT 
        customer_id,
		SUM(total_sale) AS TOTAL_SALES
		FROM retail_sales
		GROUP BY 1
		ORDER BY 2 DESC
		LIMIT 5

-- Q9 -> Write a SQL query to find the number of unique customers who purchased items from each category.
	  SELECT
	       category,
		   COUNT(DISTINCT customer_id) AS Uniq_Customer
	FROM retail_sales
	GROUP BY category;

--Q10-> Write a SQL query to create each shift and number of orders(Example Morning <12, afternoon between 12 & 17, Evening >17)
  WITH hourly_sale
  AS
  (
   SELECT *,
   CASE
       WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
       WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	   ELSE 'Eveining'
	   END AS shift
	FROM retail_sales
	)
	SELECT shift,
	COUNT(*) AS Total_order
	FROM hourly_sale
	GROUP BY Shift

-- END of the project
	   
		