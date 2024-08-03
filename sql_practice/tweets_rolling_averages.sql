/* https://datalemur.com/questions/rolling-average-tweets 
Given a table of tweet data over a specified time period, calculate the 3-day rolling average of tweets for each user. Output the user ID, tweet date, and rolling averages rounded to 2 decimal places. */

WITH 
prep AS 
(
  SELECT 
  user_id
  , tweet_date
  , ROUND(AVG(tweet_count) 
    OVER (PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_3d
  FROM tweets
)
SELECT *
FROM prep
ORDER BY 1, 2
