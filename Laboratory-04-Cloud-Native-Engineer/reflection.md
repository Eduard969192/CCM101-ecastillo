# 💭 Mission Reflection

## ⏱️ Boot Time & Setup: Containers vs. VMs

Starting a Docker container is much faster than booting a Virtual Machine. A VM needs a complete guest operating system to install and initialize before an application can even run, which takes minutes and consumes significant resources. A container skips that entirely by sharing the host operating system's kernel and only starting the application process itself. That difference is what makes containers a better fit for cloud-native environments where speed and efficiency matter.

## 🔌 Why Port Mapping Matters

The flag `-p 8080:80` is necessary because the Nginx server inside the container listens on port `80`, but that port is only accessible from within the container itself. Port mapping bridges the container's internal port to a port on the host machine, in this case `8080`. Without that mapping, there would be no way to reach the web server from outside the container, even though it's running.

## 🗑️ What Happens to Data on `docker rm`

Running `docker rm` permanently deletes the container, including anything stored in its writable layer. This was an important distinction to learn: a container isn't meant to be permanent storage. Any data that needs to survive beyond a container's lifecycle should be handled with Docker volumes instead, which exist independently of the container itself.

## 🤝 Containerization and DevOps

Containers change how developers and operations teams work together by giving both sides a consistent unit to build around. A developer can package an application with everything it needs to run, and that same package deploys identically whether it's on a laptop, a test server, or in production. That consistency removes a lot of the "it worked on my machine" friction that used to slow down handoffs between development and operations.

## 📂 How My GitHub Portfolio Is Evolving

This lab pushed my portfolio further from a collection of finished assignments into something closer to a working log of what I'm actually learning. Between the command tables, screenshots, and explanations across each file, it's becoming a record I could hand to someone else and have them understand exactly what I did and why. Working through Docker, Nginx, and container lifecycle management this time made that shift a lot more concrete than the earlier labs did.
