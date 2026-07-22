SELECT
    tt.transaction_type, d.month,
    SUM(f.amount_inr) AS monthly_tpv,
    COUNT(*) AS txn_count
FROM fact_transactions f
JOIN dim_transaction_type tt ON f.transaction_type_key = tt.transaction_type_key
JOIN dim_date d ON f.date_key = d.date_key
WHERE tt.transaction_type IN ('P2P', 'P2M')
GROUP BY tt.transaction_type, d.month
ORDER BY tt.transaction_type, d.month;