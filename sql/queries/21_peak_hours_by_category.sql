SELECT mc.merchant_category, f.hour_of_day,
       COUNT(*) AS txn_count,
       SUM(f.amount_inr) AS tpv
FROM fact_transactions f
JOIN dim_merchant_category mc ON f.merchant_category_key = mc.merchant_category_key
GROUP BY mc.merchant_category, f.hour_of_day
ORDER BY mc.merchant_category, f.hour_of_day;