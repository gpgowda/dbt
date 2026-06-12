select

    row_number() over(
        order by fear_greed_classification
    ) as sentiment_key,

    fear_greed_classification,

    market_sentiment,

    risk_level

from (

    select

    row_number() over(
        order by sentiment_date
    ) as sentiment_key,

    sentiment_date,

    fear_greed_value,

    fear_greed_classification,

    market_sentiment,

    risk_level

from {{ ref('stg_fear_greed') }}
)