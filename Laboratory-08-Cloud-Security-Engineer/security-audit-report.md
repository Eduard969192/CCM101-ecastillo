# 🛡️ Security Audit Report

> Core cloud security concepts behind the hardening of the CloudNova web server, documented before any changes were made to the live system.

---

## 📋 Overview

This report records the security principles that guide the lab. Each concept below is defined in my own words, and the final table shows how each one is applied to the server in this mission.

---

## 🔑 The Principle of Least Privilege (PoLP)

The Principle of Least Privilege means giving every user, application, and service only the access it needs to do its job, and nothing more. In the cloud this matters because accounts are the main way into a system, so a stolen or misused account with broad rights can do far more damage than one with narrow rights. Limiting access keeps a single mistake or breach from spreading across the whole environment.

---

## 🎯 Attack Surface

The attack surface of a virtual machine is the total set of points where an attacker could try to get in. This includes open network ports, running services, installed software, and user accounts. The more of these that are exposed, the more chances an attacker has to find a weakness, so a smaller attack surface means a safer machine.

---

## 🚫 Default Deny Policy

A default deny policy blocks all incoming traffic unless a rule specifically allows it. This is safer than blocking attackers one by one, because it is impossible to know every hostile address in advance and new ones appear constantly. With default deny, anything that was forgotten or never planned for stays blocked, and only the exact doors that legitimate services need are opened.

---

## 🧩 How These Concepts Apply to This Mission

| 🧠 Concept | 🛠️ Application in This Lab |
|---|---|
| **🔑 Principle of Least Privilege** | The firewall is configured to let in only SSH for administrators and port 8080 for the web application, so each service receives only the access it needs. |
| **🎯 Attack Surface** | The firewall is meant to shrink the exposed ports on the server down to the two that the client actually needs. |
| **🚫 Default Deny Policy** | The firewall is set to deny all incoming traffic by default and to allow outgoing traffic, with specific rules added afterward. |
