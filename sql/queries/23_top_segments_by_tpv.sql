SELECT g.sender_state, ag.age_range,
       SUM(f.amount_inr) AS tpv,
       COUNT(*) AS txn_count,
       ROUND(100.0 * SUM(f.amount_inr) / (SELECT SUM(amount_inr) FROM fact_transactions), 2) AS pct_of_total_tpv
FROM fact_transactions f
JOIN dim_geography g ON f.sender_state_key = g.sender_state_key
JOIN dim_age_group ag ON f.age_group_key = ag.age_group_key
GROUP BY g.sender_state, ag.age_range
ORDER BY tpv DESC
LIMIT 10;