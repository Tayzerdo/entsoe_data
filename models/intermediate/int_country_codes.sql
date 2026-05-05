with country_codes as (
    select * from {{ ref('stg_country_codes') }}
)

select *
from country_codes