SELECT g.sender_state, SUM(f.amount_inr) AS tpv,
       ROUND(100.0 * SUM(f.amount_inr) / (SELECT SUM(amount_inr) FROM fact_transactions), 2) AS pct_share
FROM fact_transactions f
JOIN dim_geography g ON f.sender_state_key = g.sender_state_key
GROUP BY g.sender_state
ORDER BY tpv DESC
LIMIT 5;