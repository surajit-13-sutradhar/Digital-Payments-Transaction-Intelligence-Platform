SELECT d.is_weekend, SUM(f.amount_inr) AS tpv, COUNT(*) AS txn_count,
       ROUND(AVG(f.amount_inr), 2) AS avg_txn_value
FROM fact_transactions f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.is_weekend;
