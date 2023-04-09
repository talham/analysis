/* Using this dataset, show the SQL query to find the rolling 3 day average transaction amount for each day in January 2021. */

with daily_sum as (
select transaction_time::date as t_date,
sum(transaction_amount) as total, count(transaction_amount) as nos
from transactions 
group by 1
)
, running as (
  select 
t_date, 
sum(total) over 
(ORDER by t_date ASC  ROWS 2 PRECEDING  ) as running_sum,
sum(nos) over 
(ORDER by t_date ASC  ROWS 2 PRECEDING  ) as running_count
from daily_sum
) 
select
t_date,
running_sum as total_amnt_trailing_3day,
running_count as trns_trailing_3day,
running_sum / running_count as avg_amt_trailing_3day
from running