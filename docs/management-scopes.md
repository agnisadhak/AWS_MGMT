# Management Scopes

This project manages several key areas of the AWS environment. The scopes are divided into the following categories:

## 🏛️ 1. Infrastructure (IaC)

Management of actual cloud resources using Terraform.
- **Compute**: EC2 instance provisioning and configuration.
- **Networking**: VPC and Subnet data lookups (via Data Sources).
- **Database**: RDS optimization logic (Auto-stop/start).
- **Automation**: Terraform workflow (Init, Plan, Apply).

## 📊 2. Cost Analysis & Optimization

Monitoring and reducing AWS spend.
- **Daily Monitoring**: Scripts to track daily expenditures.
- **Resource Breakdown**: Granite analysis of which resources cost the most.
- **Recommendations**: Automated generation of cost-saving summaries.
- **Persistence**: Storage of historical cost data in JSON format for trend analysis.

## 🛠️ 3. Environment & Tools

Maintaining the local environment for AWS interaction.
- **CLI Management**: Keeping AWS CLI configured and updated.
- **IaC Setup**: Automated installation scripts for Terraform.
- **Auth**: Management of local configuration profiles.

## 🔒 4. Governance & Security

Ensuring the management process is safe.
- **Credential Safety**: Local-only storage of keys.
- **State Management**: Handling `.tfstate` files correctly.
- **Best Practices**: Documentation of operational standards.
