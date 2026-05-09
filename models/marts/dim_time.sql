{{ config(materialized='table') }}

with date_range as (
    select 
        -- Cast the resulting timestamp back to a simple date
        range::date as dte_date
    from range(
        '2024-01-01'::timestamp, 
        current_date::timestamp + interval 1 day, 
        interval 1 day
    )
),


final_calendar as (
    select
        cast(strftime(dte_date, '%Y%m%d') as integer) as sk_date,
        dte_date,
        
        -- Basic Components
        extract(week from dte_date) as dte_week,
        extract(month from dte_date) as dte_month,
        extract(year from dte_date) as dte_year,
        extract(quarter from dte_date) as dte_quarter,
        
        -- Descriptions
        strftime(dte_date, '%-d %B, %Y') as dsc_date,
        'Week ' || extract(week from dte_date) || ', ' || extract(year from dte_date) as dsc_week,
        strftime(dte_date, '%B, %Y') as dsc_month,
        'Q' || extract(quarter from dte_date) || ' ' || extract(year from dte_date) as dsc_quarter,
        'Calendar ' || extract(year from dte_date) as dsc_year,
        
        -- Codes
        cast(extract(year from dte_date) as varchar) as cod_year,
        
        -- Weekend Logic: DuckDB dayofweek is 0 (Sunday) to 6 (Saturday)
        case 
            when extract(dayofweek from dte_date) in (0, 6) then true 
            else false 
        end as is_weekend,

        -- Fiscal Year Logic (Assuming Fiscal Year starts in July/Month 7)
        case 
            when extract(month from dte_date) >= 7 
            then extract(year from dte_date) 
            else extract(year from dte_date) - 1 
        end as dte_fiscal_year,

        'FY ' || case 
            when extract(month from dte_date) >= 7 
            then extract(year from dte_date) 
            else extract(year from dte_date) - 1 
        end as dsc_fiscal_year

    from date_range
)

select * from final_calendar