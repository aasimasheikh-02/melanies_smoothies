SELECT 
    di.drug_id,
    di.brand_name,
    SUM(fi.quantity) AS total_quantity
FROM PHARMA_DB.P_ANALYTICS_SCH.FACT_INVENTORY fi
JOIN PHARMA_DB.P_ANALYTICS_SCH.DIM_DRUGS di
    ON fi.drug_id = di.drug_id
GROUP BY di.drug_id, di.brand_name
ORDER BY total_quantity DESC
