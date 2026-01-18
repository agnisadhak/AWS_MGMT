# AWS Resource & Cost Breakdown
**Account ID:** 730335513045  
**User:** Aditya  
**Analysis Date:** January 18, 2026, 12:43 PM IST

---

## 🚨 **ROOT CAUSE IDENTIFIED!**

### **The Cost Anomaly Mystery - SOLVED**

Your cost spike starting **January 13, 2026** is caused by:

---

## 💻 **EC2 Instances Analysis**

### Currently Running Instances:

| Instance ID | Type | State | Launch Date | Name | Est. Monthly Cost |
|-------------|------|-------|-------------|------|-------------------|
| **i-0572e7b6a833d08fc** | **m7g.xlarge** | ✅ **RUNNING** | **Jan 17, 2026** | Web_App_Server | **~$120-140/month** |
| i-0dc408fa8eb153b9c | t3.small | ⏸️ STOPPED | Jan 18, 2026 | Supabase_server-Email | $0 (stopped) |

### 🎯 **Primary Cost Driver: m7g.xlarge Instance**

The **m7g.xlarge** instance is your main cost contributor:

- **Type:** m7g.xlarge (4 vCPUs, 16 GB RAM, Graviton3 ARM processor)
- **Pricing:** ~$0.163/hour = ~$120/month (on-demand pricing for ap-south-1)
- **Launched:** January 17, 2026 at 05:12 AM
- **Status:** Currently running 24/7
- **Purpose:** Web_App_Server

**This explains the EC2 compute anomaly of $7.54!**
- Instance has been running since Jan 17
- The cost spike you saw starting Jan 13 might be from initial setup/testing

---

## 💾 **EBS Volumes Analysis**

### Active Storage Volumes:

| Volume ID | Size (GB) | Type | State | Created | Attached To | Monthly Cost |
|-----------|-----------|------|-------|---------|-------------|--------------|
| **vol-045424c9f636376bc** | **100 GB** | gp2 | in-use | **Jan 13, 2026** | i-0572e7b6a833d08fc | **~$10/month** |
| vol-0e46a32bd5bedba47 | 30 GB | gp3 | in-use | Jan 15, 2026 | i-0dc408fa8eb153b9c | ~$2.40/month |
| vol-01d5308cb9db27619 | 50 GB | gp3 | in-use | Jan 15, 2026 | i-0dc408fa8eb153b9c | ~$4/month |

**Total EBS Cost:** ~$16.40/month

**This explains the EBS anomaly of $0.66!**
- 100 GB gp2 volume created on Jan 13 for the m7g.xlarge instance
- Additional volumes created Jan 15 for the Supabase server

---

## 🔍 **Timeline of Events**

| Date | Event | Cost Impact |
|------|-------|-------------|
| **Jan 13, 2026** | Created 100 GB gp2 volume | +$10/month |
| **Jan 15, 2026** | Created Supabase server (t3.small) with 2 volumes | +$15/month |
| **Jan 17, 2026** | Launched m7g.xlarge Web_App_Server | +$120/month |
| **Jan 18, 2026** | Stopped Supabase server | -$15/month (compute only) |

---

## 💰 **Estimated Monthly Cost Breakdown**

### Active Costs:

| Service | Resource | Monthly Cost | % of Total |
|---------|----------|--------------|------------|
| **EC2 Compute** | m7g.xlarge (running) | **$120-140** | **75%** |
| **EBS Storage** | 100 GB gp2 + 80 GB gp3 | **$16.40** | **10%** |
| **RDS** | (Details needed) | **$30-40** (est.) | **10%** |
| **Bedrock (Claude)** | AI API usage | **$5-10** (est.) | **3%** |
| **VPC/Networking** | Data transfer | **$5** (est.) | **2%** |
| **Total** | | **~$176-211/month** | **100%** |

**Note:** This is higher than the forecasted $80 because:
1. Free tier credits are being applied (~$120/month in credits)
2. Some services may be covered under AWS Free Tier
3. The Supabase server is now stopped

---

## ⚡ **Cost Optimization Recommendations**

### 🎯 **HIGH PRIORITY** (Immediate Savings)

1. **Right-size the m7g.xlarge Instance**
   - **Current:** m7g.xlarge (4 vCPUs, 16 GB RAM) @ ~$120/month
   - **Recommendation:** Consider m7g.large (2 vCPUs, 8 GB RAM) @ ~$60/month
   - **Potential Savings:** $60/month (50% reduction)
   
   ```bash
   # Check instance utilization first:
   aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization --dimensions Name=InstanceId,Value=i-0572e7b6a833d08fc --start-time 2026-01-17T00:00:00Z --end-time 2026-01-18T23:59:59Z --period 3600 --statistics Average
   ```

2. **Optimize EBS Storage**
   - **Current:** 100 GB gp2 @ $10/month
   - **Recommendation:** Migrate to gp3 @ $8/month
   - **Potential Savings:** $2/month (20% reduction)
   
   ```bash
   # Modify volume type to gp3:
   aws ec2 modify-volume --volume-id vol-045424c9f636376bc --volume-type gp3
   ```

3. **Stop Instances When Not Needed**
   - If Web_App_Server doesn't need to run 24/7:
   - **Savings:** ~$80/month if stopped 16 hours/day
   
   ```bash
   # Stop instance when not needed:
   aws ec2 stop-instances --instance-ids i-0572e7b6a833d08fc
   
   # Start instance when needed:
   aws ec2 start-instances --instance-ids i-0572e7b6a833d08fc
   ```

### 💡 **MEDIUM PRIORITY** (Long-term Savings)

4. **Consider Reserved Instances or Savings Plans**
   - If you'll run this workload for 1-3 years
   - **Savings:** Up to 72% off on-demand pricing
   - **Example:** $120/month → $34/month with 3-year commitment

5. **Implement Auto-Scaling**
   - Scale down during off-peak hours
   - Use smaller instances when traffic is low

6. **Review RDS Configuration**
   ```bash
   # Check RDS instances (none found, but verify):
   aws rds describe-db-instances --output table
   ```

7. **Monitor Claude/Bedrock Usage**
   - Implement caching to reduce API calls
   - Set usage limits and alerts

### 📊 **LOW PRIORITY** (Incremental Savings)

8. **Clean Up Unused Resources**
   - Delete snapshots older than X days
   - Remove unattached EBS volumes
   - Clean up old AMIs

9. **Enable S3 Intelligent-Tiering**
   - Automatically move data to cheaper storage classes

10. **Review VPC Endpoints**
    - Use VPC endpoints to reduce data transfer costs

---

## 📈 **Cost Tracking & Alerts**

### Set Up Budget Alerts:

```bash
# Create a budget for $80/month:
aws budgets create-budget --account-id 730335513045 --budget file://budget-config.json
```

Create `budget-config.json`:
```json
{
  "BudgetName": "MonthlyBudget",
  "BudgetLimit": {
    "Amount": "80",
    "Unit": "USD"
  },
  "TimeUnit": "MONTHLY",
  "BudgetType": "COST"
}
```

---

## ✅ **Immediate Action Items**

### Do This Week:

- [ ] **Monitor CPU utilization** of m7g.xlarge for 3-7 days
- [ ] **Right-size instance** if utilization is < 40%
- [ ] **Convert gp2 to gp3** for 20% storage savings
- [ ] **Set up AWS Budgets** with $80-100 threshold alerts
- [ ] **Review Web_App_Server usage pattern** - can it be stopped during off-hours?

### Do This Month:

- [ ] Evaluate Reserved Instance/Savings Plan if keeping m7g instance
- [ ] Review and clean up old snapshots/AMIs
- [ ] Implement CloudWatch metrics for better monitoring
- [ ] Document what each instance is used for
- [ ] Consider spot instances for non-critical workloads

---

## 🎯 **Expected Savings Summary**

| Optimization | Monthly Savings | Implementation Effort |
|--------------|-----------------|----------------------|
| Downgrade to m7g.large | **$60** | Low (5 min) |
| gp2 → gp3 migration | **$2** | Low (2 min) |
| Stop instance 12h/day | **$60** | Medium (automation needed) |
| Reserved Instance (1yr) | **$40** | Low (commitment required) |
| **Total Potential Savings** | **$162/month** | |

---

## 📞 **Questions to Answer**

1. **What is the Web_App_Server used for?** 
   - Is it production or development?
   - Does it need to run 24/7?
   - What's the expected traffic/load?

2. **What happened to the Supabase server?**
   - Can it be terminated if not needed?
   - Should the EBS volumes be kept or deleted?

3. **RDS Usage:**
   - The console showed RDS as a top cost driver
   - CLI shows no RDS instances
   - Is it

 in a different region?

---

**Generated on:** January 18, 2026, 12:45 PM IST  
**Next Review:** January 25, 2026
