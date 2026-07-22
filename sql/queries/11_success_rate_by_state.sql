SELECT g.sender_state,
       COUNT(*) AS total_txns,
       ROUND(100.0 * SUM(CASE WHEN f.transaction_status = 'SUCCESS' THEN 1 ELSE 0 END) / COUNT(*), 2) AS success_rate_pct
FROM fact_transactions f
JOIN dim_geography g ON f.sender_state_key = g.sender_state_key
GROUP BY g.sender_state
ORDER BY success_rate_pct ASC;