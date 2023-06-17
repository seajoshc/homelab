# My homelab setup

## GKE on the cheap

Nearly free managed k8s one-node cluster with GKE on Google Cloud.

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

It's cheaper to host yourself and good to know how.

Postgres + pgAdmin
