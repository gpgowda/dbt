select

    crypto_name,

    symbol,

    market_cap_usd,

    trading_volume_usd,

    round(
        trading_volume_usd /
        nullif(market_cap_usd,0),
        4
    ) as volume_marketcap_ratio,

    case

        when (
            trading_volume_usd /
            nullif(market_cap_usd,0)
        ) >= 0.50
        then 'High Activity'

        when (
            trading_volume_usd /
            nullif(market_cap_usd,0)
        ) >= 0.10
        then 'Moderate Activity'

        else 'Low Activity'

    end as liquidity_category

from {{ ref('stg_coingecko') }}