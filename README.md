# AWS_MGMT - AWS Infrastructure Management

🚀 **Production-Ready AWS Infrastructure Management with Terraform and Cost Analysis Tools**

This repository provides a comprehensive solution for managing AWS infrastructure using Infrastructure as Code (IaC) principles, advanced cost monitoring, and automated optimization strategies.

## 🌟 Key Features

- ✅ **Terraform IaC Management** - Complete EC2, RDS, and VPC infrastructure
- 📊 **Advanced Cost Analysis** - PowerShell-based cost tracking and forecasting
- 🔒 **Security-First Approach** - Proper secret management and state protection
- 🤖 **Automation Scripts** - One-click environment setup and optimization
- 📚 **Comprehensive Documentation** - Step-by-step guides and best practices

## 📁 Repository Structure

```
AWS_MGMT/
├── 🏗️ Infrastructure as Code
│   ├── main.tf              # Provider and backend configuration
│   ├── ec2_instances.tf     # EC2 instance definitions (Web App & Supabase)
│   ├── data.tf             # VPC and networking data sources
│   └── outputs.tf          # Resource outputs and identifiers
│
├── 💰 Cost Management
│   ├── check-aws-costs.ps1     # Cost analysis and forecasting tool
│   ├── setup-rds-auto-stop.ps1 # RDS cost optimization automation
│   ├── cost_report_jan2026.json # Historical cost data
│   └── costs_daily.json        # Daily cost metrics
│
├── 🛠️ Automation & Setup
│   └── install-terraform.ps1   # Automated Terraform installation
│
├── 📊 Reports & Analysis
│   └── rds_metrics_query.json  # RDS performance metrics
│
└── 📚 Documentation
    └── docs/               # Comprehensive project documentation
```

## 🚀 Quick Start

### Prerequisites
- Windows PowerShell 5.1+ or PowerShell 7+
- Git installed and configured
- AWS account with appropriate permissions

### 1. Clone & Setup
```powershell
# Clone the repository
git clone https://github.com/agnisadhak/AWS_MGMT.git
cd AWS_MGMT

# Install Terraform (automated)
.\install-terraform.ps1
```

### 2. AWS Configuration
```powershell
# Configure AWS CLI (follow the interactive setup)
aws configure

# Verify connectivity
aws sts get-caller-identity
```

### 3. Initialize Infrastructure
```powershell
# Initialize Terraform
terraform init

# Review current state
terraform plan
```

### 4. Cost Analysis
```powershell
# Run cost analysis
.\check-aws-costs.ps1
```

## 📚 Documentation Hub

| Document | Purpose |
|----------|----------|
| [📖 **Documentation Index**](docs/README.md) | Primary entry point for all guides |
| [🎯 **Walkthrough**](docs/walkthrough.md) | Step-by-step infrastructure migration history |
| [📊 **Current Status**](docs/current-state.md) | Real-time tool and resource status |
| [💰 **Cost Analysis**](docs/cost-summary.md) | January 2026 spending analysis |
| [🔧 **AWS CLI Setup**](docs/aws-cli-setup.md) | AWS CLI installation and configuration |
| [⚖️ **Best Practices**](docs/dos-and-donts.md) | Security guidelines and operational standards |

## 🏗️ Managed Infrastructure

### Current Resources (as of Jan 2026)
- **EC2 Instances**: 2 instances (Web App Server, Supabase Server)
- **RDS Cluster**: Contact Manager Database (Auto-stop enabled)
- **VPCs**: Multiple VPC configurations
- **Security Groups**: Configured for web and database access

### Infrastructure Highlights
- ✅ Terraform state management
- ✅ Multi-AZ deployment capability
- ✅ Cost-optimized instance sizing
- ✅ Automated backup strategies

## 💡 Cost Optimization Features

- **📊 Daily Cost Tracking** - Automated cost report generation
- **🔄 RDS Auto-Stop** - Prevent unnecessary database costs
- **📈 Trend Analysis** - Identify cost anomalies and optimization opportunities
- **🎯 Resource Rightsizing** - Recommendations for instance optimization

## 🛡️ Security & Best Practices

### Security Features
- 🔒 **No Secrets in Code** - Proper AWS credential management
- 🚫 **State File Protection** - Terraform state excluded from version control
- 🔐 **Access Controls** - IAM best practices implementation
- 📝 **Audit Trail** - Comprehensive logging and monitoring

### Protected Files (Gitignored)
```bash
# Terraform sensitive files
*.tfstate
*.tfstate.*
*.tfvars

# AWS credentials
.aws/
*.pem
*.key

# Executables
*.exe
```

## 🔗 Repository Information

- **Repository**: https://github.com/agnisadhak/AWS_MGMT
- **Primary Branch**: `main`
- **Last Updated**: January 2026
- **Maintained By**: Aditya Sahoo (@agnisadhak)

## 🤝 Contributing

1. Review [Best Practices](docs/dos-and-donts.md) before making changes
2. Test all Terraform changes with `terraform plan` first
3. Update documentation for any infrastructure changes
4. Follow security guidelines for credential management

## 📞 Support

- 📖 Check the [Documentation Hub](docs/README.md)
- 🐛 Report issues via GitHub Issues
- 💬 Review [Project Activity](docs/project-activity.md) for recent changes

---

**🎯 Status**: ✅ **Active Management** | **Last Updated**: January 18, 2026

*AWS Infrastructure Management made simple, secure, and cost-effective.*