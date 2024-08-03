/* https://datalemur.com/questions/repeated-payments
Sometimes, payment transactions are repeated by accident; it could be due to user error, API failure or a retry error that causes a credit card to be charged twice.

Using the transactions table, identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other. Count such repeated payments. */ 

SELECT 
  COUNT(*) AS payment_count
FROM transactions AS t1
JOIN transactions AS t2
ON t1.merchant_id = t1.merchant_id
  AND t1.credit_card_id = t2.credit_card_id
  AND t1.amount = t2.amount
  AND t1.transaction_timestamp < t2.transaction_timestamp
  AND t2.transaction_timestamp - t1.transaction_timestamp <= INTERVAL '10 MINUTES';
