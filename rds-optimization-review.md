# RDS Database Optimization Review

## 🐘 Current Status: Mumbai (ap-south-1)
**Resource:** Aurora PostgreSQL Cluster (`contact-manager-embedding-database`)
**Instance:** `contact-manager-embedding-database-instance-1` (Serverless v2)

### 📊 Performance Metrics (Last 24 Hours)
*   **Capacity (ACU):** Consistent **0.5 ACU** (Current minimum).
*   **CPU Utilization:** Constant ~32-33% baseline.
*   **Scaling:** No scale-up events detected in the last 7 days.
*   **Storage:** Performance is stable.

### 💰 Cost Analysis
*   **Current Rate:** 0.5 ACU * $0.12/ACU-hr = **$0.06/hour**.
*   **Monthly Total:** ~$43.80 / month.
*   **Snapshots:** Small automated snapshot cost (< $1/month).

---

## 🚀 Optimization Opportunities

### 1. Engine Migration (Standard RDS vs Aurora)
**Current:** Aurora Serverless v2 (0.5 ACU) — **$43.80/month**
**Alternative:** Standard RDS Instance (`db.t4g.micro`) — **~$13.00/month**
*   **Potential Savings:** **~$30/month (70% reduction)**.
*   **Trade-offs:** Standard RDS doesn't have Aurora's storage auto-scaling (up to 128TB) or the same failover speed, but for small workloads/databases, it is much more cost-effective.

### 2. Stop/Start Automation
If this database is for development or non-critical internal tools:
*   **Saving:** ~$1.46 per day it is stopped.
*   **Implementation:** Use a Lambda function or AWS Instance Scheduler to stop the cluster after business hours (e.g., 8 PM - 8 AM).
*   **Potential Saving:** **~$22/month** (if stopped 12 hours/day).

### 3. Review Constant 33% CPU
The database shows a constant 33% CPU even at idle. 
*   **Check:** Verify if there are any long-running queries, idle connections with high overhead, or background tasks (like `pg_cron` or embedding generation processes) that can be optimized.
*   **Benefit:** If CPU drops below a threshold, the instance might eventually support lower capacity units (though 0.5 is current AWS minimum for v2).

### 4. Storage Type
*   **Current:** Aurora storage.
*   **Note:** Aurora storage is billed per GB-month + I/O. If you move to Standard RDS, ensure you use `gp3` storage for the best price/performance.

---

## ✅ Recommended Actions

1.  **Immediate:** Evaluate if Aurora-specific features (Global Database, 15 Replicas, Serverless scaling) are actually needed. If not, **migration to `db.t4g.micro` or `db.t4g.small` standard RDS** is the single biggest saving.
2.  **This Week:** Investigate the consistent 33% CPU usage. Check `pg_stat_activity` to see what is running.
3.  **Automation:** If the DB is for dev, set up a stop/start schedule.

---
**Summary of Potential RDS Savings:** Up to **$360/year** by migrating to a smaller standard RDS instance.
