SELECT
    d.drug_id,
    d.name AS drug_name,
    d.generic_name,
    d.category,
    COUNT(pi.item_id) AS total_prescriptions,
    SUM(pi.quantity) AS total_quantity_prescribed,
    AVG(pi.duration_days) AS avg_duration
FROM {{ source('pharma', 'PRESCRIPTION_ITEMS') }} pi
JOIN {{ source('pharma', 'DRUGS') }} d ON pi.drug_id = d.drug_id
GROUP BY d.drug_id, d.name, d.generic_name, d.category
