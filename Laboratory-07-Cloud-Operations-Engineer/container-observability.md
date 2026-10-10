# 🔍 Container Observability Report

---

## 📋 Overview

This report documents the application logs and live metrics for the `client-website` Nginx container that serves your marketing site. The container was started with Docker, sent three normal requests and one request for a page that does not exist, and then inspected using Docker's built-in tools.

---

## 📜 Application Logs

I retrieved the container's logs with `docker logs client-website`. They showed three successful requests with status 200 and one failed request with status 404. This is the single log line that records the 404 error:

```
[PASTE YOUR 404 LOG LINE HERE]
```

---

## 💡 Why Application Logs Matter

Your application logs record every request your server receives, including the time, the page that was requested, and the status code that came back, so your team can see exactly what happened when a user reports a problem. Without them your engineers would be guessing, but with them a single line like the 404 above shows which page failed and when.

---

## 🧰 Commands Used

| 💻 Command | 📋 What It Did |
|---|---|
| `docker logs client-website` | Printed the container's output, including the 200 and 404 request lines. |

---

## 📸 Evidence

### 🌐 Container Deployment

![Nginx container started and listed as running](screenshots/install-nginx.png)

### 🟢 Successful Requests

![Three successful curl requests to the website](screenshots/simulation1.png)

### 🔴 Failed Request

![curl request that returned a 404 Not Found page](screenshots/simulation2.png)

### 📜 Container Logs

![Output of docker logs client-website](screenshots/docker-logs.png)

---

## 📊 Container Metrics

Real-time container metrics will be recorded here after Checkpoint 5.
