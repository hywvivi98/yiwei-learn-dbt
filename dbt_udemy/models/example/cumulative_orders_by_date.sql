{{ config(materialized='view') }}

SELECT DISTINCT 
    o_orderdate,
    sum(o_totalprice) over (order by o_orderdate) as cumulative_sales 

FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS" 

ORDER BY o_orderdate