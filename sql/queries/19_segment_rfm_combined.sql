SELECT g.sender_state, ag.age_group,
       COUNT(*) AS frequency,
       SUM(f.amount_inr) AS monetary_total,
       ROUND(AVG(f.amount_inr), 2) AS avg_txn_value
FROM fact_transactions f
JOIN dim_geography g ON f.sender_state_key = g.sender_state_key
JOIN dim_age_group ag ON f.age_group_key = ag.age_group_key
GROUP BY g.sender_state, ag.age_group
ORDER BY monetary_total DESC;