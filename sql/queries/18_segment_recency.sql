SELECT g.sender_state, ag.age_group,
       MAX(d.full_date) AS last_transaction_date,
       CAST(julianday((SELECT MAX(full_date) FROM dim_date)) - julianday(MAX(d.full_date)) AS INTEGER) AS days_since_last_txn
FROM fact_transactions f
JOIN dim_geography g ON f.sender_state_key = g.sender_state_key
JOIN dim_age_group ag ON f.age_group_key = ag.age_group_key
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY g.sender_state, ag.age_group
ORDER BY days_since_last_txn DESC;