-- analyses/audit/aud_missing_country_references.sql
select 
    fct.country_alpha2_code,
    count(*) as record_count,
    min(fct.report_date) as first_seen,
    max(fct.report_date) as last_seen
from {{ ref('fct_monthly_domestic_values') }} as fct
left join {{ ref('dim_country_codes') }} as dim
    on fct.country_alpha2_code = dim.country_alpha2_code
where dim.country_alpha2_code is null
group by 1
order by record_count desc