with
    base as (
        select
            year as ano,
            rank as classificacao,
            rider,
            time as duracao,
            team
        FROM 
            "tour_france"."public"."tb_finishers"
    ),

    base_trat as (
        select
            ano,
            classificacao,
            split_part(rider, '(', 1) as rider,
            replace(duracao, '+ ', '') duracao,
            team
        from    
            base
    )

select
    cast(ano as integer) ano,
    cast(classificacao as integer) classificacao,
    rider,
    nullif(duracao, ''),
    cast(nullif(split_part(duracao, 'h', 1), '') as integer) as horas,
    cast(nullif(replace(split_part(duracao, ' ', 2), '''', ''), '') as integer) as minutos,
    cast(nullif(replace(split_part(duracao, ' ', 3), '"', ''), '') as integer) as segundos,
    nullif(team, '') team
from
    base_trat