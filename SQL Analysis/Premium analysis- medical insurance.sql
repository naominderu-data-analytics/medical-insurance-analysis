
PREMIUM REVENUE ANALYSIS

---------Revenue by Region

SELECT
    region,
    ROUND(SUM(annual_premium),2) AS total_premiums
FROM medical_insurance
GROUP BY region
ORDER BY total_premiums DESC;

--------Plan Profitability

SELECT
    plan_type,
    ROUND(SUM(annual_premium),2) AS premium_revenue,
    ROUND(SUM(total_claims_paid),2) AS claims_paid,
    ROUND(
        SUM(annual_premium) - SUM(total_claims_paid),2
    ) AS profit
FROM medical_insurance
GROUP BY plan_type
ORDER BY profit DESC;

--------Deductible Behaviour

SELECT
    deductible,
    COUNT(*) AS members,
    ROUND(AVG(total_claims_paid),2) AS avg_claims,
    ROUND(AVG(annual_premium),2) AS avg_premium
FROM medical_insurance
GROUP BY deductible;

------Premium by employment status

SELECT
    employment_status,
    COUNT(*)                                AS policyholders,
    ROUND(AVG(annual_premium), 2)           AS avg_premium,
    ROUND(AVG(income), 2)                   AS avg_income,
    ROUND(AVG(annual_premium / NULLIF(income, 0)) * 100, 2) AS premium_as_pct_income,
    ROUND(AVG(total_claims_paid), 2)        AS avg_claims_paid
FROM medical_insurance
GROUP BY employment_status
ORDER BY avg_premium DESC;







































