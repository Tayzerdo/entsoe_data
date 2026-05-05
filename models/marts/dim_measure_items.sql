with stg_data as (
    select * from {{ ref('int_measure_items') }}
)

select * 
from stg_data