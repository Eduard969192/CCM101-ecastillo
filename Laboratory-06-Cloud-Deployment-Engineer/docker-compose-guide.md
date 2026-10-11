# 🐳 Docker Compose Guide

---

## 📖 Purpose

This guide documents the `docker-compose.yml` file used to deploy a two-tier Nextcloud environment for CloudNova Technologies. It is written so that another engineer can read the file, understand each part, and repeat the deployment.

---

## 📄 The Compose File

```yaml
services:
  database:
    image: mariadb:11.8
    environment:
      - MYSQL_ROOT_PASSWORD=cloudnova_root
      - MYSQL_PASSWORD=cloudnova_pass
      - MYSQL_DATABASE=nextcloud_db
      - MYSQL_USER=nextcloud_user

  app:
    image: nextcloud
    ports:
      - 8080:80
    environment:
      - MYSQL_PASSWORD=cloudnova_pass
      - MYSQL_DATABASE=nextcloud_db
      - MYSQL_USER=nextcloud_user
      - MYSQL_HOST=database
```

The passwords in this file are sample values for a lab proof of concept. A production deployment would store real secrets outside the Compose file.

---

## 🧱 What Does the `services:` Block Do?

The `services:` block is the top-level section that lists every container the application needs. Each entry under it, here `database` and `app`, describes one container, including its image, environment variables, and published ports. When Compose reads the file, it creates and starts one container for each entry. The name of each entry also becomes that container's hostname on the stack's private network.

| 🏷️ Service | 📦 Image | 🎯 Role | 🔌 Published Port |
|---|---|---|---|
| **🗄️ database** | `mariadb:11.8` | Stores user accounts and file metadata for Nextcloud. | None, so it can only be reached from inside the stack. |
| **🌐 app** | `nextcloud` | Serves the Nextcloud web interface to the browser. | Port 8080 on the host is mapped to port 80 in the container. |

---

## 🔗 How Did the Nextcloud App Container Find the Database?

The app container found the database through the `MYSQL_HOST=database` environment variable. When the stack started, Compose created a private network named `nextcloud-deployment_default` and attached both containers to it. On that network, each service name works as a hostname, so the name `database` resolves to the MariaDB container without any IP address being written into the file.

The three shared values, `MYSQL_DATABASE`, `MYSQL_USER`, and `MYSQL_PASSWORD`, must match in both services. The database container uses them to create the account, and the app container uses them to log in with it. The `docker-compose ps` output also shows that the database only listens on `3306/tcp` inside the stack and is not published to the host.

---

## ⚖️ `docker run` vs `docker-compose up -d`

| 🧩 Topic | 🐳 docker run | 📦 docker-compose up -d |
|---|---|---|
| **🎯 What it starts** | It starts one container per command, so a two-tier stack needs two separate commands. | It starts every service listed in the Compose file with a single command. |
| **📝 Where configuration lives** | Ports, variables, and names are typed as flags and are easy to forget or mistype. | All of that configuration is written down in `docker-compose.yml`. |
| **🔗 Networking** | The engineer has to create a network and attach each container by hand so they can find each other. | Compose creates a shared network automatically and lets services reach each other by name. |
| **🔁 Repeatability** | Repeating the deployment means retyping the commands exactly. | Repeating the deployment means running the same file again and getting the same result. |
| **🧹 Cleanup** | Each container has to be stopped and removed one at a time. | `docker-compose down` stops and removes the containers and the network together. |

---

## 🔠 Environment Variable Reference

| 🔑 Variable | 🧱 Used By | 📋 What It Does |
|---|---|---|
| `MYSQL_ROOT_PASSWORD` | database | Sets the administrator password for the MariaDB server. |
| `MYSQL_DATABASE` | database and app | Names the database that Nextcloud stores its data in. |
| `MYSQL_USER` | database and app | Names the database account that Nextcloud connects with. |
| `MYSQL_PASSWORD` | database and app | Sets and supplies the password for that database account. |
| `MYSQL_HOST` | app | Tells Nextcloud which hostname to connect to, which is the `database` service. |

---

## 🛠️ Deployment and Teardown Commands

| 💻 Command | 📋 What It Did |
|---|---|
| `docker-compose up -d` | Pulled both images, created the network, and started both containers in the background. |
| `docker-compose ps` | Listed the stack's containers and showed that both were in the Up state. |
| `docker-compose down` | Stopped and removed both containers and the stack's network. |

---

## 📝 Deviations From the Lab Spec

| 🔧 Item | 📋 Spec Said | ✅ What I Ran | 💡 Why |
|---|---|---|---|
| **🗄️ MariaDB image** | `mariadb:10.6` | `mariadb:11.8` | MariaDB 10.6 reached end of life on 6 July 2026, and Nextcloud 35 no longer supports it, so I used a currently supported release. |
| **📄 Version line** | `version: '3'` | Line omitted | The `version` line is optional in the Compose specification, and `docker-compose config` filled in a default value automatically. |

The KillerCoda Ubuntu 24.04 machine did not recognize `docker compose` (with a space). It has the standalone `docker-compose` command, version 1.29.2, so every Compose command in this lab uses the hyphenated form.

---

## 📸 Evidence

### 🚀 Stack Deployment

![Docker Compose deployment output and running containers](screenshots/compose-deployment.png)

### 🌐 Nextcloud Setup Page on Port 8080

![Nextcloud setup page in the browser](screenshots/nextcloud-web.png)

### 🧹 Stack Teardown

![Docker Compose teardown output](screenshots/compose-teardown.png)
