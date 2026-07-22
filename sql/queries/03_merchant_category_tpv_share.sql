SELECT mc.merchant_category, SUM(f.amount_inr) AS tpv, COUNT(*) AS txn_count,
       ROUND(100.0 * SUM(f.amount_inr) / (SELECT SUM(amount_inr) FROM fact_transactions), 2) AS pct_of_total_tpv
FROM fact_transactions f
JOIN dim_merchant_category mc ON f.merchant_category_key = mc.merchant_category_key
GROUP BY mc.merchant_category
ORDER BY tpv DESC;