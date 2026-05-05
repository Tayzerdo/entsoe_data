with physical_energy_power_flows as (
    select * from {{ ref('int_physical_energy_power_flows') }}
)

select * from physical_energy_power_flows 