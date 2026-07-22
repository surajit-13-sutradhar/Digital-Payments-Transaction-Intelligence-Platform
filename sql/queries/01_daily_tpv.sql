SELECT d.full_date, SUM(f.amount_inr) AS daily_tpv, COUNT(*) AS txn_count
FROM fact_transactions f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.full_date
ORDER BY d.full_date;