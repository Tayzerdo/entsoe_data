with stg_data as (
    select *  from {{ ref('int_country_codes') }}
)

select * 
from stg_data