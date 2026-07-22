SELECT dv.device_type,
       COUNT(*) AS total_txns,
       ROUND(100.0 * SUM(CASE WHEN f.transaction_status = 'SUCCESS' THEN 1 ELSE 0 END) / COUNT(*), 2) AS success_rate_pct
FROM fact_transactions f
JOIN dim_device dv ON f.device_type_key = dv.device_type_key
GROUP BY dv.device_type
ORDER BY success_rate_pct ASC;