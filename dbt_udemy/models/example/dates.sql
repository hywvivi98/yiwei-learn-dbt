{{ config(materialized='incremental', unique_key = 'd_date') }}

select * from 
"SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."DATE_DIM"
where d_date <= current_date

{% if is_incremental() %} -- to test 1) if this is an incremental model; 2) if this is the first time to run
    and d_date > (select max(d_date) from {{ this }}) -- this refer to the target table (i.e. dates table)
{% endif %}