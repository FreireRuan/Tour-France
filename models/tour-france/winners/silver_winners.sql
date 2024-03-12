with 
    base as (
        SELECT
            year ano,
            country,
            rider,
            team,
            nullif(time, '') duracao,
            margin,
            stages_won,
            stages_led,
            avg_speed,
            height,
            weight,
            born,
            died
        FROM
            {{ ref('tb_winners') }}
    ),

    base_trat as (
        select
            cast(ano as integer) ano, 
            country,
            rider,
            team,
            duracao,
            cast(nullif(split_part(duracao, 'h', 1), '') as integer) horas_duracao,
            cast(nullif(split_part(replace(duracao, 'm', ' '), ' ', 2), '') as integer) minutos_duracao,
            cast(nullif(split_part(replace(duracao, 's', ' '), ' ', 3), '') as integer) segundos_duracao,
            nullif(margin, '') margin,
            cast(
                case
                    when position('h' in margin) = 2 then split_part(margin, 'h', 1)
                    else null
                end as integer) horas_margin,
            cast(
                case
                    when position('m' in margin) = 5 then split_part(replace(margin, 'm', ' '), ' ', 2)
                    when position('m' in margin) = 6 then split_part(replace(margin, 'm', ' '), ' ', 2) 
                    when position('m' in margin) = 2 then split_part(replace(margin, 'm', ' '), ' ', 1)
                    when position('m' in margin) = 3 then split_part(replace(margin, 'm', ' '), ' ', 1)
                    else null
                end as integer) minutos_margin,
            cast(
                replace(
                    case
                        when position('s' in margin) = 9 then split_part(replace(margin, 's', ' '), ' ', 3)
                        when position('s' in margin) = 10 then split_part(replace(margin, 's', ' '), ' ', 3)
                        when position('s' in margin) = 7 then split_part(replace(margin, 's', ' '), ' ', 2)
                        when position('s' in margin) = 6 then split_part(replace(margin, 's', ' '), ' ', 2)
                        when position('s' in margin) = 2 then replace(margin, 's', '')
                        when position('s' in margin) = 3 then replace(margin, 's', '')
                        else null
                    end, 'm', '') 
                as integer) as segundos_margin,
            cast(stages_won as integer) stages_won, 
            cast(stages_led as integer) stages_led,
            cast(nullif(split_part(avg_speed, 'km/h', 1), '') as float) avg_speed_km_h,
            cast(nullif(split_part(height, 'm', 1), '') as float) height_m,
            cast(nullif(split_part(weight, 'kg', 1), '') as float) weight_kg,
            to_date(born, 'YYYY-MM-DD') born,
            to_date(died, 'YYYY-MM-DD') died
        from
            base
    )

    select
       *
    from
        base_trat
    