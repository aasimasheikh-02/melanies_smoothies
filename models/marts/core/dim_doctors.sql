SELECT
  doctor_id,
  first_name,
  last_name,
  specialization,
  hospital,
  PHONE_DIGITS as phone_number,
  email,
  license_number,
  LICENSE_STATE
FROM {{ ref('doctors_tb') }}
