# AWS Cost by Service — 4-Month Comparison

> **Generated:** 2026-07-07  
> **Account:** `730335513045` — Autoom_Studio  
> **Source:** `aws ce get-cost-and-usage` (RECORD_TYPE = Usage, BlendedCost)  
> **Period:** April 2026 → July 2026 (MTD)  
> **Note:** All gross usage costs are **100% offset by AWS Credits** — net cash paid = $0.00

---

## Monthly Totals Overview

| Period                         | Gross Usage  | AWS Credits  | Net Paid | MoM Change     |
|--------------------------------|-------------|-------------|----------|----------------|
| **April 2026**                 | **$453.66** | -$453.66    | $0.00    | —              |
| **May 2026**                   | **$327.30** | -$327.30    | $0.00    | ↓ -$126.36 (-28%) |
| **June 2026**                  | **$367.01** | -$367.01    | $0.00    | ↑ +$39.71 (+12%) |
| **July 2026** *(Jul 1–7 est.)* | **$75.54**  | -$75.54     | $0.00    | On pace ~$323  |

```
Apr  ████████████████████████████████████████████  $453.66
May  ████████████████████████████████             $327.30
Jun  ████████████████████████████████████         $367.01
Jul  ███████▌ (7 days, ~$10.79/day)               $75.54 MTD
```

---

## Service-by-Service: 4-Month Breakdown

### Amazon EC2 — Compute

| Period    | Cost       | MoM Δ         | Notes                   |
|-----------|-----------|---------------|-------------------------|
| Apr 2026  | $225.68   | —             | Baseline                |
| May 2026  | $233.21   | ↑ +$7.53 (+3%)| Slight increase         |
| Jun 2026  | $239.53   | ↑ +$6.32 (+3%)| Continuing steady rise  |
| Jul MTD   | $48.72    | On pace ~$209 | ↓ Trending down         |

---

### EC2 - Other *(EBS, CPU Credits, Data Transfer)*

| Period    | Cost      | MoM Δ              | Notes                               |
|-----------|----------|--------------------|-------------------------------------|
| Apr 2026  | $30.48   | —                  | Low — fewer CPU credit bursts       |
| May 2026  | $53.35   | ↑ +$22.87 (+75%)   | ⚠ Sharp spike                      |
| Jun 2026  | $99.14   | ↑ +$45.79 (+86%)   | ⚠ Doubling — CPU credits & EBS grew |
| Jul MTD   | $22.39   | On pace ~$96       | Holding high                        |

> ⚠ **EC2-Other tripled from April to June.** Driven by T3a CPU credit bursting.
> See `docs/ec2-other-atomic-costs.md` for full atomic breakdown.

---

### Amazon Bedrock *(base model API)*

| Period    | Cost      | MoM Δ              | Notes                            |
|-----------|----------|--------------------|----------------------------------|
| Apr 2026  | $92.97   | —                  | Heavy Bedrock usage              |
| May 2026  | $0.00    | ↓ -$92.97 (-100%)  | ✅ No usage                      |
| Jun 2026  | $0.001   | ≈ $0               | Negligible                       |
| Jul MTD   | $0.00    | —                  | No usage yet                     |

---

### Claude Sonnet 4.5 *(Amazon Bedrock Edition)*

| Period    | Cost      | MoM Δ              | Notes                            |
|-----------|----------|--------------------|----------------------------------|
| Apr 2026  | $58.47   | —                  | High usage                       |
| May 2026  | $0.70    | ↓ -$57.77 (-99%)   | ✅ Dropped sharply               |
| Jun 2026  | $11.16   | ↑ +$10.46 (+1494%) | Resumed usage                    |
| Jul MTD   | $0.00    | —                  | Not billed yet                   |

---

### Claude Sonnet 4.6 *(Amazon Bedrock Edition)*

| Period    | Cost     | Notes                                   |
|-----------|----------|-----------------------------------------|
| Apr 2026  | $9.69    | Active                                  |
| May 2026  | $0.00    | No usage                                |
| Jun 2026  | $0.00    | No usage                                |
| Jul MTD   | $0.00    | No usage                                |

---

### Claude Haiku 4.5 *(Amazon Bedrock Edition)*

| Period    | Cost      | Notes             |
|-----------|-----------|-------------------|
| Apr 2026  | $0.003142 | Minimal usage     |
| May–Jul   | $0.00     | No usage          |

---

### Claude Opus 4.6 *(Amazon Bedrock Edition)*

| Period    | Cost       | Notes           |
|-----------|------------|-----------------|
| Apr 2026  | $0.0000715 | Negligible      |
| May–Jul   | $0.00      | No usage        |

---

### Amazon Relational Database Service (RDS)

| Period    | Cost      | MoM Δ              | Notes                            |
|-----------|----------|--------------------|----------------------------------|
| Apr 2026  | $13.02   | —                  | Baseline                         |
| May 2026  | $16.33   | ↑ +$3.31 (+25%)    | Increased DB usage               |
| Jun 2026  | $1.52    | ↓ -$14.81 (-91%)   | ✅ Sharp drop — DB optimized?    |
| Jul MTD   | $0.00    | —                  | Not yet billed                   |

---

### Amazon Virtual Private Cloud (VPC)

| Period    | Cost      | MoM Δ             | Notes                   |
|-----------|----------|-------------------|-------------------------|
| Apr 2026  | $10.80   | —                 | Baseline                |
| May 2026  | $11.16   | ↑ +$0.36 (+3%)    | Stable                  |
| Jun 2026  | $12.05   | ↑ +$0.89 (+8%)    | Slight rise             |
| Jul MTD   | $3.53    | On pace ~$15.13   | ↑ Trending up           |

---

### Amazon Simple Storage Service (S3)

| Period    | Cost      | MoM Δ              | Notes                           |
|-----------|----------|--------------------|----------------------------------|
| Apr 2026  | $11.48   | —                  | Baseline                         |
| May 2026  | $11.48   | → flat             | Stable                           |
| Jun 2026  | $2.54    | ↓ -$8.94 (-78%)    | ✅ Large drop — cleanup done?    |
| Jul MTD   | $0.30    | On pace ~$1.29     | ↓ Continued reduction            |

---

### Amazon Route 53

| Period    | Cost   | Notes                      |
|-----------|--------|----------------------------|
| Apr 2026  | $0.50  | Fixed hosted zone fee      |
| May 2026  | $0.50  | Flat                       |
| Jun 2026  | $0.50  | Flat                       |
| Jul MTD   | $0.50  | Flat (charged upfront)     |

---

### AWS Secrets Manager

| Period    | Cost   | Notes                            |
|-----------|--------|----------------------------------|
| Apr 2026  | $0.40  | ~4 secrets @ $0.10/mo each      |
| May 2026  | $0.40  | Flat                             |
| Jun 2026  | $0.40  | Flat                             |
| Jul MTD   | $0.076 | On pace ~$0.33 (slight dip)     |

---

### Amazon Glacier

| Period    | Cost   | Notes               |
|-----------|--------|---------------------|
| Apr 2026  | $0.163 | Flat archive storage|
| May 2026  | $0.163 | Flat                |
| Jun 2026  | $0.163 | Flat                |
| Jul MTD   | $0.032 | On pace ~$0.14      |

---

### Free / No-Cost Services (all periods)

| Service                  | Apr  | May  | Jun  | Jul  |
|--------------------------|------|------|------|------|
| AWS Glue                 | $0   | $0   | $0   | $0   |
| AWS Key Management Svc   | $0   | $0   | $0   | $0   |
| Amazon SNS               | $0   | $0   | $0   | $0   |
| AmazonCloudWatch         | $0   | $0   | $0   | $0   |

---

## Full Side-by-Side Comparison Table

| Service                          | Apr 2026  | May 2026  | Jun 2026  | Jul MTD   | 4-Mo Total |
|----------------------------------|-----------|-----------|-----------|-----------|------------|
| EC2 Compute                      | $225.68   | $233.21   | $239.53   | $48.72    | **$747.14**|
| EC2 - Other                      | $30.48    | $53.35    | $99.14    | $22.39    | **$205.36**|
| Amazon Bedrock (base)            | $92.97    | $0.00     | $0.001    | $0.00     | **$92.97** |
| Claude Sonnet 4.5                | $58.47    | $0.70     | $11.16    | $0.00     | **$70.33** |
| Amazon RDS                       | $13.02    | $16.33    | $1.52     | $0.00     | **$30.87** |
| Amazon S3                        | $11.48    | $11.48    | $2.54     | $0.30     | **$25.80** |
| Amazon VPC                       | $10.80    | $11.16    | $12.05    | $3.53     | **$37.54** |
| Claude Sonnet 4.6                | $9.69     | $0.00     | $0.00     | $0.00     | **$9.69**  |
| AWS Secrets Manager              | $0.40     | $0.40     | $0.40     | $0.076    | **$1.28**  |
| Amazon Route 53                  | $0.50     | $0.50     | $0.50     | $0.50     | **$2.00**  |
| Amazon Glacier                   | $0.163    | $0.163    | $0.163    | $0.032    | **$0.52**  |
| Claude Haiku 4.5                 | $0.003    | $0.00     | $0.00     | $0.00     | **$0.003** |
| Claude Opus 4.6                  | $0.00007  | $0.00     | $0.00     | $0.00     | **$0.0001**|
| AWS Glue / KMS / SNS / CW        | $0.00     | $0.00     | $0.00     | $0.00     | **$0.00**  |
| **GROSS TOTAL**                  | **$453.66**| **$327.30**| **$367.01**| **$75.54**| **$1,223.51** |
| AWS Credits Applied              | -$453.66  | -$327.30  | -$367.01  | -$75.54   | -$1,223.51 |
| **NET PAID**                     | **$0.00** | **$0.00** | **$0.00** | **$0.00** | **$0.00**  |

---

## Key Trends & Observations

| # | Observation | Impact |
|---|-------------|--------|
| 1 | **EC2-Other tripled Apr→Jun** ($30 → $99) | T3a CPU credit bursting is compounding — see `ec2-other-atomic-costs.md` |
| 2 | **Bedrock dropped 100% in May** after $92.97 in April | AI inference spend was one-time or project-specific |
| 3 | **RDS dropped 91% in June** ($16.33 → $1.52) | Database optimization or workload migration occurred |
| 4 | **S3 dropped 78% in June** ($11.48 → $2.54) | Storage cleanup completed or tiering applied |
| 5 | **EC2 Compute rising steadily** (+3%/month) | Fleet growth trend — monitor for further scaling |
| 6 | **July forecast ~$323–350** based on daily rate of $10.79/day | Below June total if trend holds |
| 7 | **AWS Credits cover 100% of all costs** | Verify credit expiry in Billing Console immediately |

---

## Credit Runway Analysis

| Month    | Credits Used | Cumulative Used |
|----------|-------------|-----------------|
| Apr 2026 | $453.66     | $453.66         |
| May 2026 | $327.30     | $780.96         |
| Jun 2026 | $367.01     | $1,147.97       |
| Jul 2026 | ~$323 est.  | ~$1,471 est.    |

> At ~$350/month average burn, every **$1,000 of remaining credits = ~2.9 months of runway**.  
> ⚠ **Action:** Check remaining credit balance at:  
> AWS Console → Billing → Credits

---

## How to Refresh

```powershell
# Update with latest data
[System.IO.File]::WriteAllText("X:\AWS\usage-filter.json",
  '{"Dimensions":{"Key":"RECORD_TYPE","Values":["Usage"]}}')

aws ce get-cost-and-usage `
  --time-period Start=2026-04-01,End=2026-07-08 `
  --granularity MONTHLY `
  --metrics "BlendedCost" `
  --group-by Type=DIMENSION,Key=SERVICE `
  --filter file://X:\AWS\usage-filter.json `
  --output json

# Credit totals by month
aws ce get-cost-and-usage `
  --time-period Start=2026-04-01,End=2026-07-08 `
  --granularity MONTHLY `
  --metrics "BlendedCost" `
  --group-by Type=DIMENSION,Key=RECORD_TYPE `
  --output json
```
