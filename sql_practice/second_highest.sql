/* https://datalemur.com/questions/sql-second-highest-salary 
Imagine you're an HR analyst at a tech company tasked with analyzing employee salaries. Your manager is keen on understanding the pay distribution and asks you to determine the second highest salary among all employees.

It's possible that multiple employees may share the same second highest salary. In case of duplicate, display the salary only once. */

WITH 
prep AS (
SELECT 
  employee_id
  , salary
  , DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employee
)
SELECT DISTINCT
  salary
FROM prep
WHERE salary_rank = 2
