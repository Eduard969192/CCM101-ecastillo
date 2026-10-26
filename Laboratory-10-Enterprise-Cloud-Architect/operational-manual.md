# CloudNova Private Web Stack — Operational Manual

## 1\. Purpose and design

This lab deploys a two-tier web application: WordPress (web/application tier) and MariaDB (database tier). Docker Compose defines the services reproducibly. The database is not published on a host port. Named volumes persist application and database files across container recreation and VM reboot.

**Lab exposure:** HTTP on TCP/8080 and SSH on TCP/22. This is a classroom environment, not a hardened public production deployment. For production, add TLS, a reverse proxy, secrets management, off-host backups, monitoring, patching procedures, and a tested recovery plan.

## 2\. Suggested VM setup

Use a Type 2 hypervisor such as VirtualBox and the official Ubuntu Server LTS ISO.

* VM name: `CloudNova-Ubuntu`
* OS type: Linux / Ubuntu (64-bit)
* CPU: 2 vCPUs
* RAM: 4 GB minimum (2 GB may work for a small demo, but can be tight)
* Disk: 25–40 GB dynamically allocated
* Network: Bridged Adapter is easiest for a host browser on the same LAN. Alternatively use NAT with a port-forward rule for SSH and HTTP. Avoid exposing the VM to the public internet.
* During Ubuntu install, create a normal admin user and enable OpenSSH Server if offered.
* After installation, sign in and run:

```bash
  sudo apt update \&\& sudo apt full-upgrade -y
  sudo apt install -y ca-certificates curl git ufw gzip
  ip -br address
  ```

Record the VM's reachable IPv4 address. If using bridged networking, the host and VM usually need to be on the same LAN.

## 3\. Install Docker Engine and Compose plugin

Follow the current official Docker instructions for Ubuntu at https://docs.docker.com/engine/install/ubuntu/. The following is the repository-based approach; verify it against the official page if commands change:

```bash
sudo apt update
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \\
  "deb \[arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \\
  $(. /etc/os-release \&\& echo "${UBUNTU\_CODENAME:-$VERSION\_CODENAME}") stable" | \\
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo docker run --rm hello-world
docker compose version
```

Use `sudo docker ...` for the lab. Membership in the `docker` group effectively grants root-level control, so do not add users casually.

## 4\. Place the project and configure secrets

Copy this folder to the VM, then place it at `/opt/cloudnova`. Example, if transferring from your host, use SCP or Git. On the VM:

```bash
sudo mkdir -p /opt/cloudnova
sudo chown "$USER":"$USER" /opt/cloudnova
cd /opt/cloudnova
cp .env.example .env
nano .env
```

Edit `VM\_LAN\_IP` to the VM's reachable LAN IPv4 address. Replace both database password placeholders with long, unique random values. You can generate values with `openssl rand -hex 24` (run twice). Keep `.env` private:

```bash
chmod 600 .env
```

**Never commit `.env` to GitHub.** The `.gitignore` in this project excludes it.

Validate the Compose configuration and start the stack:

```bash
sudo docker compose config
sudo docker compose pull
sudo docker compose up -d
sudo docker compose ps
sudo docker compose logs --tail=100
```

Open `http://<VM-LAN-IP>:8080` from the host browser and complete the WordPress first-run wizard.

## 5\. Configure UFW

**Important:** Before enabling UFW over SSH, allow SSH first or you may lock yourself out. If possible, keep the VM console open while applying firewall changes.

For a simple lab on a trusted private LAN:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp comment 'SSH administration'
sudo ufw allow 8080/tcp comment 'WordPress lab web'
sudo ufw enable
sudo ufw status verbose
```

For better restriction, replace the broad SSH rule with a source-restricted rule, using your actual trusted host/subnet, for example:
`sudo ufw allow from 192.168.1.0/24 to any port 22 proto tcp`
Then remove the broad rule with `sudo ufw delete allow 22/tcp` if appropriate. Do not copy the example subnet unless it matches your network.

Only TCP/22 and TCP/8080 should be allowed inbound for this lab. MariaDB's TCP/3306 is not published by Compose. Verify:

```bash
sudo ufw status numbered
sudo ss -tulpn
```

**Docker firewall note:** Docker-published ports may bypass some UFW filtering paths depending on configuration. Do not assume UFW alone fully protects a published Docker port. Keep this lab on a trusted network, bind the published port to the VM LAN IP, and consult Docker's packet-filtering/firewall documentation if you need strict source restrictions. Test from another device that only intended ports are reachable.

## 6\. Persistent storage and reboot test

Compose creates named volumes `cloudnova\_mariadb\_data` and `cloudnova\_wordpress\_data` (actual prefixes depend on the project directory name). Confirm:

```bash
sudo docker volume ls
sudo docker compose down
sudo docker compose up -d
sudo docker compose ps
```

Do not use `docker compose down -v` unless you intentionally want to delete the volumes and their data. For a VM reboot test:

```bash
sudo reboot
```

After reconnecting:

```bash
cd /opt/cloudnova
sudo docker compose ps
```

Confirm the WordPress site and previously created content still exist.

## 7\. Automated database backup

The script creates compressed SQL dumps, verifies the gzip archive, and deletes backups older than seven days. It logs to `/var/log/cloudnova-backup.log`.

```bash
sudo install -m 0750 automation-script.sh /opt/cloudnova/automation-script.sh
sudo touch /var/log/cloudnova-backup.log
sudo chown root:adm /var/log/cloudnova-backup.log
sudo chmod 0640 /var/log/cloudnova-backup.log
```

Test it manually:

```bash
sudo /opt/cloudnova/automation-script.sh
sudo tail -n 50 /var/log/cloudnova-backup.log
sudo ls -lh /opt/cloudnova/backups
```

Schedule daily at 02:00 using root's crontab:

```bash
sudo crontab -e
```

Add:

```cron
0 2 \* \* \* /opt/cloudnova/automation-script.sh
```

Verify the entry with `sudo crontab -l`. Ensure the VM is powered on at 02:00. Cron does not run missed jobs automatically when a VM is powered off.

## 8\. Restore procedure 

1. Stop WordPress to avoid writes during restore:
`cd /opt/cloudnova \&\& sudo docker compose stop wordpress`
2. Choose a known backup:
`ls -lh /opt/cloudnova/backups/`
3. Restore database dump:

```bash
   gunzip -c /opt/cloudnova/backups/mariadb\_YYYYMMDD\_HHMMSS.sql.gz | \\
     sudo docker compose exec -T db sh -c \\
     'exec mariadb -u"$MARIADB\_USER" -p"$MARIADB\_PASSWORD" "$MARIADB\_DATABASE"'
   ```

4. Start WordPress: `sudo docker compose start wordpress`
5. Verify site and content. Record the restore test date and result.

For actual disaster recovery, copy encrypted backups off the VM. Backups on the same virtual disk will be lost if that disk is lost.

## 9\. Operations and troubleshooting

```bash
sudo docker compose ps
sudo docker compose logs -f --tail=100
sudo docker stats
df -h
free -h
sudo systemctl status docker
sudo ufw status verbose
```

* **Browser cannot connect:** confirm VM IP with `ip -br address`, check bridged/NAT setup, `sudo docker compose ps`, and UFW rules.
* **WordPress reports database connection error:** wait for DB health check; inspect `sudo docker compose logs db wordpress`; verify `.env` values and restart with `sudo docker compose up -d`.
* **Port already in use:** choose another host port in `docker-compose.yml` and update UFW accordingly.
* **Disk full:** check `df -h`, backup size, and Docker usage before deleting anything. Never delete database volume data as a cleanup shortcut.
* **Backup fails:** inspect `/var/log/cloudnova-backup.log`, ensure database is healthy, and verify free disk space.

## 

