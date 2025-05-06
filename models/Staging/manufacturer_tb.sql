-- models/manufacturer_transformed.sql

SELECT
  manufacturer_id,
  initcap(name) AS manufacturer_name,  -- Capitalize each word in the manufacturer name
  address,
  lower(country) AS country,  -- Normalize country name to lowercase
  initcap(contact_person) AS contact_person,  -- Standardize contact person name
  lower(email) AS email,  -- Normalize email to lowercase
  regexp_replace(phone, '[^0-9]', '') AS phone_digits,  -- Remove non-numeric characters from phone number
  established_year,
  
  -- Calculate the number of years the manufacturer has been established
  EXTRACT(YEAR FROM current_date) - established_year AS years_in_business,
  
  -- Categorize based on how long the manufacturer has been in business
  CASE 
    WHEN EXTRACT(YEAR FROM current_date) - established_year >= 30 THEN 'Long Established'
    ELSE 'Newer'
  END AS manufacturer_age_category

FROM {{ source('pharma', 'MANUFACTURERS') }}