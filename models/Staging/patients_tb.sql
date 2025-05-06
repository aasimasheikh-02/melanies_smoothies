-- models/patients_tb.sql

SELECT
  patient_id,
  INITCAP(name) AS patient_name,  -- Capitalize each word in the name

  -- Assuming date_of_birth is already of type DATE or in YYYY-MM-DD format
  TO_DATE(date_of_birth) AS date_of_birth,

  LOWER(gender) AS gender,
  LOWER(blood_type) AS blood_type,
  address,

  -- Clean phone numbers
  REGEXP_REPLACE(phone, '[^0-9]', '') AS phone_digits,
  LOWER(email) AS email,
  emergency_contact,
  REGEXP_REPLACE(emergency_phone, '[^0-9]', '') AS emergency_phone_digits,

  -- Calculate age
  DATE_PART(YEAR, CURRENT_DATE) - DATE_PART(YEAR, TO_DATE(date_of_birth)) AS age,

  -- Categorize based on age
  CASE 
    WHEN DATE_PART(YEAR, CURRENT_DATE) - DATE_PART(YEAR, TO_DATE(date_of_birth)) <= 18 THEN 'Pediatric'
    WHEN DATE_PART(YEAR, CURRENT_DATE) - DATE_PART(YEAR, TO_DATE(date_of_birth)) BETWEEN 19 AND 64 THEN 'Adult'
    ELSE 'Senior'
  END AS age_group,

  -- Contact info status
  CASE 
    WHEN phone IS NULL OR phone = '' THEN 'Missing Phone'
    WHEN email IS NULL OR email = '' THEN 'Missing Email'
    ELSE 'Valid Contact Info'
  END AS contact_info_status,

  -- Address status
  CASE 
    WHEN address IS NULL OR address = '' THEN 'Invalid Address'
    ELSE 'Valid Address'
  END AS address_status,

  -- Extract birth month
  EXTRACT(MONTH FROM TO_DATE(date_of_birth)) AS birth_month,

  -- Patient status
  CASE
    WHEN phone IS NOT NULL AND phone != '' AND email IS NOT NULL AND email != '' AND emergency_contact IS NOT NULL AND emergency_contact != '' THEN 'Active'
    ELSE 'Inactive'
  END AS patient_status

FROM {{ source('pharma', 'PATIENTS') }}