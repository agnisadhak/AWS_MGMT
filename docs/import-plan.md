# Import EC2 Instances into Terraform - Implementation Plan

Plan to import existing AWS EC2 instances into Terraform for Infrastructure as Code management.

## Background

Found 2 existing EC2 instances in AWS account 730335513045:
1. **Web_App_Server** (i-0572e7b6a833d08fc) - m7g.xlarge, running
2. **Supabase_server-Email** (i-0dc408fa8eb153b9c) - t3.small, stopped

Both instances were previously provisioned (they have `ManagedBy: Terraform` tags) but are not currently tracked in the local Terraform state.

## User Review Required

> [!IMPORTANT]
> These instances have existing dependencies that will also need to be referenced:
> - **VPC**: vpc-0dfd392b4d4abb920 (Main) / vpc-01686c093725d3d5f (Web App)
> - **Subnet**: subnet-05fb19dff091cbf58 (Main) / subnet-0abd3bcfd167e91e7 (Web App)
> - **Security Group**: sg-07daeac337f456441 (coolify-sg) / sg-09905c7fdc2a43c67 (launch-wizard-1)
> - **IAM Instance Profile**: coolify-ec2-profile
> - **Key Pair**: coolify-keypair
> 
> The import will create resource blocks for the EC2 instances only. Dependencies will be referenced using data sources to avoid managing them directly.

> [!WARNING]
> After import, running `terraform apply` without changes is safe. However, any configuration drift between the actual instances and the Terraform code will be detected and may require manual reconciliation.

## Proposed Changes

### Infrastructure Components

#### [main.tf](../main.tf)
Main Terraform configuration with provider and backend settings.

#### [data.tf](../data.tf)
Data sources for existing AWS resources across different VPCs.

#### [ec2_instances.tf](../ec2_instances.tf)
EC2 instance resource blocks for both instances with lifecycle rules to prevent accidental replacements.

#### [outputs.tf](../outputs.tf)
Output values for instance IDs, IP addresses, and states.

---

## Verification Plan

### Automated Tests

1. **Terraform Import Commands**
   ```powershell
   # Import Web_App_Server
   terraform import aws_instance.web_app_server i-0572e7b6a833d08fc
   
   # Import Supabase_server-Email
   terraform import aws_instance.supabase_server i-0dc408fa8eb153b9c
   ```

2. **Verify No Changes Detected**
   ```powershell
   terraform plan
   ```
   Expected result: "No changes. Your infrastructure matches the configuration."

3. **Validate Configuration**
   ```powershell
   terraform validate
   ```
   Expected result: "Success! The configuration is valid."

### Manual Verification

After import, verify in AWS Console or via AWS CLI that:
- Instance states remain unchanged
- No unintended modifications were made
- Instances are queryable via Terraform state commands
