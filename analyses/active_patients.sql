SELECT 
    AVG(age) AS avg_age
FROM PHARMA_DB.P_ANALYTICS_SCH.DIM_PATIENTS
WHERE patient_status = 'Active'
