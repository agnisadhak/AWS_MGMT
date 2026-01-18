# AWS Infrastructure Project

This repository serves as the centralized hub for AWS infrastructure management, Infrastructure as Code (IaC) via Terraform, and advanced cost analysis automation.

## 📁 Project Structure

### 🏗️ Infrastructure as Code (IaC)
- `main.tf` - Core provider and backend configuration.
- `ec2_instances.tf` - Managed EC2 instance definitions (Web App & Supabase).
- `data.tf` - Networking and resource lookups across VPCs.
- `outputs.tf` - Critical resource exposure and identifiers.

### 💰 Cost Management & Automation
- `check-aws-costs.ps1` - Advanced cost tracking, forecasting, and service breakdown tool.
- `setup-rds-auto-stop.ps1` - Automation for database cost optimization.
- `install-terraform.ps1` - Environment bootstrapping script.
- `*.json` - Historical cost reports and metric snapshots.

### 📚 Documentation Hub
- [**Documentation Index**](docs/README.md) - **Primary Entry Point** for all guides.
- [**Walkthrough**](docs/walkthrough.md) - Step-by-step history of our infrastructure migration.
- [**Current Status**](docs/current-state.md) - Real-time tool and resource health.
- [**Activity Log**](docs/project-activity.md) - Operational history and milestones.

## 🚀 Getting Started

1. **Environment Setup**: Run `./install-terraform.ps1` and refer to the [AWS CLI Setup Group](docs/aws-cli-setup.md).
2. **IaC Initialization**: Execute `terraform init` to sync with the local state.
3. **Cost Auditing**: Run `./check-aws-costs.ps1` to view latest spending trends.

## 🛡️ Security & Governance
- **State Protection**: `.tfstate` files are handled strictly and git-ignored.
- **Reference Standards**: Review [**Do's and Don'ts**](docs/dos-and-donts.md) before making modifications.

---
*Managed by Antigravity AI - 2026*