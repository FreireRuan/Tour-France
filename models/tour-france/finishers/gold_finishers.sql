select
    row_number() over() id_finishers,
    f.*,
    t.id_tour as tour_id
from
    {{ ref('silver_finishers') }} f
    left join
        {{ ref('gold_tours') }} t
        on
        f.ano = t.ano