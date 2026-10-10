# ☁️ Laboratory 07: Cloud Operations Engineer

**CCM101 Cloud Computing | University of Eastern Pangasinan | Mission 7**

---

## 🎯 Mission Overview

CloudNova Technologies is preparing a large marketing campaign for a client's website, and the client is worried that the cloud servers will run out of memory when thousands of users visit at once. As a member of the Cloud Operations Team, I performed a baseline health check on the host server, deployed the client's Nginx web server, sent test traffic to it, and used logs and live metrics to check that the infrastructure is ready for the surge.

This lab is about observability. Instead of hoping the application works, I collected evidence from the host, from the container's logs, and from its real-time metrics.

---

## 📋 Objectives

- Use native Linux command-line tools to monitor host CPU, memory, and disk capacity.
- Deploy a web container and track its real-time performance using Docker metrics.
- Generate web traffic and extract application access logs for analysis.
- Translate raw performance data into a readable technical report using Markdown.
- Continue expanding a professional GitHub Cloud Computing Portfolio.

---

## 🧰 Monitoring Commands Executed

| 💻 Command | 📋 What It Did |
|---|---|
| `free -h` | Displayed the host's total, used, and available memory in readable units. |
| `df -h /` | Displayed the size, used space, and available space of the root file system. |
| `top` | Opened a live view of running processes and CPU load, which I watched for 5 seconds before exiting with q. |
| `docker run -d --name client-website -p 8080:80 nginx` | Started an Nginx container named `client-website` in the background and mapped host port 8080 to container port 80. |
| `docker ps` | Listed the running containers and confirmed that `client-website` was up. |
| `curl http://localhost:8080` | Sent a request to the home page, which I ran three times to simulate three
