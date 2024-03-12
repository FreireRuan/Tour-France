with

    base as (
        select
            year ano,
            date data,
            stage,
            course,
            split_part(distance, '(', 1) distance_km,
            replace(replace(split_part(distance, ' ', 2), '(', ''), ')', '') distance_mi,
            type,
            split_part(winner, '(', 1) winner
        from
            "tour_france"."public"."tb_stages"
    )

    select * from base