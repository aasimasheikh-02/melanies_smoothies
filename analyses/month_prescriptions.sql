SELECT 
    d."year",
    d."month",
    COUNT(fp.prescription_id) AS total_prescriptions
FROM PHARMA_DB.P_ANALYTICS_SCH.FACT_PRESCRIPTIONS fp
JOIN PHARMA_DB.P_ANALYTICS_SCH.DATE_DIMENSION d
    ON d."date" = fp.issue_date
GROUP BY d."year", d."month"
ORDER BY d."year", d."month"
