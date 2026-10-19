# 🔥 Firewall Configuration

> The UFW rules applied to the CloudNova web server, the order they were applied in, and what the testing showed.

---

## 📋 Overview

This document records the commands used to secure the CloudNova web server with the Uncomplicated Firewall (UFW). The server runs an Nginx container named `secure-web-app` on port 8080, and the firewall was configured so that only the services your team needs can accept incoming connections.

---

## 🧭 Configuration Summary

| ⚙️ Setting | 📌 Result |
|---|---|
| **🔑 SSH Access** | Incoming SSH traffic on port 22 is allowed, so your administrators can manage the server remotely. |
| **🚫 Incoming Policy** | All incoming traffic is denied by default unless a rule allows it. |
| **📤 Outgoing Policy** | All outgoing traffic is allowed by default, so the server can still reach the internet. |
| **🌐 Web Application** | Incoming TCP traffic on port 8080 is allowed, so your users can reach the application. |
| **🔥 Firewall State** | The firewall is active and enabled to start automatically at boot. |

---

## 🔑 Step 1: Allow SSH

| 💻 Command | 📋 What It Did |
|---|---|
| `sudo ufw allow ssh` | Added a rule that permits incoming SSH connections on port 22 for both IPv4 and IPv6. |

### ⚠️ Why SSH Comes First

If `sudo ufw enable` were run before `sudo ufw allow ssh`, the default deny policy would immediately block incoming SSH connections and lock your administrators out of the server.

---

## 🚫 Step 2: Set the Default Deny Policy

| 💻 Command | 📋 What It Did |
|---|---|
| `sudo ufw default deny incoming` | Set the default policy to block every incoming connection that no rule explicitly allows. |
| `sudo ufw default allow outgoing` | Set the default policy to let the server's own outgoing connections through. |

---

## 🔥 Step 3: Enable the Firewall and Check Its Status

| 💻 Command | 📋 What It Did |
|---|---|
| `sudo ufw enable` | Turned the firewall on and set it to start at boot. |
| `sudo ufw status verbose` | Displayed the firewall state, the default policies, and every active rule. |

The status output after enabling the firewall:

```
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), deny (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    Anywhere
22/tcp (v6)                ALLOW IN    Anywhere (v6)
```

At this point only SSH had an allow rule.

---

## 🌐 Step 4: Allow Port 8080

| 💻 Command | 📋 What It Did |
|---|---|
| `sudo ufw allow 8080/tcp` | Added a rule that permits incoming TCP traffic on port 8080 for the web application. |
| `sudo ufw status numbered` | Listed every rule with a number, which confirmed that the new rule was added. |
| `curl http://localhost:8080` | Sent a web request to the application with the rule in place. |

The numbered rule list after the change:

```
Status: active

     To                         Action      From
     --                         ------      ----
[ 1] 22/tcp                     ALLOW IN    Anywhere
[ 2] 8080/tcp                   ALLOW IN    Anywhere
[ 3] 22/tcp (v6)                ALLOW IN    Anywhere (v6)
[ 4] 8080/tcp (v6)              ALLOW IN    Anywhere (v6)
```

The `curl` request returned the Nginx welcome page.

---

## 🔍 Observation: Docker and the Local Test

During testing, the web page answered a `curl` request on port 8080 even before the 8080 rule existed, while the default deny policy was already active. The request came from the server itself, and this firewall setup does not normally filter a server's own local traffic. Docker also publishes container ports with its own network rules, which can skip the rules that UFW manages, so your team should not assume that a UFW deny rule alone hides a Docker-published port from the internet. I did not test access from outside the server, so this lab shows that the rule is in place but does not prove that outside traffic would be blocked without it.

Two common ways to close this gap on a real server are listed below. I did not test either one in this lab.

| 🛠️ Option | 📋 How It Helps |
|---|---|
| **🔒 Bind the port to the local address** | Publishing the port as `127.0.0.1:8080:80` makes the container reachable only from the server itself. |
| **🧱 Filter in Docker's DOCKER-USER chain** | Docker leaves this chain free for administrator rules, and they are checked before Docker's own rules. |

---

## 📚 References

- Baeldung on Linux, an article on why Docker-published ports ignore UFW rules: https://www.baeldung.com/linux/docker-container-published-port-ignoring-ufw-rules
- SSD Nodes, a guide on how Docker ports bypass UFW and how to fix it: https://www.ssdnodes.com/learn/docker-ports-bypass-ufw

---

## 📸 Evidence

### 🔥 Firewall Activated

![UFW status showing the firewall active with the default deny policy](screenshots/firewall-activated.png)

### 🧪 Request Before the 8080 Rule

![curl request succeeding while only the SSH rules existed](screenshots/firewall-before-allow.png)

### 🌐 Port 8080 Allowed

![Numbered UFW rules and a successful curl request](screenshots/firewall-port-allowed.png)
