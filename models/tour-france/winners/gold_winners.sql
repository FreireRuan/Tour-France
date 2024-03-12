select 
    row_number() over(order by ano) id_winner,
    *,
    datediff(year, born, current_date) idade
from 
    "tour_france"."dbt_fbusiness"."silver_winners"