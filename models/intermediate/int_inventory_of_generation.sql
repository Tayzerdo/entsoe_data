with inventory_of_generation as (
    select * EXCLUDE (measure_itemid, measure_item, category)
    from {{ ref('stg_inventory_of_generation') }}
)

select *  
from inventory_of_generation