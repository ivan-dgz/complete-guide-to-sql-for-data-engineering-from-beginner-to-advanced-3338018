---- SQL ANALYTICAL FUNCTIONS: RANK()
-- Assigns a unique rank to each distinct row
-- Ranks are not consecutive (same values will have same rank)
-- Ranking values have gaps when there are ties
SELECT customer_id, RANK() over (partition by customer_id order by total_amount desc) as order_rank, total_amount
FROM orders;