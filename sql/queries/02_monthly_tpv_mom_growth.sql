SELECT
    d.year, d.month, d.month_name,
    SUM(f.amount_inr) AS monthly_tpv,
    ROUND(
        100.0 * (SUM(f.amount_inr) - LAG(SUM(f.amount_inr)) OVER (ORDER BY d.year, d.month))
        / LAG(SUM(f.amount_inr)) OVER (ORDER BY d.year, d.month), 2
    ) AS mom_growth_pct
FROM fact_transactions f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;