with raw_data as (
    select * from {{ source('external_data', 'physical_energy_power_flows')}}
)

select * 
from raw_data