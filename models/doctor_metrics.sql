SELECT
    doc.doctor_id,
    doc.name,
    doc.specialization,
    COUNT(DISTINCT p.prescription_id) AS total_prescriptions,
    COUNT(DISTINCT pi.drug_id) AS unique_drugs_prescribed,
    AVG(pi.quantity) AS avg_drug_quantity_per_prescription
FROM {{ source('pharma', 'DOCTORS') }} doc
LEFT JOIN {{ source('pharma', 'PRESCRIPTIONS') }} p ON doc.doctor_id = p.doctor_id
LEFT JOIN {{ source('pharma', 'PRESCRIPTION_ITEMS') }} pi ON p.prescription_id = pi.prescription_id
GROUP BY doc.doctor_id, doc.name, doc.specialization
