# Checkpoint 4 – Research the Major Cloud Providers

## Core Infrastructure Services Comparison

| Infrastructure Component | AWS | Microsoft Azure | Google Cloud Platform |
| :--- | :--- | :--- | :--- |
| **Compute** | Amazon Elastic Compute Cloud (EC2) | Azure Virtual Machines | Google Compute Engine (GCE) |
| **Storage** | Amazon Simple Storage Service (S3) | Azure Blob Storage | Google Cloud Storage (GCS) |
| **Networking** | Amazon Virtual Private Cloud (VPC) | Azure Virtual Network (VNet) | Google Virtual Private Cloud (VPC) |
| **Identity and Access Management (IAM)** | AWS Identity and Access Management (IAM) | Microsoft Entra ID (formerly Azure Active Directory) | Google Cloud Identity and Access Management (IAM) |

---

## Guide Questions

### 1. Which cloud provider offers the broadest range of services? Explain your answer.
AWS has the broadest range of services among the three. It launched in 2006, well ahead of Azure and GCP, and used that head start to build out products for nearly every use case: compute, storage, databases, IoT, serverless computing, and machine learning. That long track record means AWS often has a specialized service for a niche problem before its competitors do, which is why it still gets treated as the default choice for large, varied workloads.

### 2. Which cloud platform would you recommend for an organization that primarily uses Microsoft products? Why?
Azure is the clear fit for a Microsoft-heavy organization. It connects directly with Windows Server, Active Directory, and Microsoft 365, so IT teams can extend systems they already manage instead of learning a separate platform from scratch. Microsoft Entra ID (previously Azure Active Directory) centralizes identity management across both on-premises and cloud resources, and Azure Arc lets a company manage local servers and cloud services under one control plane. That level of native compatibility cuts down on both setup time and long-term maintenance.

### 3. Which platform is widely recognized for Artificial Intelligence (AI), Machine Learning (ML), and Kubernetes services?
Google Cloud Platform holds that reputation. Google originally built Kubernetes as an internal tool before open-sourcing it, so its managed offering, Google Kubernetes Engine, tends to be more refined than competing versions. On the AI and ML side, Google's custom TPU chips are built specifically for training large models faster than general-purpose hardware, and its data analytics tools (like BigQuery) pair well with ML pipelines. That combination is why GCP is usually the first platform mentioned in AI-focused projects.

### 4. What similarities did you observe among the three cloud providers?
All three run on the same shared-responsibility security model, where the provider secures the underlying infrastructure and the customer secures what they deploy on it. They also operate globally distributed data centers, which lets each one offer low-latency service across multiple regions. Beyond that, their core building blocks map closely to each other: virtual machines, object storage, isolated virtual networks, and role-based access control all exist in some form on every platform. Because the fundamentals overlap this much, a team that learns one provider well can pick up the other two without starting from zero.
