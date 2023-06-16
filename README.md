# My homelab setup

## Observability

Inspo: https://blog.randombits.host/monitoring-self-hosted-services/

Prometheus with the following exporters/scrapers:

- Node Exporter (host metrics)
- cadvisor (container metrics)
- Docker

Grafana for viz

Next up:

- Loki + Promtail for logging
- Alert Manager

## Postgres

Postgres + pgAdmin
