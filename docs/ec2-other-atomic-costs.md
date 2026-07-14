# EC2 - Other: Atomic Cost Breakdown

> **Generated:** 2026-07-07  
> **Account:** `730335513045` — Autoom_Studio  
> **Service:** EC2 - Other  
> **Source:** `aws ce get-cost-and-usage` grouped by `USAGE_TYPE`, filter `RECORD_TYPE=Usage`

---

## Summary

| Period                     | EC2-Other Total | Top Driver               |
|----------------------------|----------------|--------------------------|
| **June 2026** (full month) | **$99.14**     | CPU Credits t3a ($61.80) |
| **July 2026** (Jul 1–7)    | **$22.39**     | CPU Credits t3a ($11.58) |

---

## June 2026 — Full Atomic Breakdown

### 🔥 CPU Credits

| Usage Type       | Cost (USD)  | Usage Qty         | Unit        | % of EC2-Other |
|------------------|------------|-------------------|-------------|----------------|
| `CPUCredits:t3a` | **$61.80** | 1,236.03          | vCPU-Hours  | **62.3%**      |

> **What this is:** T3a instances are burstable. When they exceed their CPU credit baseline,
> they consume earned CPU credits at `$0.05/vCPU-Hour`. 1,236 vCPU-Hours were burst = **$61.80**.  
> **Fix:** Switch heavily-bursty t3a instances to a fixed-performance type (e.g. `m7g`, `c6g`)
> or enable **unlimited mode only when needed**.

---

### 💾 EBS Storage

| Usage Type              | Cost (USD)  | Usage Qty   | Unit       | Notes                         |
|-------------------------|------------|-------------|------------|-------------------------------|
| `EBS:VolumeUsage.gp3`   | **$18.27** | 228.34      | GB-Month   | GP3 volumes ($0.08/GB-Mo)     |
| `EBS:VolumeUsage.gp2`   | **$10.00** | 100.00      | GB-Month   | GP2 volumes ($0.10/GB-Mo)     |
| `EBS:VolumeP-IOPS.gp3`  | **$4.58**  | 916.99      | IOPS-Mo    | Provisioned IOPS above 3000   |
| `EBS:SnapshotUsage`     | **$2.64**  | 52.81       | GB-Month   | Snapshot storage ($0.05/GB)   |
| **EBS Subtotal**        | **$35.49** |             |            | **35.8% of EC2-Other**        |

> **Note:** You have 100 GB of older `gp2` volumes at $0.10/GB-Mo.
> Migrating them to `gp3` would save **~$2/month** (gp3 = $0.08/GB-Mo, also better perf).

---

### 🌐 Data Transfer (Regional & Cross-Region)

#### Regional Transfer
| Usage Type                     | Cost (USD) | Usage Qty | Unit |
|--------------------------------|-----------|-----------|------|
| `DataTransfer-Regional-Bytes`  | **$1.83** | 183.77    | GB   |

#### Cross-Region Transfer (USE1 → Other Regions, Out-bound)
| Route                          | Cost (USD)   | Data Sent (GB) | Destination             |
|--------------------------------|-------------|----------------|-------------------------|
| `USE1-USE2-AWS-Out-Bytes`      | $0.01754    | 1.754          | US East → US West 2     |
| `USE1-USW2-AWS-Out-Bytes`      | $0.000132   | 0.00662        | US East → US West 2 alt |
| `USE1-USW1-AWS-Out-Bytes`      | $0.0000425  | 0.00212        | US East → US West 1     |
| `USE1-APS1-AWS-Out-Bytes`      | $0.0000642  | 0.00321        | US East → AP Southeast 1 (Singapore) |
| `USE1-EU-AWS-Out-Bytes`        | $0.0000461  | 0.00230        | US East → EU            |
| `USE1-EUN1-AWS-Out-Bytes`      | $0.0000439  | 0.00219        | US East → EU North 1    |
| `USE1-APN1-AWS-Out-Bytes`      | $0.00000455 | 0.000227       | US East → AP Northeast 1 (Tokyo) |
| `USE1-APS2-AWS-Out-Bytes`      | $0.0000313  | 0.00157        | US East → AP Southeast 2 (Sydney) |
| `USE1-SAE1-AWS-Out-Bytes`      | $0.0000352  | 0.00176        | US East → South America  |
| `USE1-CAN1-AWS-Out-Bytes`      | $0.0000240  | 0.00120        | US East → Canada         |
| `USE1-EUC1-AWS-Out-Bytes`      | $0.0000181  | 0.000905       | US East → EU Central 1   |
| `USE1-EUW2-AWS-Out-Bytes`      | $0.0000178  | 0.000888       | US East → EU West 2      |
| `USE1-DEN1-AWS-Out-Bytes`      | $0.0000138  | 0.000692       | US East → Denver         |
| `USE1-APS3-AWS-Out-Bytes`      | $0.0000238  | 0.00119        | US East → AP Southeast 3 |
| `USE1-APN2-AWS-Out-Bytes`      | $0.00000089 | 0.0000443      | US East → AP Northeast 2 |
| `USE1-APN3-AWS-Out-Bytes`      | $0.00000515 | 0.000257       | US East → AP Northeast 3 |
| `USE1-EUW3-AWS-Out-Bytes`      | $0.00000678 | 0.000339       | US East → EU West 3      |
| `USE1-APE1-AWS-Out-Bytes`      | $0.000000104| 0.00000522     | US East → AP East 1      |
| `USE1-APS5-AWS-Out-Bytes`      | $0.000000004| 0.000000205    | US East → AP Southeast 5 |
| `USE1-APS6-AWS-Out-Bytes`      | $0.0000000613| 0.00000306    | US East → AP Southeast 6 |
| `USE1-ILC1-AWS-Out-Bytes`      | $0.000000732| 0.0000366      | US East → Israel         |
| **Cross-Region Subtotal**      | **~$0.018** |               |                          |
| **Data Transfer Total**        | **~$1.85**  |               | **1.9% of EC2-Other**    |

---

### 🖥️ EBS-Optimized Throughput (Free)

| Usage Type                  | Cost   | Usage Qty | Unit | Note                        |
|-----------------------------|--------|-----------|------|-----------------------------|
| `EBSOptimized:m7g.xlarge`   | $0.00  | 720.00    | Hrs  | Free on m7g                 |
| `EBSOptimized:t3a.xlarge`   | $0.00  | 465.07    | Hrs  | Free on t3a                 |
| `EBSOptimized:t3a.medium`   | $0.00  | 847.76    | Hrs  | Free on t3a                 |
| `EBSOptimized:t3a.large`    | $0.00  | 269.18    | Hrs  | Free on t3a                 |
| `EBSOptimized:t3.small`     | $0.00  | 1.92      | Hrs  | Free on t3                  |

---

### June 2026 — Cost Rollup

| Sub-Category             | Cost      | % of EC2-Other |
|--------------------------|-----------|----------------|
| CPU Credits (t3a burst)  | $61.80    | **62.3%**      |
| EBS Volumes (gp2 + gp3)  | $28.27    | **28.5%**      |
| EBS Provisioned IOPS     | $4.58     | **4.6%**       |
| EBS Snapshots            | $2.64     | **2.7%**       |
| Regional Data Transfer   | $1.83     | **1.8%**       |
| Cross-Region Transfer    | $0.018    | **0.02%**      |
| EBS-Optimized Throughput | $0.00     | —              |
| **TOTAL**                | **$99.14**| **100%**       |

---

## July 2026 — Full Atomic Breakdown (Jul 1–7) ⚡ *Estimated*

### 🔥 CPU Credits
| Usage Type       | Cost (USD)  | Usage Qty  | Unit       |
|------------------|------------|------------|------------|
| `CPUCredits:t3a` | **$11.58** | 231.62     | vCPU-Hours |

### 💾 EBS Storage
| Usage Type              | Cost (USD) | Usage Qty  | Unit       |
|-------------------------|-----------|------------|------------|
| `EBS:VolumeUsage.gp3`   | **$5.85** | 73.12      | GB-Month   |
| `EBS:VolumeP-IOPS.gp3`  | **$1.83** | 365.59     | IOPS-Mo    |
| `EBS:VolumeUsage.gp2`   | **$1.83** | 18.28      | GB-Month   |
| `EBS:SnapshotUsage`     | **$0.93** | 18.69      | GB-Month   |
| **EBS Subtotal**        | **$10.44**|            |            |

### 🌐 Data Transfer
| Usage Type                    | Cost (USD) | Data (GB) |
|-------------------------------|-----------|-----------|
| `DataTransfer-Regional-Bytes` | $0.3715   | 38.15     |
| Cross-region (all routes)     | ~$0.0001  | ~0.05     |
| **Transfer Subtotal**         | **$0.372**|           |

### 🖥️ EBS-Optimized Throughput (Free)
| Usage Type                 | Cost   | Hrs    |
|----------------------------|--------|--------|
| `EBSOptimized:m7g.xlarge`  | $0.00  | 140    |
| `EBSOptimized:t3a.medium`  | $0.00  | 431    |
| `EBSOptimized:t3a.large`   | $0.00  | 126.43 |

### July 2026 — Cost Rollup

| Sub-Category             | Cost      | % of EC2-Other |
|--------------------------|-----------|----------------|
| CPU Credits (t3a burst)  | $11.58    | **51.7%**      |
| EBS Volumes (gp2 + gp3)  | $7.68     | **34.3%**      |
| EBS Provisioned IOPS     | $1.83     | **8.2%**       |
| EBS Snapshots            | $0.93     | **4.2%**       |
| Regional Data Transfer   | $0.37     | **1.7%**       |
| Cross-Region Transfer    | ~$0.0001  | —              |
| **TOTAL**                | **$22.39**| **100%**       |

---

## Month-over-Month Comparison

| Line Item                  | Jun 2026   | Jul MTD    | Jun Daily  | Jul Daily  | Trend      |
|----------------------------|-----------|-----------|-----------|-----------|------------|
| CPU Credits t3a            | $61.80    | $11.58    | $2.06/day  | $1.65/day  | ↓ -20%     |
| EBS gp3 Volume             | $18.27    | $5.85     | $0.61/day  | $0.84/day  | ↑ +38%     |
| EBS gp2 Volume             | $10.00    | $1.83     | $0.33/day  | $0.26/day  | ↓ -20%     |
| EBS Provisioned IOPS gp3   | $4.58     | $1.83     | $0.15/day  | $0.26/day  | ↑ +72%     |
| EBS Snapshots              | $2.64     | $0.93     | $0.088/day | $0.133/day | ↑ +51%     |
| Regional Data Transfer     | $1.83     | $0.37     | $0.061/day | $0.053/day | ↓ -14%     |
| Cross-Region Transfer      | $0.018    | $0.0001   | —          | —          | ↓          |
| **TOTAL**                  | **$99.14**| **$22.39**| **$3.30** | **$3.20**  | ↓ **-3%**  |

---

## 💡 Optimization Recommendations

| # | Issue                              | Current Cost | Fix                                                   | Est. Saving   |
|---|------------------------------------|-------------|-------------------------------------------------------|---------------|
| 1 | **T3a CPU burst credits**          | $61.80/mo   | Switch bursty workloads to `m7g`/`c6g` fixed compute  | ~$20–40/mo    |
| 2 | **gp2 volumes still in use**       | $10.00/mo   | Migrate 100 GB gp2 → gp3 (same IOPS, better perf)    | ~$2/mo        |
| 3 | **EBS Snapshots accumulating**     | $2.64/mo    | Set snapshot lifecycle policy (delete old snapshots)  | ~$1–2/mo      |
| 4 | **Provisioned IOPS on gp3**        | $4.58/mo    | Verify if >3,000 IOPS actually needed; downsize if not| ~$2–3/mo      |
| 5 | **Cross-region data transfer**     | $0.018/mo   | Negligible — no action needed                         | —             |

> **Priority:** Fix #1 (CPU credits) first — it accounts for 62% of EC2-Other costs.

---

## Active Instance Types (from EBS-Optimized records)

| Instance Type   | Hours Jun | Hours Jul MTD | Status     |
|-----------------|-----------|---------------|------------|
| `m7g.xlarge`    | 720 hrs   | 140 hrs       | Running    |
| `t3a.medium`    | 847.76 hrs| 431 hrs       | Running    |
| `t3a.large`     | 269.18 hrs| 126.43 hrs    | Running    |
| `t3a.xlarge`    | 465.07 hrs| 0 hrs         | Stopped?   |
| `t3.small`      | 1.92 hrs  | 0 hrs         | Terminated |

> ⚠ `t3a.xlarge` ran 465 hrs in June but **0 hrs in July** — may have been terminated or stopped.

---

## How to Refresh

```powershell
[System.IO.File]::WriteAllText("X:\AWS\ec2-other-filter.json",
  '{"And":[{"Dimensions":{"Key":"RECORD_TYPE","Values":["Usage"]}},{"Dimensions":{"Key":"SERVICE","Values":["EC2 - Other"]}}]}')

aws ce get-cost-and-usage `
  --time-period Start=2026-06-01,End=2026-07-08 `
  --granularity MONTHLY `
  --metrics "BlendedCost" "UsageQuantity" `
  --group-by Type=DIMENSION,Key=USAGE_TYPE `
  --filter file://X:\AWS\ec2-other-filter.json `
  --output json
```
