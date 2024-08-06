/* https://datalemur.com/questions/supercloud-customer
A Microsoft Azure Supercloud customer is defined as a customer who has purchased at least one product from every product category listed in the products table.

Write a query that identifies the customer IDs of these Supercloud customers. */

WITH
prep AS (
  SELECT 
    customer_id
    , COUNT(DISTINCT product_category) AS product_count
  FROM customer_contracts AS cc
  JOIN products AS p
    ON cc.product_id = p.product_id
  GROUP BY 1
  ORDER BY 1
)
SELECT
  customer_id
FROM prep
WHERE product_count = (
SELECT COUNT(DISTINCT product_category) FROM products
)
