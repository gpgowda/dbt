select

    market_segment,

    count(*) as total_coins,

    round(avg(price_usd),2) as avg_price,

    round(avg(market_cap_usd),2) as avg_market_cap

from {{ ref('int_crypto_segments') }}

group by market_segment