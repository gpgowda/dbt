with latest_sentiment as (

    select *

    from {{ ref('stg_fear_greed') }}

    qualify row_number()
    over (
        order by sentiment_date desc
    ) = 1

)

select

    c.crypto_name,
    c.symbol,
    c.price_usd,
    c.market_cap_usd,

    f.fear_greed_value,
    f.market_sentiment,
    f.risk_level,
    f.sentiment_date

from {{ ref('stg_coingecko') }} c

cross join latest_sentiment f