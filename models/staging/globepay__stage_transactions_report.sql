select
    acceptance_report.ref as transaction_id,
    date(acceptance_report.date_time) as transaction_date,
    acceptance_report.state = 'ACCEPTED' as is_accepted,
    acceptance_report.country,
    chargeback_report.external_ref is NULL as has_chargeback_information,
    case 
        when chargeback_report.chargeback = True 
            then true
        when chargeback_report.chargeback = False
            then false
        else
            null
    end as is_chargebacked,
    round(acceptance_report.amount/get_path(rates, currency),2) as amount_in_us_dollars
from
    {{ref('globepay__source_acceptance_report')}} acceptance_report
left join
    {{ref('globepay__source_chargeback_report')}} chargeback_report 
on
    acceptance_report.external_ref = chargeback_report.external_ref