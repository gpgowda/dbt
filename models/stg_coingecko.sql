with ranked_crypto as (

    select
        *,
        row_number() over (
            partition by symbol
            order by extraction_time desc
        ) as rn

    from {{ source('crypto_analytics', 'raw_coingecko') }}

)

select

    id,

    upper(symbol) as symbol,

    name as crypto_name,

    round(current_price, 2) as price_usd,

    cast(round(market_cap, 2) as numeric)
        as market_cap_usd,

    cast(round(total_volume, 2) as numeric)
        as trading_volume_usd,

    market_cap_rank,

    cast(round(circulating_supply, 2) as numeric)
        as circulating_supply,

    cast(round(max_supply, 2) as numeric)
        as max_supply,

    round(price_change_percentage_24h, 2)
        as price_change_24h_pct,

    cast(snapshot_date as date)
        as snapshot_date,

    cast(extraction_time as timestamp)
        as extraction_time,

    case
        when max_supply is not null
             and max_supply > 0
        then round(
            (circulating_supply / max_supply) * 100,
            2
        )
        else null
    end as supply_utilization_pct

from ranked_crypto

where rn = 1
and current_price > 0