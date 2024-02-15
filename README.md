# My homelab setup

## Hetzner VPS

Big fan of Hetzner Cloud!

### Packages installed

- screen
- caddy
- `sudo apt install unattended-upgrades\nsudo systemctl enable unattended-upgrades\nsudo systemctl start unattended-upgrades`
- lnav
- glances
- monitorix (`sudo service monitorix restart`)
- `sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose`
- yt-dlp
- ffmpeg

### Docker containers

#### Portainer

```shell
sudo docker volume create portainer_data
sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
```

#### updating portainer

```shell
sudo docker pull portainer/portainer-ce:latest
sudo docker restart portainer
```

#### updating linking

```shell
cd repos/mephisto-config/linkding
docker-compose pull
docker-compose up -d
```

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

## GKE on the cheap

Nearly free managed k8s one-node cluster with GKE on Google Cloud.
