# My homelab setup

## Hetzner VPS

- Caddy
- Portainer
- Linkding
- Random side projects

## GKE on the cheap

Nearly free managed k8s one-node cluster with GKE on Google Cloud.

## Mac mini

Intel Mac mini hosting observability tools and a central Postgres database.

Inspo: https://blog.randombits.host/monitoring-self-hosted-services/

Prometheus with the following exporters/scrapers:

- Node Exporter (host metrics)
- cadvisor (container metrics)
- Docker

Grafana for viz

Have a WIP Loki setup, never back around to finish this.

- Loki + Promtail for logging
- Alert Manager

Postgres: It's cheaper to host yourself and good to know how.

Postgres + pgAdmin
