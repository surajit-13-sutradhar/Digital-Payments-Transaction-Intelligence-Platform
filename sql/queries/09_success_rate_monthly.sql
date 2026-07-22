SELECT d.year, d.month, d.month_name,
       COUNT(*) AS total_txns,
       SUM(CASE WHEN f.transaction_status = 'SUCCESS' THEN 1 ELSE 0 END) AS successful_txns,
       ROUND(100.0 * SUM(CASE WHEN f.transaction_status = 'SUCCESS' THEN 1 ELSE 0 END) / COUNT(*), 2) AS success_rate_pct
FROM fact_transactions f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;