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
        cast(creationdate as date) as creation_date,
        cast(ifnull(numberofunits,'0') as INT) as unit_number,
        cast(ifnull(providedvalue,'0') as FLOAT) as amount
    from {{ ref('raw_inventory_of_generation') }}
)

select * 
from raw_data