# 💾 Types of Cloud Storage

Cloud applications rely on different storage models depending on the kind of data they need to store and how that data will be accessed. The three primary types are Block Storage, File Storage, and Object Storage, each suited to a different set of workloads.

---

## 📊 Block vs. File vs. Object Storage

| Storage Type | 📝 Description | 🎯 Primary Use Case | ☁️ Cloud Provider Example |
|---|---|---|---|
| **🧱 Block Storage** | Splits data into fixed-size blocks, each with its own address, and presents them to a system like a raw hard drive. Requires an OS or application to manage the file system on top. | Databases, virtual machine disks, and applications needing fast, low-latency read/write access. | AWS EBS |
| **📁 File Storage** | Organizes data in a traditional hierarchical structure of files and folders, accessed through a shared network file system. | Shared drives, content management systems, and applications where multiple users or servers need to read and write the same files. | AWS EFS |
| **📦 Object Storage** | Stores data as discrete objects, each with its data, metadata, and a unique identifier, in a flat address space rather than folders. Built for massive scale. | Storing large volumes of unstructured data like images, videos, backups, and static web assets. | AWS S3 |

---

## ✅ Why Object Storage Fits the Client's Needs

For a photo-sharing application storing millions of user-uploaded images, Object Storage is the right choice. It scales to virtually unlimited capacity without the need to manage disks or file system hierarchies, and each image is stored as an independent object accessible over HTTP, which makes it simple to serve directly to users. Since containers are ephemeral, storing images outside the container in a dedicated object storage service also keeps the data safe and available even if the web server container is restarted or replaced.
