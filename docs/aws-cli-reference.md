# AWS CLI Quick Reference Guide

## Getting Started

```powershell
# Verify installation
aws --version

# Check current configuration
aws configure list

# View your AWS identity
aws sts get-caller-identity
```

---

## AWS S3 (Simple Storage Service)

```powershell
# List all buckets
aws s3 ls

# List contents of a bucket
aws s3 ls s3://bucket-name

# Create a new bucket
aws s3 mb s3://my-new-bucket

# Upload a file
aws s3 cp file.txt s3://bucket-name/

# Download a file
aws s3 cp s3://bucket-name/file.txt ./

# Sync a directory
aws s3 sync ./local-folder s3://bucket-name/remote-folder

# Remove a file
aws s3 rm s3://bucket-name/file.txt

# Remove a bucket (must be empty)
aws s3 rb s3://bucket-name
```

---

## AWS EC2 (Elastic Compute Cloud)

```powershell
# List all instances
aws ec2 describe-instances

# List instances in a table format
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,PublicIpAddress]' --output table

# Start an instance
aws ec2 start-instances --instance-ids i-1234567890abcdef0

# Stop an instance
aws ec2 stop-instances --instance-ids i-1234567890abcdef0

# Reboot an instance
aws ec2 reboot-instances --instance-ids i-1234567890abcdef0

# Terminate an instance
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0

# List available regions
aws ec2 describe-regions --output table

# List available AMIs (Amazon Machine Images)
aws ec2 describe-images --owners self amazon
```

---

## AWS Lambda

```powershell
# List all functions
aws lambda list-functions

# Get function details
aws lambda get-function --function-name my-function

# Invoke a function
aws lambda invoke --function-name my-function output.txt

# Update function code
aws lambda update-function-code --function-name my-function --zip-file fileb://function.zip

# Delete a function
aws lambda delete-function --function-name my-function
```

---

## AWS IAM (Identity and Access Management)

```powershell
# List IAM users
aws iam list-users

# List IAM groups
aws iam list-groups

# List IAM roles
aws iam list-roles

# List policies attached to a user
aws iam list-attached-user-policies --user-name username

# Create a new user
aws iam create-user --user-name new-user

# Create access key for a user
aws iam create-access-key --user-name username
```

---

## AWS CloudFormation

```powershell
# List all stacks
aws cloudformation list-stacks

# Describe a stack
aws cloudformation describe-stacks --stack-name my-stack

# Create a stack
aws cloudformation create-stack --stack-name my-stack --template-body file://template.yaml

# Update a stack
aws cloudformation update-stack --stack-name my-stack --template-body file://template.yaml

# Delete a stack
aws cloudformation delete-stack --stack-name my-stack
```

---

## AWS RDS (Relational Database Service)

```powershell
# List DB instances
aws rds describe-db-instances

# Create a DB snapshot
aws rds create-db-snapshot --db-instance-identifier mydb --db-snapshot-identifier mydb-snapshot

# List DB snapshots
aws rds describe-db-snapshots
```

---

## AWS CloudWatch (Monitoring)

```powershell
# List metrics
aws cloudwatch list-metrics

# Get metric statistics
aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization --dimensions Name=InstanceId,Value=i-1234567890abcdef0 --start-time 2026-01-18T00:00:00Z --end-time 2026-01-18T23:59:59Z --period 3600 --statistics Average
```

---

## AWS DynamoDB

```powershell
# List tables
aws dynamodb list-tables

# Describe a table
aws dynamodb describe-table --table-name my-table

# Scan a table (get all items)
aws dynamodb scan --table-name my-table

# Query a table
aws dynamodb query --table-name my-table --key-condition-expression "id = :id" --expression-attribute-values '{":id":{"S":"123"}}'
```

---

## Output Formats

```powershell
# JSON (default)
aws s3 ls --output json

# Table format
aws s3 ls --output table

# Text format
aws s3 ls --output text

# YAML format
aws s3 ls --output yaml
```

---

## Using Profiles

```powershell
# Configure a new profile
aws configure --profile myprofile

# Use a specific profile
aws s3 ls --profile myprofile

# Set default profile for current session
$env:AWS_PROFILE="myprofile"
```

---

## Helpful Options

```powershell
# Get help for any command
aws s3 help
aws ec2 help

# Dry run (test without executing)
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0 --dry-run

# Filter results with queries
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name]'

# Wait for a condition
aws ec2 wait instance-running --instance-ids i-1234567890abcdef0
```

---

## Configuration Files

- **Credentials:** `C:\Users\Aditya\.aws\credentials`
- **Config:** `C:\Users\Aditya\.aws\config`

---

## Quick Tips

✅ Use `--query` to filter results and reduce output  
✅ Use `--output table` for readable formatting  
✅ Use `--profile` to work with multiple AWS accounts  
✅ Use `--dry-run` to test commands before executing  
✅ Use `aws <service> help` to get detailed command documentation
