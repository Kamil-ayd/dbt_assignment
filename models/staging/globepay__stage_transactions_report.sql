with acceptance_report as (
    select
        transaction_id,
        date,
        state,
        country,
        amount,
        rates,
        currency,
        tr_chargeback_status_id
    from
        {{ref('globepay__source_acceptance_report')}}
),

chargeback_report as (
    select
        tr_chargeback_status_id,
        has_chargeback
    from
        {{ref('globepay__source_chargeback_report')}}
)

select
    acceptance_report.transaction_id,
    date as transaction_date,
    acceptance_report.state = 'ACCEPTED' as is_accepted,
    acceptance_report.country,
    chargeback_report.tr_chargeback_status_id is not NULL as has_chargeback_information,
    case 
        when chargeback_report.has_chargeback = True 
            then true
        when chargeback_report.has_chargeback = False
            then false
        else
            null
    end as is_chargebacked,
    round(acceptance_report.amount/get_path(rates, currency),2) as amount_in_us_dollars
from
    acceptance_report
left join
    chargeback_report 
on
    acceptance_report.tr_chargeback_status_id = chargeback_report.tr_chargeback_status_id