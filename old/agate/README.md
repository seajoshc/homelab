# Installing [agate](https://github.com/mbrubeck/agate), a Gemini server, on Debian 11 Bullseye
## Key details
- `/srv/gemini/agate` agate server binary
- `/srv/gemini` for certs
- `/srv/gemini/content` for content
- Runs under svc account "gemini" that you need to create (e.g. `useradd gemini`)

## To run Agate as a service with systemd
1. Put `gemini.service` in `/etc/systemd/system/`
1. Put `gemini.conf` in `/etc/rsyslog.d/` and agate log messages appear in `/var/log/gemini.log`
1. Put `geminilogs` in `/etc/logrotate.d/` for logrotate magic
1. Run this:
```shell
sudo mkdir -pv /srv/gemini/content
sudo mkdir -pv /srv/gemini/.certificates
sudo chown -Rv gemini:gemini /srv/gemini/
systemctl daemon-reload
sudo systemctl restart rsyslog
sudo systemctl enable gemini
sudo systemctl start gemini
```
1. Validate with `systemctl status gemini`
