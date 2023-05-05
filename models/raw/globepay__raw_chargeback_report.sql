select
    *
from
    {{source('sources','globepay_chargeback_report')}}
where
--the transaction is considered faulty as its amount is below zero 
    external_ref not in ('SPm_aqm_Rrer_6jxpLvO2')