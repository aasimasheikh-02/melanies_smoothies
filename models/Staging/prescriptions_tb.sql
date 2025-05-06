-- models/prescriptions_transformed.sql

SELECT
  prescription_id,
  patient_id,
  doctor_id,

  -- Parse date fields (assume they are either DATE or ISO-formatted)
  TO_DATE(issue_date) AS issue_date,
  TO_DATE(expiry_date) AS expiry_date,

  LOWER(status) AS status_normalized,

  -- Duration between issue and expiry
  DATEDIFF(DAY, TO_DATE(issue_date), TO_DATE(expiry_date)) AS prescription_duration_days,

  -- Days until or since expiry
  DATEDIFF(DAY, CURRENT_DATE, TO_DATE(expiry_date)) AS days_to_expiry,

  -- Check if currently valid
  CASE
    WHEN CURRENT_DATE BETWEEN TO_DATE(issue_date) AND TO_DATE(expiry_date) THEN 'Valid'
    WHEN CURRENT_DATE > TO_DATE(expiry_date) THEN 'Expired'
    ELSE 'Upcoming'
  END AS prescription_validity,

  -- Data quality check
  CASE
    WHEN issue_date IS NULL OR expiry_date IS NULL THEN 'Missing Dates'
    WHEN TO_DATE(expiry_date) < TO_DATE(issue_date) THEN 'Invalid Date Range'
    ELSE 'Valid Dates'
  END AS date_quality_flag

FROM {{ source('pharma', 'PRESCRIPTIONS') }}