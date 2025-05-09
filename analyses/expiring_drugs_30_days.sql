SELECT 
    fi.drug_id,
    di.brand_name,
    fi.expiry_date,
    fi.quantity
FROM PHARMA_DB.P_ANALYTICS_SCH.FACT_INVENTORY fi
JOIN PHARMA_DB.P_ANALYTICS_SCH.DIM_DRUGS di 
    ON fi.drug_id = di.drug_id
WHERE fi.expiry_date BETWEEN CURRENT_DATE AND DATEADD(DAY, 30, CURRENT_DATE)
ORDER BY fi.expiry_date