with avg_state_score as (
select *
from {{ ref('prep_reviews_geo') }}
)
select GEOLOCATION_STATE as state,
    avg(REVIEW_SCORE) as avg_review_score
from avg_state_score
group by GEOLOCATION_STATE
order by avg_review_score desc