# Baiyabasa DB Networking Spike — Incident RCA

> **Generated:** 2026-07-14  
> **Account:** `730335513045` — Autoom_Studio  
> **Region:** `us-east-1`  
> **Primary host:** `Baiyabasa_Db_Server` (`i-04f4805c4a4965de2`)  
> **Scope note:** CPU credit balance is excluded from root-cause analysis (granted credit system).

---

## Summary verdict

| Question | Answer |
|----------|--------|
| Did `t3a.medium` **network bandwidth limits** cause the hang? | **No.** Peak DB egress was **~21 Mbps** vs **256 Mbps** baseline (~8%). |
| What correlated with the hang? | **Heavy DB NetworkOut + elevated DB CPU** at **2026-07-14 06:25 UTC**, with matching elevated **web NetworkIn**. |
| Secondary issue same day? | **gp3 volume read throughput hit 125 MB/s** (~100% of provisioned) at **11:55–11:59 UTC**. |
| Instance dead / status check fail? | **No** — reachability stayed OK. |

**Root cause (primary window):** A large DB data-transfer / query workload on Supabase (`Supabase_server_02` volume) drove high packet egress (~110k packets/min) and DB CPU (~71–77%). The web app (`Web_App_Server_coolify`) waited on slow DB responses — appearance of a site hang — without saturating the instance NIC ceiling.

---

## Host profile

| Field | Value |
|-------|--------|
| Name | `Baiyabasa_Db_Server` |
| Instance ID | `i-04f4805c4a4965de2` |
| Type | `t3a.medium` |
| Volume | `vol-0ac35233b69cebab7` — 100 GB **gp3**, tag `Supabase_server_02` |
| Private IP | `172.31.35.18` |
| Public IP | `52.45.113.46` |
| VPC / Subnet / AZ | `vpc-01686c093725d3d5f` / `subnet-0abd3bcfd167e91e7` / `us-east-1b` |
| Security group | `sg-059a4c3d8456e7392` (`launch-wizard-7`) — TCP 22/80/443 from `0.0.0.0/0` |
| IAM / SSM | **No** instance profile; **SSM not registered** (OS/Postgres logs not pullable via SSM) |

### Platform network / storage caps (`t3a.medium`)

| Limit | Cap |
|-------|-----|
| Network baseline | **256 Mbps** |
| Network peak | Up to **5 Gbps** (burst) |
| EBS-optimized baseline | ~350 Mbps (~43.75 MB/s) |
| Attached gp3 (pre-fix) | **125 MB/s**, 3000 IOPS |

---

## Traffic path

| Host | ID | Private IP | Public IP | Same subnet? |
|------|-----|------------|------------|--------------|
| Web_App_Server_coolify | `i-0ec347df8721a8215` | `172.31.35.213` | `3.232.162.36` | Yes (`subnet-0abd3bcfd167e91e7`) |
| Baiyabasa_Db_Server | `i-04f4805c4a4965de2` | `172.31.35.18` | `52.45.113.46` | Yes |

- Private path is available (same VPC, subnet, AZ).
- DB SG exposes only **22/80/443** publicly (no Postgres `5432`). Supabase is almost certainly reached via reverse proxy on 80/443 (Coolify-style).
- Web SG (`launch-wizard-1`) has many Coolify ports; several are open to the world (SSH, 6001/6002, AMQP, temporary 8000).
- **VPC Flow Logs:** none enabled on this VPC — cannot attribute spike peers from flow data.
- **Recommendation:** Prefer DB connection strings / proxy URLs using **private IP** `172.31.35.18` (or private DNS), not the public IP.

---

## Timeline and metrics

Method: CloudWatch 1-minute `Sum` for network → Mbps = `Sum_bytes * 8 / 60 / 1e6`. EBS MBps = `Sum_bytes / 60 / 1e6`.

### Primary window — 2026-07-14 ~06:25–07:35 UTC

| Time (UTC) | DB NetworkOut | DB CPU Max | WEB NetworkIn | Notes |
|------------|---------------|------------|---------------|-------|
| **06:25** | **20.81 Mbps** (149 MB/min), **110k pkts** | **70.8%** | **32.05 Mbps** | Strongest correlated spike |
| 06:50 | ~5.5 Mbps | **77.2%** | elevated | CPU peak continues |
| 07:05 | 8.87 Mbps | — | — | Secondary egress burst |
| 07:35 | 13.62 Mbps | — | — | Secondary egress burst |

### Secondary window — 2026-07-11 ~10:00–11:15 UTC

| Time (UTC) | Signal | Value |
|------------|--------|-------|
| 10:10 | DB CPU Max | **81.3%** |
| 10:55 | DB NetworkIn | **16.24 Mbps** (116 MB/min) |
| 11:00 | DB NetworkIn | 14.30 Mbps |
| 11:05 | WEB NetworkIn | **57.64 Mbps** |

### Disk saturation — 2026-07-14 ~11:55–11:59 UTC (after primary hang)

| Time (UTC) | Volume read throughput | vs gp3 125 MB/s |
|------------|------------------------|-----------------|
| 11:56 | **125.5 MB/s** | **~100% — ceiling** |
| 11:57 | 125.1 MB/s | ~100% |
| 11:59 | 125.3 MB/s | ~100% |

Queue length only rose to ~2.2–3.0 during this read storm (elevated, not extreme).

---

## Network-limit verdict

| Check | Peak observed | Cap | Result |
|-------|---------------|-----|--------|
| DB NetworkOut vs baseline | **20.81 Mbps** | 256 Mbps | **8.1% — not a factor** |
| DB NetworkIn vs baseline | **16.24 Mbps** (Jul 11) | 256 Mbps | **6.3% — not a factor** |
| Minutes ≥ 192 Mbps (75% baseline) | **0** | — | No approach |
| Minutes ≥ 256 Mbps | **0** | — | No hit |
| gp3 read throughput | **125.5 MB/s** | 125 MB/s | **Hit (afternoon)** |

**Conclusion:** Instance **NIC baseline was not the hang cause**. Remediations for network bandwidth right-sizing are **not required for this incident**. Remediations for **query/app load**, **gp3 throughput**, **monitoring**, and **SG hygiene** apply.

---

## Likely application mechanism

Without SSM/OS access, the workload cannot be named precisely. Evidence pattern matches:

1. Large Supabase/Postgres result set, dump, sync, or backup-adjacent I/O over HTTPS/proxy.
2. DB CPU rises while shipping ~150 MB in a minute and ~110k packets.
3. Web tier NetworkIn rises in the same minute → clients / app waiting on DB payloads.
4. Later the same day, multi-minute **full gp3 read bandwidth** usage — consistent with heavy local disk read (scan, backup, restore, vacuum, or large query spilling to storage).

---

## Actions taken (2026-07-14)

1. **CloudWatch alarms** on `i-04f4805c4a4965de2` / `vol-0ac35233b69cebab7`, SNS → `arn:aws:sns:us-east-1:730335513045:coolify-alerts`:
   - High NetworkOut / NetworkIn (50 Mbps sustained threshold)
   - High CPUUtilization (>70% over 10 minutes)
   - Elevated EBS VolumeQueueLength
   - High EBS VolumeReadBytes (near gp3 ceiling)
2. **gp3 throughput raised** on `vol-0ac35233b69cebab7` from **125 → 250 MB/s** (IOPS left at 3000) after confirmed saturation.
3. This RCA + inventory refresh in `docs/current-state.md`.

---

## Recommended remediations (remaining)

### Immediate (ops / app)

1. Prefer **private IP** for web→DB/Supabase connectivity.
2. Add **statement timeouts**, connection pool limits, and pagination / async jobs for large exports.
3. When the spike recurs, check Coolify/Supabase logs on the DB host for `pg_dump`, large REST responses, realtime fan-out, or backups coinciding with alarm time.
4. Enable **VPC Flow Logs** (short retention) if peer identification is needed next time.
5. Attach **IAM instance profile + SSM** to DB hosts for future forensics (no open SSH required).

### Security group lockdown (document — apply in change window)

**Current DB SG risk:** SSH/HTTP/HTTPS open to the world on a database host with a public IP.

Suggested end state for `launch-wizard-7` (or a replaced `baiyabasa-db-sg`):

- Remove `0.0.0.0/0` on port **22** (use SSM Session Manager instead).
- Restrict **80/443** to `Web_App_Server_coolify` SG (`sg-09905c7fdc2a43c67`) and/or known CDN/proxy CIDRs — not the open internet if the DB should not be public.
- Do **not** open `5432` to `0.0.0.0/0`.

Web SG also has temporary world-open rules (8000, 5672, 6001/6002) — tighten when Coolify remote access is no longer needed.

### Instance resize (optional — **not required for NIC limits**)

| Type | Baseline network | When to consider |
|------|------------------|------------------|
| `t3a.medium` (current) | 0.256 Gbps | Keep if CPU stays reasonable after app fixes |
| `m7a.medium` | 0.39 Gbps | Mild upgrade |
| `m6a.large` / `m7a.large` | 0.781 Gbps | If sustained high CPU + disk/network under load |

**Do not resize solely for this incident’s network spikes** — they stayed far below 256 Mbps. Resize only if post-fix monitoring still shows sustained high CPU or storage saturation with user approval.

### Terraform

Import `Baiyabasa_Db_Server` (and peer DB hosts) into IaC when ready so SG/sizing are not launch-wizard drift.

---

## Alarm reference

| Alarm name | Metric | Threshold (approx) |
|------------|--------|--------------------|
| `Baiyabasa-DB-HighNetworkOut` | EC2 NetworkOut Sum/1m | ≥ 50 Mbps (375,000,000 bytes/min) |
| `Baiyabasa-DB-HighNetworkIn` | EC2 NetworkIn Sum/1m | ≥ 50 Mbps |
| `Baiyabasa-DB-HighCPU` | EC2 CPUUtilization Avg/5m | ≥ 70% for 2 periods |
| `Baiyabasa-DB-HighEBSQueue` | EBS VolumeQueueLength Avg/1m | ≥ 2 for 5 minutes |
| `Baiyabasa-DB-HighEBSRead` | EBS VolumeReadBytes Sum/1m | ≥ ~100 MB/s (near prior 125 MB/s ceiling) |

---

## Success criteria checklist

- [x] Explicit Mbps vs 256 Mbps verdict (not a factor)
- [x] Hang explained via NetworkOut + CPU + web correlation (no CPU-credit framing)
- [x] Network-limit remediations listed; NIC resize deferred as not needed
- [x] Alarms created; gp3 throughput remediation applied after disk ceiling hit
