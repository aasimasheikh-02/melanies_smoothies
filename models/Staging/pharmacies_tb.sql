-- models/pharmacy_transformed.sql

SELECT
  pharmacy_id,
  initcap(name) AS pharmacy_name,
  address,
  initcap(city) AS city,
  initcap(state) AS state,
  LPAD(zip_code::TEXT, 5, '0') AS zip_code,
  regexp_replace(phone, '[^0-9]', '') AS phone_digits,
  lower(email) AS email,
  license_number,

  -- Extract license prefix/suffix
  split_part(license_number, '-', 1) AS license_prefix,
  split_part(license_number, '-', 3) AS license_suffix,

  -- Derived fields
  city || ', ' || state || ' ' || zip_code AS full_location,

  -- Business region (simplified mapping)
  CASE 
    WHEN lower(state) IN ('new york', 'massachusetts', 'virginia', 'florida') THEN 'East'
    WHEN lower(state) IN ('illinois', 'texas', 'ohio', 'iowa') THEN 'Central'
    WHEN lower(state) IN ('california', 'washington', 'arizona', 'nevada') THEN 'West'
    ELSE 'Unknown'
  END AS business_region,

  -- Email domain
  split_part(lower(email), '@', 2) AS email_domain,

  -- Flag missing/invalid phone
  CASE 
    WHEN phone IS NULL OR phone = '' THEN 'Missing Phone'
    WHEN LENGTH(regexp_replace(phone, '[^0-9]', '')) < 10 THEN 'Invalid Phone'
    ELSE 'Valid Phone'
  END AS phone_status,


  -- Flag missing/invalid email
  CASE 
    WHEN email IS NULL OR email = '' THEN 'Missing Email'
    WHEN NOT email LIKE '%@%.%' THEN 'Invalid Email'
    ELSE 'Valid Email'
  END AS email_status,

  -- Flag license presence
  CASE 
    WHEN license_number IS NULL OR license_number = '' THEN 'Missing License'
    ELSE 'Has License'
  END AS license_status,

  -- Name length validation
  LENGTH(name) AS name_length,
  CASE 
    WHEN LENGTH(name) > 50 THEN 'Too Long'
    WHEN LENGTH(name) < 5 THEN 'Too Short'
    ELSE 'OK'
  END AS name_length_status

FROM {{ source('pharma', 'PHARMACIES') }}