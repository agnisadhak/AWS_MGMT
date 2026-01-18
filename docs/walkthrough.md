# EC2 Instance Import to Terraform - Walkthrough

Successfully imported 2 existing EC2 instances into Terraform for Infrastructure as Code management.

---

## ✅ Completed Tasks

### 1. Instance Discovery

Found 2 EC2 instances in AWS account 730335513045:

| Instance Name | Instance ID | Type | State | Public IP |
|--------------|-------------|------|-------|-----------|
| Web_App_Server | i-0572e7b6a833d08fc | m7g.xlarge | running | 3.232.162.36 |
| Supabase_server-Email | i-0dc408fa8eb153b9c | t3.small | stopped | 54.163.241.161 |

### 2. Infrastructure Configuration

Instances are deployed across different VPCs:

**Web_App_Server**:
- VPC: `vpc-01686c093725d3d5f`
- Subnet: `subnet-0abd3bcfd167e91e7`
- Security Group: `sg-09905c7fdc2a43c67` (launch-wizard-1)
- Root Volume: 100GB gp2
- IAM Profile: coolify-ec2-profile

**Supabase_server-Email**:
- VPC: `vpc-0dfd392b4d4abb920`
- Subnet: `subnet-05fb19dff091cbf58`
- Security Group: `sg-07daeac337f456441` (coolify-sg)
- Root Volume: 30GB gp3
- IAM Profile: coolify-ec2-profile

### 3. Terraform Configuration Files Created

#### [main.tf](../main.tf)
- Terraform and AWS provider configuration
- Region: us-east-1
- Terraform version: >= 1.14.0
- AWS provider version: ~> 5.0

#### [data.tf](../data.tf)
- Data sources for existing infrastructure dependencies
- Separate VPC/subnet data sources for each instance
- Security group references
- IAM instance profile reference

#### [ec2_instances.tf](../ec2_instances.tf)
- Complete resource definitions for both EC2 instances
- Includes all configuration: networking, storage, tags, metadata options
- Lifecycle rules to prevent unintended AMI replacements

#### [outputs.tf](../outputs.tf)
- Outputs for instance IDs, IP addresses, and states
- Useful for referencing instances in other Terraform configurations

### 4. Import Process

Successfully imported both instances into Terraform state:

```powershell
# Web App Server import
terraform import aws_instance.web_app_server i-0572e7b6a833d08fc
✅ Import successful!

# Supabase Server import  
terraform import aws_instance.supabase_server i-0dc408fa8eb153b9c
✅ Import successful!
```

---

## 📊 Current State

**Terraform State**: Both instances are now tracked in `terraform.tfstate`

**Files in Project**:
- `main.tf` - Provider configuration
- `data.tf` - Data sources for dependencies
- `ec2_instances.tf` - EC2 instance resources
- `outputs.tf` - Output definitions
- `.terraform/` - Provider plugins
- `.terraform.lock.hcl` - Provider version lock
- `terraform.tfstate` - Current infrastructure state

---

## 🔧 Managing Your Infrastructure

### Viewing Current State

```powershell
# View all resources in state
terraform state list

# View specific instance details
terraform state show aws_instance.web_app_server
terraform state show aws_instance.supabase_server

# View outputs
terraform output
```

### Making Changes

To modify your infrastructure:

1. Edit the relevant `.tf` files
2. Preview changes:
   ```powershell
   terraform plan
   ```
3. Apply changes:
   ```powershell
   terraform apply
   ```

### Important Notes

> [!IMPORTANT]
> **State File Protection**: The `terraform.tfstate` file contains sensitive information and the current state of your infrastructure. 
> - Never commit this file to version control
> - Consider using [remote state](https://developer.hashicorp.com/terraform/language/state/remote) for team collaboration
> - Backup this file regularly

> [!WARNING]
> **EC2 Instance Changes**: Some changes to EC2 instances will force replacement (creating a new instance and destroying the old one):
> - Changing `ami`
> - Changing `subnet_id`
> - Changing `availability_zone`
> 
> Always review `terraform plan` output carefully before applying changes.

> [!TIP]
> **Best Practices**:
> - Run `terraform plan` before every `terraform apply`
> - Use `terraform fmt` to format your code consistently
> - Use `terraform validate` to check syntax
> - Tag all resources appropriately for cost tracking and organization

---

## 🎯 Next Steps

Now that your instances are managed by Terraform, you can:

1. **Add More Resources**: Import or create additional AWS resources (RDS, S3, Load Balancers, etc.)
2. **Organize Code**: Split into modules for better organization
3. **Remote State**: Set up S3 + DynamoDB backend for state management
4. **CI/CD Integration**: Automate Terraform deployments
5. **Cost Optimization**: Use Terraform to analyze and optimize resource usage

---

## 📝 Reference Commands

```powershell
# Initialize (after adding new providers)
terraform init

# Format code
terraform fmt

# Validate configuration
terraform validate

# Plan changes
terraform plan

# Apply changes  
terraform apply

# Destroy resources (use with extreme caution!)
terraform destroy

# View state
terraform state list
terraform state show <resource>

# View outputs
terraform output
```

---

## ✨ Summary

Your EC2 instances are now fully managed by Terraform! You can safely make changes to your infrastructure using code, with the confidence that Terraform will show you exactly what will change before applying any modifications.

Both instances (`Web_App_Server` and `Supabase_server-Email`) are tracked in Terraform state and ready for management through Infrastructure as Code.
