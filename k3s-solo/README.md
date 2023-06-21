# Setup new Debian 11 host

1. Setup bashrc for root. Of note, we're making sure [history is cranked up](https://www.digitalocean.com/community/tutorials/how-to-use-bash-history-commands-and-expansions-on-a-linux-vps).

```
# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "$(dircolors)"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# History
HISTSIZE=10000
HISTFILESIZE=100000
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
```

1. Disable password auth by changing `PasswordAuthentication: yes` to `no`. No other setting change is required. Verify with `ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no root@SERVER_IP`.

1. Disable root login by changing /etc/ssh/sshd_config `PermitRootLogin: no`

1. Install fail2ban

```
apt install fail2ban
cp -v /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
cp -v /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
systemctl start fail2ban
systemctl enable fail2ban
```

1. Unattended upgrades

```
sudo apt install unattended-upgrades
sudo systemctl enable unattended-upgrades
sudo systemctl start unattended-upgrades
```

1. Install k3s `curl -sfL https://get.k3s.io | sh -`

1. [Copy the k3s kubeconfig](https://rancher.com/docs/k3s/latest/en/cluster-access/) on the server with `cat /etc/rancher/k3s/k3s.yaml`

1. Paste the kubeconfig to your local `~/.kube/` with whatever name you like and use `KUBECONFIG=~/.kube/your_kubeconfig_name kubectl`. See more info on [managing multiple k8s environments here](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/).

1. Ideally install https://tailscale.com/download/linux/debian-bullseye and turn off all inbound network access with your service providers admin panel. Change the server IP in the kubeconfig from above to the `tailscale ip -4` Tailscale address.

1. `kubectl apply -n portainer -f https://raw.githubusercontent.com/portainer/k8s/master/deploy/manifests/portainer/portainer.yaml`. Open browser to http://server:30777 to finish setup (change default username as well).

1. restic for backups
Keep 24 hourly snapshots and 2 daily snapshots (most recent)
```
apt-get install restic

restic init --repo /restic-repo

echo 'export RESTIC_REPOSITORY="/restic-repo"' > /root/.restic-env
echo 'export RESTIC_PASSWORD="password"' >> /root/.restic-env

00 * * * * . /root/.restic-env; /usr/bin/restic backup -q /var/lib/rancher/k3s/storage; /usr/bin/restic forget -q --prune --keep-hourly 24 --keep-daily 3 --keep-weekly 1
```
