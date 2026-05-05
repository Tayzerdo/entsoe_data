with net_generation_capacity as (
    select * EXCLUDE (measure_itemid, measure_item, category)
    from {{ ref('stg_net_generation_capacity') }}
)

select *  
from net_generation_capacity