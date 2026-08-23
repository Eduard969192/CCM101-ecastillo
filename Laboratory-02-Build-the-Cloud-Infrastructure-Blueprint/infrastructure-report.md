# Infrastructure Report: Server Diagnostics Overview

## Server Specifications

| Metric / Parameter | Details / Specification |
| :--- | :--- |
| **Operating System** | Ubuntu 24.04.4 LTS (Noble Numbat) |
| **Kernel Version** | Linux 6.8.0-138-generic |
| **CPU Model** | Intel Xeon E312xx (Sandy Bridge, IBRS update) @ 2.0GHz |
| **CPU Cores** | 1 Core (1 Thread per core, 1 Socket) |
| **Total RAM** | 1.9Gi (with 1.0Gi Swap space) |
| **Disk Capacity** | 19G total capacity on root volume (`/dev/vda1`) |
| **Mounted File Systems** | `/` (`/dev/vda1`), `/run` (`tmpfs`), `/dev/shm`, `/sys/fs/cgroup`, `/boot` (`/dev/vda16`), `/boot/efi` (`/dev/vda15`) |
| **Hostname** | ubuntu |
| **IP Address** | `172.30.1.2/24` (enp1s0 interface) and `172.17.0.1/16` (docker0 bridge) |

## Investigation Summary
The KillerCoda cloud server environment was inspected successfully using standard Linux diagnostic commands (`lscpu`, `uname -r`, `free -h`, `df -h`, `hostname`, and `ip a`). The system runs a modern Ubuntu 24.04 LTS distribution on a virtualized KVM platform, providing adequate foundational resources for cloud infrastructure deployment and testing.
