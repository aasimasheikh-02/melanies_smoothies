SELECT 
    fi.drug_id,
    di.brand_name,
    fi.pharmacy_id,
    fi.quantity
FROM PHARMA_DB.P_ANALYTICS_SCH.FACT_INVENTORY fi
JOIN PHARMA_DB.P_ANALYTICS_SCH.DIM_DRUGS di 
    ON fi.drug_id = di.drug_id
WHERE fi.quantity < 100
ORDER BY fi.quantity desc