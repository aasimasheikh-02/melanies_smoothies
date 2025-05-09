SELECT 
    state,
    COUNT(*) AS pharmacy_count
FROM PHARMA_DB.P_ANALYTICS_SCH.DIM_PHARMACIES
GROUP BY state
ORDER BY pharmacy_count DESC
