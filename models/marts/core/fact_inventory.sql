SELECT
  inventory_id,
  i.pharmacy_id,
  ph.pharmacy_name,
  i.drug_id,
  d.BRAND_NAME AS drug_name,
  quantity,
  batch_number,
  manufacture_date,
  expiry_date,
  last_restocked,
  dd.date_id AS restock_date_id
FROM {{ ref('inventory_tb') }} i
LEFT JOIN {{ ref('dim_pharmacies') }} ph ON i.pharmacy_id = ph.pharmacy_id
LEFT JOIN {{ ref('dim_drugs') }} d ON i.drug_id = d.drug_id
LEFT JOIN {{ ref('dim_date') }} dd ON CAST(i.last_restocked AS DATE) = dd.date
