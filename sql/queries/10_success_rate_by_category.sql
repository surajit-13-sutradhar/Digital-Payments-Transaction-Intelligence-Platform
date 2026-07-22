SELECT mc.merchant_category,
       COUNT(*) AS total_txns,
       ROUND(100.0 * SUM(CASE WHEN f.transaction_status = 'SUCCESS' THEN 1 ELSE 0 END) / COUNT(*), 2) AS success_rate_pct
FROM fact_transactions f
JOIN dim_merchant_category mc ON f.merchant_category_key = mc.merchant_category_key
GROUP BY mc.merchant_category
ORDER BY success_rate_pct ASC;