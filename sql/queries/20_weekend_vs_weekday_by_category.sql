SELECT mc.merchant_category, d.is_weekend,
       SUM(f.amount_inr) AS tpv,
       COUNT(*) AS txn_count,
       ROUND(AVG(f.amount_inr), 2) AS avg_txn_value
FROM fact_transactions f
JOIN dim_merchant_category mc ON f.merchant_category_key = mc.merchant_category_key
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY mc.merchant_category, d.is_weekend
ORDER BY mc.merchant_category, d.is_weekend;