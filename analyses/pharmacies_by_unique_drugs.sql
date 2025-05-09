SELECT 
    fi.pharmacy_id,
    fi.pharmacy_name,
    COUNT(DISTINCT fi.drug_id) AS unique_drug_count
FROM PHARMA_DB.P_ANALYTICS_SCH.FACT_INVENTORY fi
GROUP BY fi.pharmacy_id, fi.pharmacy_name
ORDER BY unique_drug_count DESC

