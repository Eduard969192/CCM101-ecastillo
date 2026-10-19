# 💭 Mission Reflection

---

## 🌐 1. Host-Based Firewall Protection

The perimeter is only the first wall. If someone gets past it, or is already inside the network, the firewall on the server still decides what can reach each port. In my lab I denied all incoming traffic and allowed only SSH and port 8080, so anything else had no rule letting it in.

---

## 🔌 2. Why Open Ports Matter

Every open port is a place where something can listen and be attacked. When I ran ss -tulpn, I saw SSH on port 22, Docker's proxy on 8080, and several other ports listening on all addresses. I had not expected so many. Filtering the ones nobody needs leaves fewer services for an attacker to probe.

---

## 🗄️ 3. Open Database Ports

I did not run a database in this lab, so this answer comes from the reading. A database holds accounts, passwords, and file records, and an open port 3306 lets anyone on the internet try to log in or guess passwords. It should only be reachable from the application that needs it, like the MariaDB container in Lab 6, which had no published port.

---

## 🔍 4. How My View Changed

A fresh server already had services listening on all addresses before I changed anything. The bigger surprise was my test. The curl to port 8080 worked before I added the allow rule. I read that Docker publishes ports with its own rules that can skip UFW, and I only tested from the server itself, so I cannot say what an outside user would have seen.

---

## 📁 5. My Portfolio Now

The spec mentions eight completed missions, but I have seven. Lab 3 is still marked Not Started because my client had me skip it. Labs 1, 2, and 4 to 8 each have their own folder with documentation and screenshots, and my main README tracks all of them.
