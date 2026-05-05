with physical_energy_power_flows as (
    select * EXCLUDE (measure_itemid, measure_item, category)
    from {{ ref('stg_physical_energy_power_flows') }}
)

select *  
from physical_energy_power_flows