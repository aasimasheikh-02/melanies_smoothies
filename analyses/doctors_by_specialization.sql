SELECT 
    specialization,
    COUNT(*) AS doctor_count
FROM PHARMA_DB.P_ANALYTICS_SCH.DIM_DOCTORS
GROUP BY specialization
ORDER BY doctor_count DESC