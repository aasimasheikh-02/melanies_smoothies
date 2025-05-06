SELECT
  pi.item_id,
  p.prescription_id,
  p.issue_date,
  p.expiry_date,
  p.status,
  p.patient_id,
  pat.name AS patient_name,
  p.doctor_id,
  doc.name AS doctor_name,
  pi.drug_id,
  drg.name AS drug_name,
  pi.quantity,
  pi.dosage,
  pi.frequency,
  pi.duration_days,
  d.date_id AS issue_date_id
FROM {{ ref('stg_prescriptions') }} p
JOIN {{ ref('stg_prescription_items') }} pi ON pi.prescription_id = p.prescription_id
LEFT JOIN {{ ref('dim_patients') }} pat ON p.patient_id = pat.patient_id
LEFT JOIN {{ ref('dim_doctors') }} doc ON p.doctor_id = doc.doctor_id
LEFT JOIN {{ ref('dim_drugs') }} drg ON pi.drug_id = drg.drug_id
LEFT JOIN {{ ref('dim_date') }} d ON CAST(p.issue_date AS DATE) = d.date
