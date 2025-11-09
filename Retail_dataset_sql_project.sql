-- SQL Retail Analysis project

-- Creating database

create database pulp;
use pulp;
truncate table Retail_dataset;

-- Creating table 

Drop table Retail_dataset;

CREATE TABLE Retail_dataset (
    transactions_id INT PRIMARY KEY,
    sale_date DATE NULL,
    sale_time TIME NULL,
    customer_id INT NULL,
    gender VARCHAR(50) NULL,
    age INT null,
    category VARCHAR(50) NULL,
    quantiy INT NULL,
    price_per_unit float NULL,
    cogs FLOAT NULL,
    total_sale float NULL
);

show columns from Retail_dataset;

SELECT COUNT(*) FROM Retail_dataset;

SELECT * FROM Retail_dataset
limit 10;

-- queries to find required results

-- finding columns having null values

SELECT * FROM Retail_dataset
WHERE transactions_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantiy IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;

Delete from  Retail_dataset
where transactions_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantiy IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;
        
SELECT 
    COUNT(*)
FROM
    Retail_dataset;
    
-- Data Analysis and Business Key problems and Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT 
    *
FROM
    Retail_dataset
WHERE
    sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

SELECT 
    *
FROM
    Retail_dataset
WHERE
    category = 'Clothing' AND quantiy > 3
        AND MONTH(sale_date) = '11'
        AND YEAR(sale_date) = '2022';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    category, SUM(total_sale) AS category_sales
FROM
    Retail_dataset
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
    AVG(age)
FROM
    Retail_dataset
WHERE
    category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT 
    *
FROM
    Retail_dataset
WHERE
    total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
    category, gender, COUNT(transactions_id)
FROM
    Retail_dataset
GROUP BY category , gender;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
    MONTH(sale_date) AS Months, AVG(total_sale) AS avg_sales
FROM
    Retail_dataset
GROUP BY MONTH(sale_date)
ORDER BY avg_sales DESC
LIMIT 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT 
    customer_id, SUM(total_sale) AS sales
FROM
    Retail_dataset
GROUP BY customer_id
ORDER BY sales DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

with customer as (
select  customer_id, count(distinct(category)) as category_count from Retail_dataset
group by customer_id
)
select count(*) from customer
where category_count =3;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT 
    CASE
        WHEN sale_time < '12:00:00' THEN 'morninng'
        WHEN
            sale_time > '12:00:00'
                AND sale_time < '17:00:00'
        THEN
            'afternoon'
        ELSE 'evening'
    END AS shift,
    COUNT(customer_id) AS total_order
FROM
    Retail_dataset
GROUP BY shift;







