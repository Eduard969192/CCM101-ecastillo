## 📊 Real-Time Container Metrics

I viewed the container's live resource use with `docker stats`. At the time of my screenshot, the `client-website` container was using these resources:

| 📏 Metric | 📌 Value at Screenshot Time |
|---|---|
| **🧠 Memory Usage** | The container was using 2.738MiB of memory out of a 1.859GiB limit, which is 0.14% of the host's memory. |
| **⚙️ CPU Percentage** | The container was using 0.00% of CPU. |
| **🌐 Network I/O** | The container had received 3.8kB and sent 5.25kB, which reflects the four requests I sent. |

These readings were taken while the container was idle, so they describe its baseline footprint and are not a load test.
