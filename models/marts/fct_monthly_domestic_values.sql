with monthly_domestic_values as (
    select * from {{ ref('int_monthly_domestic_values') }}
)

select * from monthly_domestic_values 