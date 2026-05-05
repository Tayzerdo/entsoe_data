with source_gen as (
    select distinct
        measure_itemid,
        measure_item,
        category_id,
        category
    from {{ ref('stg_inventory_of_generation') }}
),

source_trans as (
    select distinct
        measure_itemid,
        measure_item,
        category_id,
        category
    from {{ ref('stg_inventory_of_transmission') }}
),

source_domestic as (
    select distinct
        measure_itemid,
        measure_item,
        category_id,
        category
    from {{ ref('stg_monthly_domestic_values') }}
),

source_capacity as (
    select distinct
        measure_itemid,
        measure_item,
        category_id,
        category
    from {{ ref('stg_net_generation_capacity') }}
),

source_physical as (
    select distinct
        measure_itemid,
        measure_item,
        category_id,
        category
    from {{ ref('stg_physical_energy_power_flows') }}
),

unioned as (
    select * from source_gen
    union
    select * from source_trans
    union
    select * from source_domestic
    union
    select * from source_capacity
    union
    select * from source_physical
)

select
    -- Generating a unique surrogate key is best practice for dimensions
    {{ dbt_utils.generate_surrogate_key(['measure_itemid', 'category_id']) }} as measure_key,
    *
from unioned
where measure_itemid is not null