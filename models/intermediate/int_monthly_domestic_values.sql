with monthly_domestic_values as (
    select * EXCLUDE (measure_itemid, measure_item, category)
    from {{ ref('stg_monthly_domestic_values') }}
)

select *  
from monthly_domestic_values