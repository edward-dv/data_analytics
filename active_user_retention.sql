/* https://datalemur.com/questions/user-retention
Assume you're given a table containing information on Facebook user actions. Write a query to obtain number of monthly active users (MAUs) in July 2022, including the month in numerical format "1, 2, 3".
Hint:
An active user is defined as a user who has performed actions such as 'sign-in', 'like', or 'comment' in both the current month and the previous month. */

WITH
prep AS (
SELECT 
  user_id
  , DATE_PART('month', DATE_TRUNC('month', event_date)) AS month
  , COUNT(DISTINCT CASE WHEN event_type IN ('sign-in', 'like', 'comment') THEN event_id END) AS events
FROM user_actions
GROUP BY 1, 2
)
, prep2 AS (
SELECT 
  user_id
  , month
  , events
  , LAG(events) OVER (PARTITION BY user_id ORDER BY month) AS events_lag
FROM prep 
ORDER BY 1
)
SELECT
 month
 , COUNT(DISTINCT CASE WHEN events > 0 AND events_lag > 0 THEN user_id END) monthly_active_users
FROM prep2
WHERE month = 7
GROUP BY 1
