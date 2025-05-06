SELECT *
FROM {{ ref('dim_doctors') }}
WHERE email IS NULL
