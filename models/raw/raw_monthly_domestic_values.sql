with raw_data as (
    select * from {{ source('external_data', 'monthly_domestic_values')}}
)

select * 
from raw_data