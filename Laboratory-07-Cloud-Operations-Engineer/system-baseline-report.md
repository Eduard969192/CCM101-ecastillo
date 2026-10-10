# 🖥️ System Baseline Report

---

## 📋 Overview

This report records the baseline health of the production host before the CloudNova marketing campaign begins. The measurements were taken on a KillerCoda Ubuntu Playground using native Linux tools, and they give your team a reference point to compare against once traffic increases.

---

## 📊 Baseline Values

| 📏 Metric | 📌 Recorded Result |
|---|---|
| **🧠 Total RAM** | The server has [TOTAL RAM] of total memory available. |
| **💽 Root (/) Storage** | The root file system has a total capacity of [ROOT STORAGE SIZE]. |

---

## 💡 Why Disk Space Matters Before a Traffic Surge

Checking disk space before a surge matters because heavy traffic fills your server with logs, caches, and uploads very quickly, and a full disk can crash your application even when memory and CPU look healthy.

---

## 🧰 Commands Used

| 💻 Command | 📋 What It Did |
|---|---|
| `free -h` | Displayed the server's total, used, and free memory in readable units. |
| `df -h /` | Displayed the size, used space, and available space of the root file system. |
| `top` | Opened a live view of running processes and CPU load, which I watched for 5 seconds before exiting with q. |

---

## 📸 Evidence

### 🧠 Memory Check

![Output of free -h showing server memory](screenshots/memory-check.png)

### 💽 Disk Check

![Output of df -h showing root file system storage](screenshots/disk-check.png)
