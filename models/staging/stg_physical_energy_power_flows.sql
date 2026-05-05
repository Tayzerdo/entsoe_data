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
        'PEPF' as category_id,
        'PEPF' as category,
        coalesce(fromareacode,fromcountrymapcode) as from_country_alpha2_code,
        coalesce(toareacode,tocountrymapcode) as to_country_alpha2_code,
        direction,
        flag,
        make_date(cast(year as INT), cast(month as INT), 1) as report_date,
        cast(createddatetime as date) as creation_date,
        cast(ifnull(value,'0') as FLOAT) as value,
        cast(ifnull(providedvalue,'0') as FLOAT) as amount,
        cast(ifnull(avg_value,'0') as FLOAT) as avg_value,

    from {{ ref('raw_physical_energy_power_flows') }}
)

select * 
from raw_data