SELECT mc.merchant_category, d.month, d.month_name,
       SUM(f.amount_inr) AS monthly_tpv
FROM fact_transactions f
JOIN dim_merchant_category mc ON f.merchant_category_key = mc.merchant_category_key
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY mc.merchant_category, d.month, d.month_name
ORDER BY mc.merchant_category, d.month;