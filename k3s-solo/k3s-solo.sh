echo "Configuring root's .bashrc 🔧"
cat > /root/.bashrc<< EOF
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
EOF
echo "root's .bashrc configured 🎉"

echo "Configuring fail2ban 🔧"
apt install fail2ban
cp -v /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
cp -v /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
systemctl start fail2ban
systemctl enable fail2ban
echo "fail2ban configured 🎉"

echo "Configuring unattended-upgrades 🔧"
apt install unattended-upgrades
systemctl enable unattended-upgrades
systemctl start unattended-upgrades
echo "unattended-upgrades configured 🎉"

echo "Configuring backups (restic) 🔧"
apt-get install restic
restic init --repo /backups
echo 'export RESTIC_REPOSITORY="/backups"' > /root/.restic-env
echo 'export RESTIC_PASSWORD="password"' >> /root/.restic-env
# Keep 24 hourly snapshots and 3 daily snapshots (most recent) and 1 weekly snapshot (most recent)
00 * * * * . /root/.restic-env; /usr/bin/restic backup -q /var/lib/rancher/k3s/storage; /usr/bin/restic forget -q --prune --keep-hourly 24 --keep-daily 3 --keep-weekly 1
echo "restic configured 🎉"

echo "Configuring dynamic motd 🔧"
apt-get install figlet lsb-release python3-utmp bc debian-goodies
mv /etc/update-motd.d{,.old}
cp -r update-motd.d/ /etc
touch /etc/update-motd.d/hushlogin
mv /etc/motd{,.original}
ln -s /var/run/motd /etc/motd
echo "dynamic motd configured 🎉"

echo "Configuring logwatch 🔧"
apt-get install -y logwatch sendmail-bin sendmail
echo "include(/etc/mail/tls/starttls.m4)dnl" >> /etc/mail/sendmail.mc
sendmailconfig
service sendmail restart
20 4 * * * /usr/sbin/logwatch
echo "logwatch configured 🎉"

echo "Configuring must-have utilities 🔧"
apt install htop
echo "utilities are ready 🎉"

echo "Configuring timezone 🔧"
dpkg-reconfigure tzdata
echo "timezone configured 🎉"

echo "Configuring BLAH 🔧"
echo "BLAH configured 🎉"

echo "🚨 copy/paste this kubeconfig context into ~/.kube/config or to a new file like ~/.kube/blastoff-linode-k3s-solo"
cat /etc/rancher/k3s/k3s.yaml

# Ideally install https://tailscale.com/download/linux/debian-bullseye and turn off all inbound network access with your service providers admin panel. Change the server IP in the kubeconfig from above to the `tailscale ip -4` Tailscale address.

# `kubectl apply -n portainer -f https://raw.githubusercontent.com/portainer/k8s/master/deploy/manifests/portainer/portainer.yaml`. Open browser to http://server:30777 to finish setup (change default username as well).
