select
    *
from
    {{source('sources','globepay_acceptance_report')}}
where
--the transaction is considered faulty as its amount is below zero 
    ref not in ('evt_1EhCNv4mRDFQzT2r2O5Cy5G')