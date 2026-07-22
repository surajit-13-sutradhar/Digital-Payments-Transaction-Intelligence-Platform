SELECT ag.age_range,
       COUNT(*) AS txn_count,
       SUM(f.amount_inr) AS total_spend,
       ROUND(AVG(f.amount_inr), 2) AS avg_txn_value
FROM fact_transactions f
JOIN dim_age_group ag ON f.age_group_key = ag.age_group_key
GROUP BY ag.age_range
ORDER BY avg_txn_value DESC;