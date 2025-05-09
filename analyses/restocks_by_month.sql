SELECT 
    d."year",
    d."month",
    COUNT(*) AS restock_events
FROM PHARMA_DB.P_ANALYTICS_SCH.FACT_INVENTORY fi
JOIN PHARMA_DB.P_ANALYTICS_SCH.DATE_DIMENSION d 
    ON fi.restock_date_id = d."date_id_pk"
GROUP BY d."year", d."month"
ORDER BY d."year", d."month"
