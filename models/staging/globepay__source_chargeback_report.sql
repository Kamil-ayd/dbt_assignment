select
    external_ref as tr_chargeback_status_id,
    status,
    source,
    chargeback as has_chargeback
from
    {{ref('globepay__raw_chargeback_report')}}