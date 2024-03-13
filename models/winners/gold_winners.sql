{{
    config(
        materialized='table'
    )
}}

select 
    row_number() over(order by w.ano) id_winner,
    w.*,
    datediff(year, w.born, current_date) idade,
    t.id_tour as tour_id
from 
    {{ ref('silver_winners') }} w
    left join 
        {{ ref('gold_tours') }} t
    on
    w.ano = t.ano
