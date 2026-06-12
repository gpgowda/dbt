select

    id,
    symbol,
    crypto_name,
    price_usd,
    market_cap_usd,
    trading_volume_usd,
    market_cap_rank,
    circulating_supply,
    max_supply,
    price_change_24h_pct,
    snapshot_date,
    extraction_time,
    supply_utilization_pct,

    case
        when market_cap_usd >= 10000000000
            then 'Large Cap'

        when market_cap_usd >= 1000000000
            then 'Mid Cap'

        else 'Small Cap'

    end as market_segment

from {{ ref('stg_coingecko') }}