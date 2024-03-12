select
    row_number() over() id_stages,
    s.*,
    t.id_tour as tour_id
from
    {{ ref('silver_stages') }} s
    left join
        {{ ref('gold_tours') }} t
        on
        s.ano = t.ano