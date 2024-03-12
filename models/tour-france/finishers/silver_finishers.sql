with
    base as (
        select
            year as ano,
            rank as classificacao,
            rider,
            time as duracao,
            -- replace(time, '+ ', '') as duracao,
            team
        FROM 
            {{ ref('tb_finishers') }}
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
    ano,
    classificacao,
    rider,
    duracao,
    split_part(duracao, 'h', 1) as horas,
    replace(split_part(duracao, ' ', 2), '''', '') as minutos,
    replace(split_part(duracao, ' ', 3), '"', '') as segundos,
    team
from
    base_trat