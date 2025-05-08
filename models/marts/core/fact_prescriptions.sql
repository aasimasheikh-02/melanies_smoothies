SELECT
--   pi.item_id,
  p.prescription_id,
  p.issue_date,
  p.expiry_date,
--   p.STATUS_NORMALIZED,
  p.patient_id,
--   patient_name,
  p.doctor_id,
--   CONCAT(FIRST_NAME, LAST_NAME) AS doctor_name,
--   pi.drug_id,
--   BRAND_NAME,
--   pi.quantity,
--   pi.dosage,
--   pi.frequency,
--   pi.duration_days,
--   d.date_id AS issue_date_id
FROM {{ ref('prescriptions_tb') }} p
-- JOIN {{ ref('Prescription_items_tb') }} pi ON pi.prescription_id = p.prescription_id
-- LEFT JOIN {{ ref('dim_patients') }} pat ON p.patient_id = pat.patient_id
-- LEFT JOIN {{ ref('dim_doctors') }} doc ON p.doctor_id = doc.doctor_id
-- LEFT JOIN {{ ref('dim_drugs') }} drg ON pi.drug_id = drg.drug_id
-- LEFT JOIN {{ ref('dim_date') }} d ON p.issue_date = d.date
