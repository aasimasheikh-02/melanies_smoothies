SELECT
  d.drug_id,
  d.BRAND_NAME,
  d.generic_name,
  d.DOSAGE_FORM,
  d.DRUG_CATEGORY,
  d.manufacturer_id,
  m.manufacturer_name,
  d.PRICE_USD as price,
  d.storage_conditions,
  d.expiry_months
FROM {{ ref('drugs_tb') }} d
LEFT JOIN {{ ref('dim_manufacturer') }} m
  ON d.manufacturer_id = m.manufacturer_id
