SELECT 
    dd.doctor_id,
    dd.first_name,
    dd.last_name,
    dd.specialization,
    COUNT(fp.prescription_id) AS total_patients
FROM PHARMA_DB.P_ANALYTICS_SCH.FACT_PRESCRIPTIONS fp
JOIN PHARMA_DB.P_ANALYTICS_SCH.DIM_DOCTORS dd
    ON fp.doctor_id = dd.doctor_id
GROUP BY dd.doctor_id, dd.first_name, dd.last_name, dd.specialization
ORDER BY total_patients DESC

