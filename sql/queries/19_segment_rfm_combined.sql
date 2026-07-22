SELECT g.sender_state, ag.age_range,
       CAST(julianday((SELECT MAX(full_date) FROM dim_date)) - julianday(MAX(d.full_date)) AS INTEGER) AS recency_days,
       COUNT(*) AS frequency,
       SUM(f.amount_inr) AS monetary_total,
       ROUND(AVG(f.amount_inr), 2) AS avg_txn_value
FROM fact_transactions f
JOIN dim_geography g ON f.sender_state_key = g.sender_state_key
JOIN dim_age_group ag ON f.age_group_key = ag.age_group_key
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY g.sender_state, ag.age_range
ORDER BY monetary_total DESC;