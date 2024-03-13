{{
    config(
        materialized='table'
    )
}}

with
    base as (
        select
            year as ano,
            rank as classificacao,
            rider,
            time as duracao,
            team
        FROM 
            {{ ref('tb_finishers') }}
    ),

    base_trat as (
        select
            ano,
            classificacao,
            split_part(rider, '(', 1) as rider,
            replace(replace(replace(duracao, '+ ', ''), '+', ''),'′', '''') duracao,
            team
        from    
            base
    )

select
    cast(ano as integer) ano,
    cast(replace(replace(classificacao, 'DSQ', 0), '', 0) as integer) classificacao,
    rider,
    nullif(duracao, '') duracao,
    cast(case
        when position('h' in duracao) = 2 then split_part(duracao, 'h', 1)
        when position('h' in duracao) = 3 then split_part(duracao, 'h', 1)
        when position('h' in duracao) = 4 then split_part(duracao, 'h', 1)
    end as integer) horas,
    cast(
        case
            when nullif(duracao, '') is null then null
            when position('h' in duracao) = 2 then split_part(replace(duracao, '''', ' '), ' ', 2)
            when position('h' in duracao) = 3 then split_part(replace(duracao, '''', ' '), ' ', 2)
            when position('h' in duracao) = 4 then split_part(replace(duracao, '''', ' '), ' ', 2)
            when position('''' in duracao) = 2 then split_part(duracao, '''', 1)
            when position('''' in duracao) = 3 then split_part(duracao, '''', 1)
            when position('''' in duracao) = 4 then split_part(duracao, '''', 1)
        end
    as integer) minutos,
    case
        when replace(split_part(duracao, ' ', 3), '"', '') != '' then replace(replace(split_part(duracao, ' ', 3), '"', ''), '''', '')
        when position('h' in duracao) = 2 then split_part(replace(replace(duracao, '"', ' '), '''', ' '), ' ', 3)
        when position('h' in duracao) = 3 then split_part(replace(replace(duracao, '"', ' '), '''', ' '), ' ', 3)
        when position('''' in duracao) = 4 then split_part(replace(replace(duracao, '''', ''), '"', ' '), ' ', 2)
        when position('"' in duracao) = 2 then split_part(duracao, '"', 1)
        when position('"' in duracao) = 3 then split_part(duracao, '"', 1)
        when position('''' in duracao) = 2 then split_part(replace(duracao, '"', ' '), ' ', 2)
        when position('''' in duracao) = 3 then split_part(replace(duracao, '"', ' '), ' ', 2)
    end segundos,
    nullif(team, '') team
from
    base_trat