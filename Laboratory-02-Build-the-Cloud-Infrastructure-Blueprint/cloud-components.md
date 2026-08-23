# Checkpoint 3 – Identify Cloud Infrastructure Components

## 1. Compute Resources
* **Purpose:** Compute resources provide the processing power, CPU cycles, and memory required to execute instructions, run applications, and manage workloads.
* **Importance in Cloud Computing:** They form the core infrastructure that allows virtual servers (instances) to dynamically scale, process transactions, and run multi-tenant services on-demand without managing physical hardware.
* **KillerCoda Environment Evidence:** 
  * From `lscpu`, the environment runs on an **Intel Xeon E312xx (Sandy Bridge)** virtual CPU @ 2.0GHz with 1 core (`CPU(s): 1`, `Architecture: x86_64`) and uses a KVM hypervisor (`Hypervisor vendor: KVM`, `Virtualization type: full`).
  * From `free -h`, the system provides **1.9Gi of total RAM** (with 414Mi used and 863Mi free) and **1.0Gi of swap space** to handle processing demands.

---

## 2. Storage Resources
* **Purpose:** Storage resources provide persistent and temporary block, file, or object data storage capabilities to save files, operating system configurations, application data, and logs.
* **Importance in Cloud Computing:** Cloud storage ensures high availability, durability, data separation, and scalability, allowing workloads to read and write data reliably across distributed environments.
* **KillerCoda Environment Evidence:** 
  * From `df -h`, the environment mounts several storage filesystems:
    * `/dev/vda1`: A **19G** block storage volume mounted as the root directory (`/`), currently using 5.4G (30%).
    * `tmpfs`: Temporary in-memory filesystems allocated for runtime usage (e.g., 191M mounted on `/run`).
    * Specialized boot volumes like `/dev/vda16` (881M) and `/dev/vda15` (105M) for system boot management.

---

## 3. Networking Resources
* **Purpose:** Networking resources connect virtual instances to each other, to internal/external networks, and to the internet, handling traffic routing, IP allocation, and secure data transmission.
* **Importance in Cloud Computing:** They enable multi-tier application connectivity, virtual private cloud (VPC) isolation, load balancing, and secure container or microservices communication.
* **KillerCoda Environment Evidence:** 
  * From `ip a`:
    * `lo`: The standard loopback interface (`127.0.0.1`) for internal local host communication.
    * `enp1s0`: The primary external network interface assigned an active IPv4 address (`172.30.1.2/24`) and dynamic routing.
    * `docker0`: A bridge interface (`172.17.0.1/16`) utilized to provision internal virtual networking for containerized workloads.
  * From `hostname`, the system's network identity is configured as `ubuntu`.

---

## 4. Operating System
* **Purpose:** The operating system acts as the foundational software layer managing hardware resources, process scheduling, system security, file systems, and user/kernel interactions.
* **Importance in Cloud Computing:** It provides a standardized execution runtime environment for applications, administrative tools, and container engines (like Docker) to operate consistently across physical or virtual cloud infrastructure.
* **KillerCoda Environment Evidence:** 
  * From `cat /etc/os-release`, the environment runs **Ubuntu 24.04.4 LTS (Noble Numbat)**.
  * From `uname -r`, the system is powered by the Linux kernel version **6.8.0-138-generic**, providing the stable driver and kernel ecosystem required for modern cloud workloads.
