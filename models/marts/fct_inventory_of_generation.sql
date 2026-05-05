with inventory_of_generation as (
    select * from {{ ref('int_inventory_of_generation') }}
)

select * from inventory_of_generation 