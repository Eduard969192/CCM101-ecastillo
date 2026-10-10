# 🔍 Container Observability Report

---

## 📋 Overview

This report documents the application logs and live metrics for the `client-website` Nginx container that serves your marketing site. The container was started with Docker, sent three normal requests and one request for a page that does not exist, and then inspected using Docker's built-in tools.

---

## 📜 Application Logs

I retrieved the container's logs with `docker logs client-website`. They showed three successful requests with status 200 and one failed request with status 404. This is the single log line that records the 404 error:

```
172.17.0.1 - - [10/Oct/2026:16:01:10 +0000] "GET /hidden-admin-page HTTP/1.1" 404 153 "-" "curl/8.5.0" "-"
```

Nginx also wrote a separate `[error]` line explaining that the requested file does not exist on the server.

---

## 🔎 Reading the Log Entries

| 🏷️ Request | 🕒 Time (UTC) | 📌 Status | 📋 What It Shows |
|---|---|---|---|
| **🟢 Request 1** | 16:00:00 | 200 | Your first visit to the home page succeeded. |
| **🟢 Request 2** | 16:00:18 | 200 | Your second visit to the home page succeeded. |
| **🟢 Request 3** | 16:00:31 | 200 | Your third visit to the home page succeeded. |
| **🔴 Request 4** | 16:01:10 | 404 | The request for `/hidden-admin-page` failed because that page does not exist. |

Each line also records the client address `172.17.0.1`, which is the Docker host's address on the container network, and the client type `curl/8.5.0`, which identifies my test tool.

---

## 💡 Why Application Logs Matter

Your application logs record every request your server receives, including the time, the page that was requested, and the status code that came back, so your team can see exactly what happened when a user reports a problem. Without them your engineers would be guessing, but with them a single line like the 404 above shows which page failed and when.

---

## 🧰 Commands Used

| 💻 Command | 📋 What It Did |
|---|---|
| `docker logs client-website` | Printed the container's output, including the 200 and 404 request lines. |
| `docker logs client-website 2>&1 \| grep " 404 "` | Filtered the output down to the log line that contains the 404 status. |

---

## 📸 Evidence

### 🌐 Container Deployment

![Nginx container started and listed as running](screenshots/install-nginx.png)

### 🟢 Successful Requests

![Successful curl requests to the website](screenshots/simulation1.png)

### 🔴 Failed Request

![curl request that returned a 404 Not Found page](screenshots/simulation2.png)

### 📜 Container Logs

![Output of docker logs client-website](screenshots/docker-logs.png)

---

## 📊 Container Metrics

Real-time container metrics will be recorded here after Checkpoint 5.
