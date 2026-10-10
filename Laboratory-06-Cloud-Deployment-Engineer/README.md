# 🚀 Laboratory 06: Cloud Deployment Engineer

**CCM101 Cloud Computing | University of Eastern Pangasinan | Mission 6**

---

## 🎯 Mission Overview

CloudNova Technologies asked for a proof-of-concept private cloud storage system for a university client that wants to stop paying for Google Drive. Nextcloud needs a database to store user credentials and file metadata, so the deployment is a two-tier architecture. A MariaDB container holds the data, and a Nextcloud container serves the web interface.

Instead of starting each container by hand, I defined both in one `docker-compose.yml` file and deployed the whole stack with a single command. This lab moves from typing commands to writing Infrastructure as Code.

---

## 📋 Objectives

- Explain the concept of a multi-tier application architecture.
- Understand the purpose and structure of a `docker-compose.yml` file.
- Use a Linux command-line text editor (nano) to create configuration files.
- Deploy a multi-container application (Nextcloud + database) using Docker Compose.
- Document deployment procedures and Infrastructure as Code principles using Markdown.
- Continue expanding a professional GitHub Cloud Computing Portfolio.

---

## 🧰 Commands Executed

| 💻 Command | 📋 What It Did |
|---|---|
| `mkdir nextcloud-deployment` | Created a project folder for the deployment. |
| `cd nextcloud-deployment` | Moved into the project folder. |
| `docker compose version` | Tried the Compose plugin command, which this KillerCoda machine did not recognize. |
| `docker-compose version` | Confirmed that standalone Docker Compose 1.29.2 is installed. |
| `nano docker-compose.yml` | Opened the nano editor to write the Compose file. |
| `cat docker-compose.yml` | Printed the file to check that the indentation was correct. |
| `docker-compose config` | Validated the YAML and printed the parsed configuration. |
| `docker-compose up -d` | Pulled both images, created the network, and started both containers in the background. |
| `docker-compose ps` | Listed the containers and confirmed that both were running. |
| `docker-compose down` | Stopped and removed both containers and the network. |

After deployment, I opened port 8080 through KillerCoda's Traffic / Ports feature to view the Nextcloud setup page.

**📝 Note on deviations:** I used `mariadb:11.8` instead of the spec's `mariadb:10.6` because MariaDB 10.6 reached end of life on 6 July 2026 and Nextcloud 35 dropped support for it. I also left out the optional `version` line. Details are in [docker-compose-guide.md](docker-compose-guide.md).

---

## 💡 Skills Learned

- Describing the roles of the web/application tier and the database tier in a two-tier architecture.
- Writing a multi-service `docker-compose.yml` file with correct YAML indentation.
- Creating and editing configuration files with nano on a Linux terminal.
- Connecting two containers by service name, using the `MYSQL_HOST` environment variable.
- Deploying and tearing down a whole container stack with `docker-compose up -d` and `docker-compose down`.
- Checking whether a vendor image in a lab spec is still supported, and replacing it when it is not.
- Documenting Infrastructure as Code clearly in Markdown, with screenshots as evidence.

---

## 📂 Deliverables

| 📄 File | 📋 Description |
|---|---|
| [multi-tier-architecture.md](multi-tier-architecture.md) | Defines the two-tier architecture and why the tiers are separated. |
| [docker-compose-guide.md](docker-compose-guide.md) | Documents the Compose file, how the containers find each other, and `docker run` vs Compose. |
| [reflection.md](reflection.md) | Mission reflection. |
| `screenshots/` | Evidence of the deployment, the Nextcloud page, and the teardown. |

---

## 📸 Evidence

### 🚀 Stack Deployment

![Docker Compose deployment output and running containers](screenshots/compose-deployment.png)

### 🌐 Nextcloud Setup Page

![Nextcloud setup page in the browser](screenshots/nextcloud-web.png)

### 🧹 Stack Teardown

![Docker Compose teardown output](screenshots/compose-teardown.png)
