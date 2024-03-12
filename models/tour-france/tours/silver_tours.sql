with
    base as (
        select
            year AS ano,
            dates,
            case
                when position('–' in dates) = 2 then split_part(dates, '–', 1)
                when position('–' in dates) = 3 then split_part(dates, '–', 1)
                when position(' ' in dates) = 2 then split_part(dates, ' ', 1)
                when position(' ' in dates) = 3 then split_part(dates, ' ', 1)
                else dates 
            end dia_inicio,
            case
                when position('–' in dates) = 2 then split_part(replace(dates, '–', ' '), ' ', 2)
                when position('–' in dates) = 3 then split_part(replace(dates, '–', ' '), ' ', 2)
                when position(' ' in dates) = 2 then split_part(dates, ' ', 4)
                when position(' ' in dates) = 3 then split_part(dates, ' ', 4)
                else dates
            end dia_fim,
            case
                when position('–' in dates) = 2 then split_part(dates, ' ', 2)
                when position('–' in dates) = 3 then split_part(dates, ' ', 2)
                when position(' ' in dates) = 2 then split_part(dates, ' ', 2)
                when position(' ' in dates) = 3 then split_part(dates, ' ', 2)
                else dates
            end mes_inicio,
            case
                when position('–' in dates) = 2 then split_part(dates, ' ', 2)
                when position('–' in dates) = 3 then split_part(dates, ' ', 2)
                when position(' ' in dates) = 2 then split_part(dates, ' ', 5)
                when position(' ' in dates) = 3 then split_part(dates, ' ', 5)
                else dates
            end mes_fim,
            case
                when position('–' in dates) = 2 then split_part(dates, ' ', 3)
                when position('–' in dates) = 3 then split_part(dates, ' ', 3)
                when position(' ' in dates) = 2 then split_part(dates, ' ', 6)
                when position(' ' in dates) = 3 then split_part(dates, ' ', 6)
                else dates
            end ano_inicio_fim,
            stages,
            split_part(distance, '(', 1) AS distance_km,
            replace(replace(split_part(distance, ' ', 2), '(', ''), ')', '') AS distance_mi,
            starters,
            finishers
        FROM
            "tour_france"."public"."tb_tours"
    )

select
    cast(ano as integer) ano,
    dates,
    to_date(dia_inicio || ' ' || mes_inicio || ' ' || ano_inicio_fim, 'DD Month YYYY') data_inicio,
    to_date(dia_fim || ' ' || mes_fim || ' ' || ano_inicio_fim, 'DD Month YYYY') data_fim,
    stages,
    cast(starters as integer) starters,
    cast(finishers as integer) finishers
from
    base