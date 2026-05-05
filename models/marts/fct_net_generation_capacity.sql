with net_generation_capacity as (
    select * from {{ ref('int_net_generation_capacity') }}
)

select * from net_generation_capacity 