select

    cast(fear_greed_value as int64)
        as fear_greed_value,

    fear_greed_classification,

    cast(sentiment_level as int64)
        as sentiment_level,

    case
        when fear_greed_value <= 25 then 'BEARISH'
        when fear_greed_value <= 50 then 'NEUTRAL'
        else 'BULLISH'
    end as market_sentiment,

    case
        when fear_greed_value <= 25 then 'HIGH RISK'
        when fear_greed_value <= 50 then 'MEDIUM RISK'
        else 'LOW RISK'
    end as risk_level,

    cast(sentiment_date as date)
        as sentiment_date,

    cast(snapshot_date as date)
        as snapshot_date,

    cast(extraction_time as timestamp)
        as extraction_time

from {{ source('crypto_analytics','raw_fear_greed') }}

where fear_greed_value between 0 and 100