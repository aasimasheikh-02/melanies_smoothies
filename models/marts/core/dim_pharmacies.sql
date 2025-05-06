SELECT
  pharmacy_id,
  PHARMACY_NAME,
  address,
  city,
  state,
  zip_code,
  PHONE_DIGITS as phone,
  email,
  license_number
FROM {{ ref('pharmacies_tb') }}
