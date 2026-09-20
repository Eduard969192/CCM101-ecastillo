# Docker Deployment Log

## Container Lifecycle Commands

| Command | What It Did |
|---|---|
| `docker ps` | Listed all currently running containers, showing that nginx-server was active. |
| `docker stop nginx-server` | Stopped the running nginx-server container. |
| `docker ps -a` | Listed all containers, including stopped ones, confirming nginx-server had stopped. |
| `docker rm nginx-server` | Permanently removed the stopped nginx-server container. |
