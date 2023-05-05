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
where
--the transaction is considered faulty as its amount is below zero 
    ref not in ('evt_1EhCNv4mRDFQzT2r2O5Cy5G')