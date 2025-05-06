
SELECT
  drug_id,
  initcap(name) AS brand_name,  -- Capitalize each word
  initcap(generic_name) AS generic_name,  -- Standard casing
  lower(type) AS dosage_form,  -- Normalize for analysis
  lower(category) AS drug_category,
  manufacturer_id,
  round(cast(price AS numeric), 2) AS price_usd,  -- Round price to 2 decimals
  lower(storage_conditions) AS storage_conditions,

  expiry_months,
  CASE 
    WHEN expiry_months < 12 THEN 'Short-Term'
    WHEN expiry_months BETWEEN 12 AND 36 THEN 'Medium-Term'
    ELSE 'Long-Term'
  END AS expiry_classification,  -- Classify drugs based on shelf life

  DATEADD(month, expiry_months, CURRENT_DATE) AS estimated_expiry_date,
  price * expiry_months AS value_lifetime  -- Value over the product life

FROM {{ source('pharma', 'DRUGS') }}