SELECT f.hour_of_day,
       COUNT(*) AS total_txns,
       ROUND(100.0 * SUM(CASE WHEN f.transaction_status = 'SUCCESS' THEN 1 ELSE 0 END) / COUNT(*), 2) AS success_rate_pct
FROM fact_transactions f
GROUP BY f.hour_of_day
ORDER BY f.hour_of_day;