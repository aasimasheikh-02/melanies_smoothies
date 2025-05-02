SELECT
    pt.patient_id,
    pt.name AS patient_name,
    d.name AS drug_name,
    pi.dosage,
    pi.frequency,
    pi.duration_days,
    pr.issue_date,
    DATEADD(day, pi.duration_days, pr.issue_date) AS end_date
FROM {{ source('pharma', 'PATIENTS') }} pt
JOIN {{ source('pharma', 'PRESCRIPTIONS') }} pr ON pt.patient_id = pr.patient_id
JOIN {{ source('pharma', 'PRESCRIPTION_ITEMS') }} pi ON pr.prescription_id = pi.prescription_id
JOIN {{ source('pharma', 'DRUGS') }} d ON pi.drug_id = d.drug_id
ORDER BY pt.patient_id, pr.issue_date
