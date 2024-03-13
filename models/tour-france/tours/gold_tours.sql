select
    row_number() over() as id_tour,
    t.*
from 
    {{ ref('silver_tours') }} t