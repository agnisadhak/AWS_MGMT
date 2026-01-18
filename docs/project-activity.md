# Project Activity Log (Our Deeds)

This document tracks the major achievements, milestones, and actions taken within this project since its inception on January 18, 2026.

## 🏁 Phase 1: Environment Orchestration
*Completed: Jan 18, 2026 (Morning)*

- **AWS CLI Deployment**: Successfully installed AWS CLI v2.33.2. Configured the environment with primary credentials and established `us-east-1` as the default region with JSON output formatting.
- **Terraform Integration**: Downloaded and deployed Terraform v1.14.3. Created an automated PowerShell installation script (`install-terraform.ps1`) to streamline future environment setups. 
- **Documentation Foundation**: Established comprehensive installation guides for both AWS CLI and Terraform to ensure consistency across environments.

## 🔍 Phase 2: Cost Discovery & Analysis
*Completed: Jan 18, 2026 (Mid-day)*

- **Anomaly Detection**: Identified a critical cost spike of **$8.61** that occurred on January 13, 2026. 
- **Deep Dive Analysis**: Investigated the spike and traced it back to **Amazon EC2 Compute** (\$7.54) and minor EBS/VPC anomalies.
- **Tool Creation**: Developed `check-aws-costs.ps1`, a powerful PowerShell tool that interfaces with the AWS Cost Explorer API to provide month-to-date tracking, forecasting, and service-specific breakdowns.
- **Reporting**: Generated multiple high-level summaries including `aws-cost-analysis-summary.md` and `resource-cost-breakdown.md` to track the $76.23 MTD spend.

## 🏗️ Phase 3: Infrastructure as Code (IaC)
*Completed: Jan 18, 2026 (Afternoon)*

- **Resource Templating**: Created final Terraform configurations for EC2 instances (`ec2_instances.tf`) and networking data lookups (`data.tf`).
- **State Management**: Successfully imported 2 existing EC2 instances (`Web_App_Server` and `Supabase_server-Email`) into the Terraform state.
- **Infrastructure Sync**: Synchronized local code with actual AWS metadata, specifically adjusting root volume sizes (100GB gp2 for Web_App and 30GB gp3 for Supabase) to ensure configuration parity.
- **RDS State Management**: Successfully **stopped** the `contact-manager-embedding-database` cluster in `ap-south-1` to stop compute charges immediately.
- **Active Cost Guard**: Deployed the `setup-rds-auto-stop.ps1` automation. Created the **EventBridge Watchdog** and **SSM Automation Target** to intercept the 7-day automatic restart loop, effectively "locking" the database in a cost-saving stopped state.
- **Verification**: Validated the entire setup with `terraform plan`, confirming that the local state perfectly tracks the cloud infrastructure.

## 📚 Phase 4: Knowledge Hub & Governance
*Completed: Jan 18, 2026 (Current)*

- **Documentation Repository**: Created the `docs/` directory to serve as a centralized hub for project governance.
- **Policy Definition**: Established "Do's and Don'ts" to prevent configuration drift and common security pitfalls.
- **Scope Mapping**: Clearly defined the management boundaries for infrastructure, cost, and security.
- **Version Control**: Initiated local git repository and mapped to `https://github.com/agnisadhak/AWS_mgmt`.

---

*Last Updated: January 18, 2026, 3:15 PM IST*
