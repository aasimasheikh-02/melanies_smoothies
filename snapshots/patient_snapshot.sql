{% snapshot patient_snapshot %}
    {{ config(
        unique_key='patient_id',
        strategy='check',
        check_cols=['address', 'phone', 'email', 'emergency_contact', 'emergency_phone']
    ) }}

    SELECT * 
    FROM {{ ref('dim_patients') }}

{% endsnapshot %}
