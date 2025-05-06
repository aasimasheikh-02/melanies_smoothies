SELECT
  patient_id,
  patient_name,
  date_of_birth,
  gender,
  blood_type,
  address,
  PHONE_DIGITS as phone_number,
  email,
  emergency_contact,
  EMERGENCY_PHONE_DIGITS as emergency_phone,
  age,
  PATIENT_STATUS
FROM {{ ref('patients_tb') }}
