/* https://datalemur.com/questions/sql-histogram-tweets 
Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.

In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group. */

WITH
prep AS (
  SELECT 
    user_id
    , COUNT(DISTINCT tweet_id) AS tweet_count
  FROM tweets
  WHERE tweet_date BETWEEN '01-01-2022' AND '12-31-2022'
  GROUP BY 1
)
SELECT 
  -- CASE 
  --   WHEN tweet_count = 1 THEN '1' 
  --   WHEN tweet_count = 2 THEN '2' 
  --   WHEN tweet_count = 3 THEN '3' 
  -- END AS tweet_bucket
  tweet_count AS tweet_bucket
  , COUNT(DISTINCT user_id) AS users_num
FROM prep
GROUP BY 1
ORDER BY 1
