SELECT
  "date_id_pk" AS date_id,
  CAST("date" AS DATE) AS date,
  "year",
  "month",
  "quarter",
  "day",
  "day_of_week",
  "day_name",
  "day_of_month",
  "weekday"
FROM {{ ref('date_dimension') }}
