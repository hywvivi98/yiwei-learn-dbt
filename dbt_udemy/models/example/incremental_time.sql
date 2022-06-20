{{ config(materialized='incremental', unique_key = 't_time') }}

select * from 
"SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."TIME_DIM"
where to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND))  <= current_time

{% if is_incremental() %} -- to test 1) if this is an incremental model; 2) if this is the first time to run
    and t_time > (select max(t_time) from {{ this }}) -- this refer to the target table (i.e. dates table)
{% endif %}