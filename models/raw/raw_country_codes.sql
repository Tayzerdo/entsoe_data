with raw_data as (
    select * from {{ source('external_data', 'country_codes')}}
)

select * 
from raw_data