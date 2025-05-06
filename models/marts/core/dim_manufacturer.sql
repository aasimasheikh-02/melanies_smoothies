SELECT
  manufacturer_id,
  MANUFACTURER_NAME,
  address,
  country,
  contact_person,
  email,
  PHONE_DIGITS as phone,
  established_year,
  YEARS_IN_BUSINESS,
  MANUFACTURER_AGE_CATEGORY
FROM {{ ref('manufacturer_tb') }}
