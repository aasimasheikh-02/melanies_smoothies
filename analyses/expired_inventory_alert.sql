SELECT 
  pharmacy_id,
  drug_id,
  expiry_date,
  quantity
FROM {{ ref('fact_inventory') }}
WHERE expiry_date < CURRENT_DATE
ORDER BY expiry_date
