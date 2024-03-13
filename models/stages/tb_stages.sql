{{
    config(
        materialized='table'
    )
}}

SELECT
    *
FROM
    {{source('sources','tb_stages')}}