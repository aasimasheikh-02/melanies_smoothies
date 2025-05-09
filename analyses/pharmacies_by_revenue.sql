SELECT 
    fi.pharmacy_id,
    fi.pharmacy_name,
    SUM(di.price * fi.quantity) AS total_revenue_estimate
FROM PHARMA_DB.P_ANALYTICS_SCH.FACT_INVENTORY fi
JOIN PHARMA_DB.P_ANALYTICS_SCH.DIM_DRUGS di
    ON fi.drug_id = di.drug_id
GROUP BY fi.pharmacy_id, fi.pharmacy_name
ORDER BY total_revenue_estimate DESC


