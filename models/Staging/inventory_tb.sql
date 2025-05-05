
SELECT
  inventory_id,
  pharmacy_id,
  drug_id,
  quantity, 
  batch_number,
  TRY_TO_DATE(TO_VARCHAR(manufacture_date), 'DD-MM-YYYY') AS manufacture_date,
  TRY_TO_DATE(TO_VARCHAR(expiry_date), 'DD-MM-YYYY') AS expiry_date,
  TRY_TO_DATE(TO_VARCHAR(last_restocked), 'DD-MM-YYYY') AS last_restocked,

 -- Standardizing date format
  
  DATEDIFF(day, expiry_date, manufacture_date) AS shelf_life_days,  -- Calculating shelf life in days
  DATEDIFF(day, current_date, last_restocked) AS days_since_restock,  -- Days since last restock
  
  CASE
    WHEN expiry_date < current_date THEN 'Expired'
    ELSE 'Active'
  END AS inventory_status,  -- Flagging expired inventory

  CASE 
    WHEN quantity <= 0 THEN 'Out of Stock'
    WHEN quantity <= 5 THEN 'Low Stock'
    ELSE 'In Stock'
  END AS stock_status  -- Categorizing stock level

FROM {{ source('pharma', 'INVENTORY') }}
