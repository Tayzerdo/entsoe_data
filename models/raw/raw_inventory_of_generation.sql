with raw_data as (
    select * from {{ source('external_data', 'inventory_of_generation')}}
)

select * 
from raw_data