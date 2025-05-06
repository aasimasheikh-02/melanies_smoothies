-- models/prescription_items_transformed.sql

WITH cleaned AS (
  SELECT
    item_id,
    prescription_id,
    drug_id,
    quantity,
    dosage,
    frequency,
    duration_days,

    -- Try to extract numeric part from dosage (e.g., "1 ml" -> 1)
    TRY_CAST(regexp_substr(dosage, '^[0-9]+(\.[0-9]+)?') AS FLOAT) AS dosage_amount,

    -- Normalize frequency to lowercase for easier pattern matching
    lower(frequency) AS frequency_lc
  FROM {{ source('pharma', 'PRESCRIPTION_ITEMS') }}
)

SELECT
  item_id,
  prescription_id,
  drug_id,
  quantity,
  dosage,
  frequency,
  duration_days,
  dosage_amount,

  -- Map frequency text to dose counts per day
  CASE
    WHEN frequency_lc LIKE '%once%' THEN 1
    WHEN frequency_lc LIKE '%twice%' THEN 2
    WHEN frequency_lc LIKE '%three%' THEN 3
    WHEN frequency_lc LIKE '%four%' THEN 4
    ELSE NULL
  END AS daily_dosage_count,

  -- Total expected doses = daily count × duration
  CASE
    WHEN
      CASE
        WHEN frequency_lc LIKE '%once%' THEN 1
        WHEN frequency_lc LIKE '%twice%' THEN 2
        WHEN frequency_lc LIKE '%three%' THEN 3
        WHEN frequency_lc LIKE '%four%' THEN 4
        ELSE NULL
      END IS NOT NULL
    THEN 
      duration_days * 
      CASE
        WHEN frequency_lc LIKE '%once%' THEN 1
        WHEN frequency_lc LIKE '%twice%' THEN 2
        WHEN frequency_lc LIKE '%three%' THEN 3
        WHEN frequency_lc LIKE '%four%' THEN 4
      END
    ELSE NULL
  END AS total_doses_expected,

  -- Total expected volume = daily dosage count × dosage amount × duration
  CASE
    WHEN dosage_amount IS NOT NULL AND
         CASE
           WHEN frequency_lc LIKE '%once%' THEN 1
           WHEN frequency_lc LIKE '%twice%' THEN 2
           WHEN frequency_lc LIKE '%three%' THEN 3
           WHEN frequency_lc LIKE '%four%' THEN 4
           ELSE NULL
         END IS NOT NULL
    THEN dosage_amount *
         CASE
           WHEN frequency_lc LIKE '%once%' THEN 1
           WHEN frequency_lc LIKE '%twice%' THEN 2
           WHEN frequency_lc LIKE '%three%' THEN 3
           WHEN frequency_lc LIKE '%four%' THEN 4
         END *
         duration_days
    ELSE NULL
  END AS total_volume_expected

FROM cleaned