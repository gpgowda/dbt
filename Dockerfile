FROM ghcr.io/dbt-labs/dbt-bigquery:1.8.0

WORKDIR /dbt

COPY . .

CMD ["dbt","run"]