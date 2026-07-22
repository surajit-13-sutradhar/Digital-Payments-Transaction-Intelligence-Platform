SELECT n.network_type,
       COUNT(*) AS total_txns,
       ROUND(100.0 * SUM(CASE WHEN f.transaction_status = 'SUCCESS' THEN 1 ELSE 0 END) / COUNT(*), 2) AS success_rate_pct
FROM fact_transactions f
JOIN dim_network n ON f.network_type_key = n.network_type_key
GROUP BY n.network_type
ORDER BY success_rate_pct ASC;