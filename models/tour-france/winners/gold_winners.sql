select 
    row_number() over(order by ano) id_winner,
    *,
    datediff(year, born, current_date) idade
from 
    {{ ref('silver_winners') }}