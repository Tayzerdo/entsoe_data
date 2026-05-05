with raw_data as (
    select 
        name as country_name,
        "alpha-2" as country_alpha2_code,    -- Clear that it's ISO and 2 chars
        "alpha-3" as country_alpha3_code,    -- Clear that it's ISO and 3 chars
        region,
        "sub-region" as sub_region_name  -- Adding '_name' clarifies it's a label
    from {{ ref('raw_country_codes') }}
)

select {{ dbt_utils.generate_surrogate_key(['country_alpha2_code']) }} as country_key,
    *
from raw_data