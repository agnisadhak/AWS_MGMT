# AWS Infrastructure Project

This repository contains AWS infrastructure management tools and cost analysis scripts.

## 📁 Project Structure

### Infrastructure as Code
- **Terraform Files** (`*.tf`) - Infrastructure definitions for AWS resources
- **EC2 Instances** (`ec2_instances.tf`) - EC2 server configurations
- **Data Sources** (`data.tf`) - AWS data source definitions
- **Outputs** (`outputs.tf`) - Terraform output configurations

### Cost Management
- **Cost Analysis Scripts** (`check-aws-costs.ps1`) - PowerShell script for cost monitoring
- **Cost Reports** (`*.json`) - AWS cost analysis data (sample data)
- **Cost Analysis Summary** (`aws-cost-analysis-summary.md`) - Cost optimization insights
- **RDS Optimization** (`rds-optimization-review.md`) - Database cost optimization

### Setup & Documentation
- **Installation Guides**
  - `AWS_CLI_Installation_Guide.md` - AWS CLI setup instructions
  - `Terraform_Installation_Guide.md` - Terraform installation guide
  - `AWS_CLI_Commands_Reference.md` - Useful AWS CLI commands
- **Automation Scripts**
  - `install-terraform.ps1` - Automated Terraform installation
  - `setup-rds-auto-stop.ps1` - RDS cost optimization automation

## 🚀 Getting Started

### Prerequisites
- AWS CLI installed and configured
- Terraform installed
- PowerShell (for automation scripts)

### Setup
1. Clone this repository
2. Configure your AWS credentials
3. Review and modify Terraform variables as needed
4. Run `terraform init` to initialize the project

### Important Security Notes
- This repository does NOT contain actual AWS credentials or secrets
- Terraform state files are excluded from version control for security
- Cost report data is sample/anonymized data
- Always review files before committing to ensure no sensitive data is included

## 📊 Cost Management
The project includes comprehensive AWS cost analysis tools:
- Daily cost monitoring scripts
- Resource cost breakdown analysis
- RDS optimization recommendations
- Automated cost reporting

## 🛡️ Security
- All sensitive files are properly gitignored
- No AWS credentials or keys are stored in the repository
- Terraform state files are excluded for security

## 📝 License
This project is for educational/reference purposes. Please review and modify according to your specific needs and security requirements.