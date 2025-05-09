SELECT 
    dm.manufacturer_name,
    SUM(fi.quantity) AS total_quantity
FROM PHARMA_DB.P_ANALYTICS_SCH.FACT_INVENTORY fi
JOIN PHARMA_DB.P_ANALYTICS_SCH.DIM_DRUGS dd 
    ON fi.drug_id = dd.drug_id
JOIN PHARMA_DB.P_ANALYTICS_SCH.DIM_MANUFACTURER dm 
    ON dd.manufacturer_id = dm.manufacturer_id
GROUP BY dm.manufacturer_name
ORDER BY total_quantity DESC