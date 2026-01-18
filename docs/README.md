# Project Documentation Hub

Welcome to the AWS Management project documentation. This folder serves as the centralized source of truth for our infrastructure, cost tools, and environment setup.

## 📁 Documentation Contents

### 🏗️ Infrastructure & Orchestration
- [**Walkthrough**](walkthrough.md) - **Recommended Reading**: Step-by-step history of the EC2 import process.
- [**Import Plan**](import-plan.md) - The original implementation strategy for moving to IaC.
- [**Terraform Setup**](terraform-setup.md) - Guide for installing and configuring Terraform.
- [**Current State**](current-state.md) - Real-time status of tools, active installations, and cloud resources.

### 💰 Cost Management
- [**Cost Summary**](cost-summary.md) - Analysis of the January 2026 spend and anomaly discovery.
- [**Resource Costs**](resource-costs.md) - Detailed breakdown of costs by individual AWS resource.
- [**RDS Optimization**](rds-optimization.md) - Strategy for reducing database costs via automated state management.

### 🛠️ Environment & Reference
- [**AWS CLI Setup**](aws-cli-setup.md) - Instructions for installing and authenticating the AWS CLI.
- [**AWS CLI Reference**](aws-cli-reference.md) - Quick reference for commonly used AWS management commands.
- [**Project Activity Log**](project-activity.md) - A chronological history of all "deeds" and milestones achieved.

### ⚖️ Governance
- [**Management Scopes**](management-scopes.md) - Clearly defined boundaries of what is managed in this project.
- [**Do's and Don'ts**](dos-and-donts.md) - Operational standards and security guidelines to prevent configuration drift.

---

## 🔗 Quick Navigation

- Root Project: [README.md](../README.md)
- Core IaC: [ec2_instances.tf](../ec2_instances.tf) | [main.tf](../main.tf)
- Automation: [check-aws-costs.ps1](../check-aws-costs.ps1) | [setup-rds-auto-stop.ps1](../setup-rds-auto-stop.ps1)

---

**Current Status:** 🟢 **Active Management** - Cost optimization and IaC import phase completed Jan 18, 2026.
