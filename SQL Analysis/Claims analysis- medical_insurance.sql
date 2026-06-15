SELECT * FROM medical_insurance;

-------What is the overall claims summary?

SELECT
    COUNT(*)                                    AS total_policyholders,
    SUM(claims_count)                           AS total_claims,
    ROUND(AVG(claims_count), 2)                 AS avg_claims_per_person,
    ROUND(AVG(avg_claim_amount), 2)             AS avg_claim_amount,
    ROUND(SUM(total_claims_paid), 2)            AS total_claims_paid,
    ROUND(SUM(annual_premium), 2)               AS total_premiums_collected,
    ROUND(SUM(total_claims_paid) / SUM(annual_premium), 4) AS overall_loss_ratio
FROM medical_insurance;

-------What is the claims frequency by age group

SELECT
CASE
    WHEN age < 18 THEN 'Under 18'
    WHEN age BETWEEN 18 AND 35 THEN '18-35'
    WHEN age BETWEEN 36 AND 50 THEN '36-50'
    WHEN age BETWEEN 51 AND 65 THEN '51-65'
    ELSE '65+'
END AS age_group,
COUNT(*) AS members,
ROUND(AVG(total_claims_paid),2) AS avg_claims
FROM medical_insurance
GROUP BY age_group
ORDER BY avg_claims DESC;

------Claims by gender

SELECT
    sex,
    COUNT(*)                                    AS policyholders,
    ROUND(AVG(claims_count), 2)                 AS avg_claims,
    ROUND(AVG(avg_claim_amount), 2)             AS avg_claim_value,
    ROUND(SUM(total_claims_paid) / SUM(annual_premium), 4) AS loss_ratio
FROM medical_insurance
GROUP BY sex
ORDER BY avg_claims DESC;

-------Claims by region

SELECT
    region,
    COUNT(*)                                    AS policyholders,
    ROUND(SUM(claims_count), 0)                 AS total_claims,
    ROUND(AVG(claims_count), 2)                 AS avg_claims_per_person,
    ROUND(SUM(total_claims_paid), 2)            AS total_paid,
    ROUND(SUM(annual_premium), 2)               AS total_premiums,
    ROUND(SUM(total_claims_paid) / SUM(annual_premium), 4) AS loss_ratio
FROM medical_insurance
GROUP BY region
ORDER BY loss_ratio DESC;

--------Claims by plan type
SELECT
    plan_type,
    COUNT(*)                                    AS policyholders,
    ROUND(AVG(claims_count), 2)                 AS avg_claims,
    ROUND(AVG(avg_claim_amount), 2)             AS avg_claim_value,
    ROUND(SUM(total_claims_paid) / SUM(annual_premium), 4) AS loss_ratio
FROM medical_insurance
GROUP BY plan_type
ORDER BY loss_ratio DESC;

-------High claimants — top 10% by total claims paid

SELECT
    person_id, age, sex, region, plan_type,
    claims_count, total_claims_paid,
    annual_premium,
    chronic_count, is_high_risk
FROM medical_insurance
WHERE total_claims_paid >= (
    SELECT total_claims_paid
    FROM medical_insurance
    ORDER BY total_claims_paid DESC
    LIMIT 1
    OFFSET (SELECT CAST(COUNT(*) * 0.10 AS INT) FROM medical_insurance)
)
ORDER BY total_claims_paid DESC
LIMIT 20;

-----Claimants vs non-claimants breakdown
SELECT
    CASE WHEN claims_count = 0 THEN 'No Claims' ELSE 'Has Claims' END AS claim_status,
    COUNT(*)                                    AS policyholders,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct_of_total,
    ROUND(AVG(annual_premium), 2)               AS avg_annual_premium,
    ROUND(AVG(risk_score), 4)                   AS avg_risk_score,
    ROUND(AVG(chronic_count), 2)                AS avg_chronic_conditions
FROM medical_insurance
GROUP BY claim_status;

-------Smoker status impact on claims
SELECT
    smoker,
    COUNT(*)                                    AS policyholders,
    ROUND(AVG(claims_count), 2)                 AS avg_claims,
    ROUND(AVG(total_claims_paid), 2)            AS avg_total_claimed,
    ROUND(AVG(annual_premium), 2)               AS avg_premium,
    ROUND(SUM(total_claims_paid) / SUM(annual_premium), 4) AS loss_ratio
FROM medical_insurance
GROUP BY smoker
ORDER BY avg_total_claimed DESC;




