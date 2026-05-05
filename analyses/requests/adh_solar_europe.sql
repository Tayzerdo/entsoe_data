with monthly_domestic_values as (
    select *
    from {{ ref('fct_monthly_domestic_values') }}
),
measure_items as (
    select *
    from {{ ref('dim_measure_items') }}
    where category = 'Solar'
),
country_codes as (
    select *
    from {{ ref('dim_country_codes') }}
    where region = 'Europe'
),
solar_data as (
    select 
        mdv.country_alpha2_code,
        cc.country_name,
        mdv.report_date,
        mdv.amount
        
    from monthly_domestic_values as mdv
    inner join measure_items as mi on mdv.category_id = mi.category_id
    inner join country_codes as cc on mdv.country_alpha2_code = cc.country_alpha2_code
)

select *
from solar_data