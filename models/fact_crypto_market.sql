with crypto_segments as (

    select *
    from {{ ref('int_crypto_segments') }}

),

volume_ratio as (

    select *
    from {{ ref('int_volume_ratio') }}

),

latest_sentiment as (

    select *

    from {{ ref('stg_fear_greed') }}

    qualify row_number()
    over(
        order by sentiment_date desc
    ) = 1

)

select

    c.crypto_name,

    c.symbol,

    c.price_usd,

    c.market_cap_usd,

    c.trading_volume_usd,

    c.market_cap_rank,

    c.market_segment,

    c.supply_utilization_pct,

    v.volume_marketcap_ratio,

    s.sentiment_date,

    s.fear_greed_value,

    s.fear_greed_classification,

    s.market_sentiment,

    s.risk_level,

    current_timestamp() as warehouse_load_time

from crypto_segments c

left join volume_ratio v
    on c.symbol = v.symbol

cross join latest_sentiment s