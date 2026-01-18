# Current State

This document outlines the current status of the AWS management project as of Jan 18, 2026.

## 🛠️ Tooling & Installation

| Tool | Status | Version | Notes |
| :--- | :--- | :--- | :--- |
| **AWS CLI** | ✅ Installed | 2.33.2 | Configured for `us-east-1`, JSON output. |
| **Terraform** | ✅ Installed | 1.14.3 | PATH configured, multi-platform binary. |
| **PowerShell** | ✅ Ready | 7.x/5.1 | Used for cost analysis and automation. |

## 🏗️ Infrastructure (Terraform)

The following resources are currently tracked and managed in the Terraform state:

- **EC2 Instance: Web_App_Server**: Defined in `ec2_instances.tf` (100GB gp2).
- **EC2 Instance: Supabase_server-Email**: Defined in `ec2_instances.tf` (30GB gp3).
- **RDS Cluster: contact-manager-embedding-database**: Managed in `ap-south-1`; currently **Stopped**.
- **Data Sources**: Configurations in `data.tf` for VPC/Subnet lookups.
- **Provider**: AWS Provider configured for `us-east-1` in `main.tf`.
- **State**: `terraform.tfstate` synchronized with AWS cloud environment.

## 💰 Cost Management

- **Analysis Script**: `check-aws-costs.ps1` is fully functional.
- **Reports**: Latest cost breakdown available in `resource-cost-breakdown.md`.
- **Optimization**: **Active** RDS Auto-Stop Watchdog (EventBridge + SSM Automation) to handle the 7-day auto-restart loop.
- **Data**: Multiple JSON reports are available for tactical cost reviews.

## 🔗 Configuration

- **AWS Credentials**: Stored in `~/.aws/credentials` (Local system only).
- **Regions**: Primary region is `us-east-1`.
