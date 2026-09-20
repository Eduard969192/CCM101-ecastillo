# 🐳 Docker Deployment Log

## 🔄 Container Lifecycle Commands

The following commands were used to manage the lifecycle of the Nginx container, from checking its running status through to full removal.

| Command | What It Did |
|---|---|
| `docker ps` | 📋 Listed all currently running containers, showing that `nginx-server` was active. |
| `docker stop nginx-server` | ⏹️ Stopped the running `nginx-server` container. |
| `docker ps -a` | 🔍 Listed all containers, including stopped ones, confirming `nginx-server` had exited. |
| `docker rm nginx-server` | 🗑️ Permanently removed the stopped `nginx-server` container. |

## 📸 Evidence

![Container Lifecycle](screenshots/container-lifecycle.png)

---

Running these commands in order confirmed the full lifecycle of a Docker container: from active and serving traffic, to stopped, to fully removed from the environment.
