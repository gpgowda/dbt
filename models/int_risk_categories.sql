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
    supply_utilization_pct,

    case

        when supply_utilization_pct is null
            then 'Unknown'

        when supply_utilization_pct >= 90
            then 'High Utilization'

        when supply_utilization_pct >= 60
            then 'Medium Utilization'

        else 'Low Utilization'

    end as supply_category

from {{ ref('stg_coingecko') }}