# Digital Payments Transaction Intelligence Platform — Executive Summary

**Prepared by:** Surajit Sutradhar
**Dataset:** UPI Transactions 2024 (250,000 transactions, synthetic)
**Period covered:** January 1, 2024 – December 30, 2024

---

## Executive Summary

Analysis of 250,000 UPI transactions across 2024 shows a stable, healthy payments
platform generating **₹32.79 crore (₹327,939,009)** in total transaction value.
Reliability holds steady at **95.05%** with no meaningful weakness across network
type, device type, hour of day, or month. Customer behavior is driven primarily
by age group rather than geography, with five distinct personas identified through
segment-level RFM clustering. Short-term daily TPV is forecastable with modest
accuracy using Prophet, which outperformed ARIMA, SARIMA, and a naive baseline.
Current fraud labels (**0.192%** of transactions) show no statistically significant
correlation with available transaction features — a data/schema limitation to
address before any production fraud model would be viable.

---

## Key Findings

### Growth & TPV
- Total 2024 TPV: **₹327,939,009**
- Maharashtra leads all states (~₹49M), followed by Uttar Pradesh and Karnataka
- Top 5 states account for the majority of platform TPV (see `sql/queries/06_top5_states_tpv_share.sql`)

### Reliability
- Overall success rate: **95.05%**
- Stable within 0.4–0.9 percentage points across network type, device type, their
  interaction, hour of day, and month — no systematic reliability risk identified
- The only elevated variance (3G×Web, WiFi×Web) traced to small sample sizes
  (under 1,300 transactions), not a genuine platform issue

### Customer Segments
Five personas identified via K-Means clustering (K=5, chosen via elbow method +
silhouette score, silhouette improving from ~0.455 to ~0.50 at K=5):

| Persona | Frequency | Monetary | Avg Txn Value | Segments |
|---|---|---|---|---|
| Premium / Power Users | 10,078 | ₹13.3M | ₹1,323 | 7 |
| High-Value Core | 6,370 | ₹8.8M | ₹1,390 | 14 |
| High-Frequency, Lower-Value | 5,881 | ₹7.0M | ₹1,193 | 9 |
| Casual / Mid-tier | 2,484 | ₹3.3M | ₹1,332 | 10 |
| Dormant / Low-Engagement | 1,251 | ₹1.5M | ₹1,187 | 10 |

Age group — not state — is the dominant behavioral driver; state acts mainly as
a volume multiplier within each age band.

### Forecasting
- Compared Naive baseline, ARIMA(2,0,2), SARIMA(2,0,2)x(1,1,1,7), and Prophet
  on 30-day held-out daily TPV
- **Prophet performed best** (RMSE 63,786 / MAE 51,742), narrowly beating the
  naive mean baseline (RMSE 64,311 / MAE 52,697)
- ARIMA and SARIMA both underperformed the naive baseline — SARIMA's seasonal
  coefficients were statistically insignificant (p=0.090, p=0.328) despite a
  visible weekly pattern in raw data, indicating the effect is real but too
  weak, relative to daily noise, for a hard-parameterized model to exploit reliably

### Risk & Fraud
- Fraud rate: **0.192%** (480 of 250,000 transactions), consistent with real-world UPI benchmarks
- Neither rule-based flags nor Isolation Forest anomaly scores meaningfully
  separated fraud from legitimate transactions on available features (amount,
  time, category, device, network)
- Conclusion: this reflects a **data limitation**, not a detection failure —
  production fraud modeling would require user-level velocity, device
  fingerprinting, and geolocation data not present in this schema

---

## Growth Opportunities
- Prioritize merchant partnerships and incentives in top-TPV categories and states
- If P2M growth is outpacing P2P (see `sql/queries/05_p2p_vs_p2m_growth.sql`),
  continue investing in merchant acquisition — a direct signal it's working
- Explore weekend-specific promotions for categories showing weekend spend spikes

## Risk Analysis
- No urgent infrastructure fix indicated by current reliability data
- Fraud detection should be treated as a **data collection priority**: add
  user-level identifiers and device/location signals before attempting a
  production-grade model

## Customer Retention Strategies
- Target the Dormant/Low-Engagement persona (56+, lowest across every metric
  in every state) with simplified UX or targeted re-engagement outreach
- High-Frequency/Lower-Value persona (18-25) responds better to volume-based
  incentives (cashback, small-ticket promotions) than premium upsells
- Premium/Power Users are strong candidates for loyalty tiers and priority support

## Product Suggestions
- Consider a lightweight in-app forecast/budgeting feature for P2M-heavy merchants,
  informed by the TPV forecasting model
- Investigate the Web channel specifically — while its lower sample size limits
  conclusions, its slightly wider rate variance is worth monitoring as Web volume grows

---

*Full methodology, SQL queries, and notebooks available in this repository's
`sql/`, `notebooks/`, and `data/` directories.*