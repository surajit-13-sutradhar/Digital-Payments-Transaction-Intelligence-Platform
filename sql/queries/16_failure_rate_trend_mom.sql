SELECT d.month, d.month_name,
       ROUND(100.0 * SUM(CASE WHEN f.transaction_status = 'FAILED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS failure_rate_pct,
       LAG(ROUND(100.0 * SUM(CASE WHEN f.transaction_status = 'FAILED' THEN 1 ELSE 0 END) / COUNT(*), 2))
           OVER (ORDER BY d.month) AS prev_month_failure_rate_pct
FROM fact_transactions f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.month, d.month_name
ORDER BY d.month;