with

    base as (
        select
            cast(year as integer) ano,
            to_date(date, 'YYYY-MM-DD') data,
            stage,
            course,
            split_part(split_part(distance, '(', 1), 'km', 1) distance_km,
            split_part(replace(replace(split_part(distance, ' ', 2), '(', ''), ')', ''), 'mi', 1) distance_mi,
            type,
            split_part(winner, '(', 1) winner
        from
            {{ ref('tb_stages') }}
    )

    select 
        * 
    from 
        base