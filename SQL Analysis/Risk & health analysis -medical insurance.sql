RISK & HEALTH ANALYSIS

-----Chronic Conditions

SELECT
    chronic_count,
    COUNT(*) AS members,
    ROUND(AVG(total_claims_paid),2) AS avg_claims
FROM medical_insurance
GROUP BY chronic_count
ORDER BY chronic_count;

-----Diabetes Impact

SELECT
    diabetes,
    ROUND(AVG(total_claims_paid),2) AS avg_claims
FROM medical_insurance
GROUP BY diabetes;

-----Hypertension Impact

SELECT
    hypertension,
    ROUND(AVG(total_claims_paid),2) AS avg_claims
FROM medical_insurance
GROUP BY hypertension;

-----BMI Impact

SELECT
CASE
    WHEN bmi < 18.5 THEN 'Underweight'
    WHEN bmi < 25 THEN 'Normal'
    WHEN bmi < 30 THEN 'Overweight'
    ELSE 'Obese'
END AS bmi_category,
ROUND(AVG(total_claims_paid),2) AS avg_claims
FROM medical_insurance
GROUP BY bmi_category
ORDER BY avg_claims DESC;

------Hospitalisation Costs

SELECT
    hospitalizations_last_3yrs,
    COUNT(*) AS members,
    ROUND(AVG(total_claims_paid),2) AS avg_claims
FROM medical_insurance
GROUP BY hospitalizations_last_3yrs;

------High-Risk Members

SELECT
    is_high_risk,
    COUNT(*) AS members,
    ROUND(AVG(total_claims_paid),2) AS avg_claims
FROM medical_insurance
GROUP BY is_high_risk;






















