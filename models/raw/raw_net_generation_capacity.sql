with raw_data as (
    select * from {{ source('external_data', 'net_generation_capacity')}}
)

select * 
from raw_data