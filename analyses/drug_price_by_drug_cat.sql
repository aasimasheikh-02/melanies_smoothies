SELECT 
    drug_category,
    AVG(price) AS avg_price
FROM PHARMA_DB.P_ANALYTICS_SCH.DIM_DRUGS
GROUP BY drug_category
ORDER BY avg_price DESC