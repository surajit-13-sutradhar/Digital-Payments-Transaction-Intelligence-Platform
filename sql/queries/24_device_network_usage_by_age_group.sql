SELECT ag.age_range, dv.device_type,
       COUNT(*) AS txn_count,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY ag.age_range), 2) AS pct_within_age_group
FROM fact_transactions f
JOIN dim_age_group ag ON f.age_group_key = ag.age_group_key
JOIN dim_device dv ON f.device_type_key = dv.device_type_key
GROUP BY ag.age_range, dv.device_type
ORDER BY ag.age_range, dv.device_type;