/* https://datalemur.com/questions/yoy-growth-rate

Assume you're given a table containing information about Wayfair user transactions for different products. Write a query to calculate the year-on-year growth rate for the total spend of each product, grouping the results by product ID.

The output should include the year in ascending order, product ID, current year's spend, previous year's spend and year-on-year growth percentage, rounded to 2 decimal places. */

WITH 
prep AS (
  SELECT 
    product_id
    , DATE_TRUNC('year', transaction_date) AS year
    , SUM(spend) AS curr_year_spend
  FROM user_transactions
  GROUP BY 1, 2
)
SELECT
  DATE_PART('year',year) AS year
  , product_id
  , curr_year_spend 
  , LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY year) AS prev_year_spend
  , ROUND(((curr_year_spend - LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY year)) 
    / LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY year)) * 100, 2)  AS yoy_rate
FROM prep
ORDER BY 2, 1 ASC
