with raw_data as (
    select 
        measureitem as measure_item,
        upper(list_aggregate(
            list_filter(
                list_transform(
                    string_split(measureitem, ' '), 
                    x -> substr(x, 1, 1)
                ),
                y -> regexp_matches(y, '[a-zA-Z]')
            ), 
            'string_agg', ''
        )) as measure_itemid,
        measureitemid as category_id,
        category,
        country as country_alpha2_code,
        make_date(cast(year as INT), 1, 1) as report_date,
        creationdate as raw_creation_date, -- Keep the original for debugging
        COALESCE(
    -- 1. Try ISO Format: Only if it contains dashes
            CASE 
                WHEN creationdate LIKE '%-%' THEN TRY_CAST(creationdate AS TIMESTAMP) 
            END,
            
            -- 2. Try European Format: Only if it contains slashes
            CASE 
                WHEN creationdate LIKE '%/%' THEN STRPTIME(creationdate, '%d/%m/%Y %H:%M') 
            END,

            -- 3. Handle Excel Serial: Only if it's numeric (doesn't contain - or /)
            CASE 
                WHEN creationdate NOT LIKE '%/%' AND creationdate NOT LIKE '%-%' 
                THEN '1899-12-30'::DATE + (TRY_CAST(creationdate AS DOUBLE) * INTERVAL 1 DAY)
            END
        )::DATE AS creation_date,
        cast(ifnull(lengthofcircuits,'0') as FLOAT) as circuit_lenght,
        cast(ifnull(lengthofroutes,'0') as FLOAT) as routed_lenght,
        COALESCE(TRY_CAST(numberofunits AS INT), 0) unit_number,
        COALESCE(TRY_CAST(providedvalue AS INT), 0) as amount
    from {{ ref('raw_inventory_of_transmission') }}
)

select * 
from raw_data