select
    row_number() over() as id_tour,
    t.*,
    s.id_winner winner_id
from 
    {{ ref('silver_tours') }} t
    left join
        {{ ref('gold_winners') }} s 
        on 
        t.ano = s.ano