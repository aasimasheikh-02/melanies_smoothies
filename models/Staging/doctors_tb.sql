SELECT
  doctor_id,
  split_part(name, ' ', 1) AS first_name,
  split_part(name, ' ', 2) AS last_name,
  specialization,
  hospital,
  regexp_replace(phone, '[^0-9]', '') AS phone_digits,
  lower(email) AS email,
  license_number,
  regexp_substr(license_number, '[A-Z]{2}') AS license_state
FROM {{ source('pharma', 'DOCTORS') }}