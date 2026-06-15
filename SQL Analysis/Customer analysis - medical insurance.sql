CUSTOMER SEGMENTATION

-----Customer Segments by Risk

SELECT
CASE
    WHEN chronic_count = 0 THEN 'Low Risk'
    WHEN chronic_count <= 2 THEN 'Medium Risk'
    ELSE 'High Risk'
END AS risk_segment,
COUNT(*) AS customers,
ROUND(AVG(total_claims_paid),2) AS avg_claims,
ROUND(AVG(annual_premium),2) AS avg_premium
FROM medical_insurance
GROUP BY risk_segment;

------Premium Customer Segments

SELECT
CASE
    WHEN annual_premium < 2000 THEN 'Basic'
    WHEN annual_premium < 5000 THEN 'Standard'
    ELSE 'Premium'
END AS customer_tier,
COUNT(*) AS customers,
ROUND(AVG(total_claims_paid),2) AS avg_claims
FROM medical_insurance
GROUP BY customer_tier;

-------Top 10% Claimants

SELECT
    person_id,
    age,
    sex,
    region,
    plan_type,
    total_claims_paid
FROM medical_insurance
ORDER BY total_claims_paid DESC
LIMIT 20;







