select
    external_ref as tr_chargeback_status_id,
    status,
    source,
    ref as transaction_id,
    date(date_time) as date,
    state,
    cvv_provided,
    amount,
    country,
    currency,
    rates
from
    {{ref('globepay__raw_acceptance_report')}}
