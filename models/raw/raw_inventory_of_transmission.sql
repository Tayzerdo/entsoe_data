with raw_data as (
    select * from {{ source('external_data', 'inventory_of_transmission')}}
)

select * 
from raw_data