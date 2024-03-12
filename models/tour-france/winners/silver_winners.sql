with 
    base as (
        SELECT
            year ano,
            country,
            rider,
            team,
            time duracao,
            margin,
            stages_won,
            stages_led,
            avg_speed,
            height,
            weight,
            born,
            died
        FROM
            "tour_france"."public"."tb_winners"
    ),

    base_trat as (
        select
            ano, 
            country,
            rider,
            team,
            duracao,
            cast(split_part(duracao, 'h', 1) as int) horas,
            cast(split_part(replace(duracao, 'm', ' '), ' ', 2) as int) minutos,
            cast(split_part(replace(duracao, 's', ' '), ' ', 3) as int) segundos,
            margin,
            cast(split_part(margin, 'h', 1) as int) horas_margin,
            cast(split_part(replace(margin, 'm', ' '), ' ', 2) as int) minutos_margin,
            cast(split_part(replace(margin, 's', ' '), ' ', 3) as int) segundos_margin,
            stages_won, 
            stages_led,
            cast(split_part(avg_speed, 'km/h', 1) as float) avg_speed_km_h,
            cast(split_part(height, 'm', 1) as float) height_m,
            cast(split_part(weight, 'kg', 1) as float) weight_kg,
            to_date(born, 'YYYY-MM-DD') born,
            to_date(died, 'YYYY-MM-DD') died
        from
            base
    )

    select
        *
    from
        base_trat
    