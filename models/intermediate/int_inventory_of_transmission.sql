with inventory_of_transmission as (
    select * EXCLUDE (measure_itemid, measure_item, category)
    from {{ ref('stg_inventory_of_transmission') }}
)

select *  
from inventory_of_transmission