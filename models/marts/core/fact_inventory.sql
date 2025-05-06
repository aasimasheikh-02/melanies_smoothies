SELECT
  inventory_id,
  i.pharmacy_id,
  ph.name AS pharmacy_name,
  i.drug_id,
  d.name AS drug_name,
  quantity,
  batch_number,
  manufacture_date,
  expiry_date,
  last_restocked,
  dd.date_id AS restock_date_id
FROM {{ ref('stg_inventory') }} i
LEFT JOIN {{ ref('dim_pharmacy') }} ph ON i.pharmacy_id = ph.pharmacy_id
LEFT JOIN {{ ref('dim_drugs') }} d ON i.drug_id = d.drug_id
LEFT JOIN {{ ref('dim_date') }} dd ON CAST(i.last_restocked AS DATE) = dd.date
