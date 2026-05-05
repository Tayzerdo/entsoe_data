with inventory_of_transmission as (
    select * from {{ ref('int_inventory_of_transmission') }}
)

select * from inventory_of_transmission 