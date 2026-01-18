# AWS RDS Auto-Stop Automation Setup
# This script sets up an EventBridge rule and SSM Automation to keep your RDS cluster stopped.

$clusterId = "contact-manager-embedding-database"
$region = "ap-south-1"
$roleName = "RDS-Auto-Stop-Role-Mumbai"
$ruleName = "RDS-Auto-Stop-Rule-Mumbai"

Write-Host "🚀 Setting up RDS Auto-Stop for $clusterId in $region..." -ForegroundColor Cyan

# 1. Create IAM Role for SSM Automation
Write-Host "Creating IAM role..." -ForegroundColor Yellow
$trustPolicy = '{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": ["ssm.amazonaws.com", "events.amazonaws.com"]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}'
$trustPolicyFile = "trust-policy.json"
$trustPolicy | Out-File $trustPolicyFile -Encoding utf8

$role = aws iam create-role --role-name $roleName --assume-role-policy-document file://$trustPolicyFile --no-cli-pager | ConvertFrom-Json
Remove-Item $trustPolicyFile

# 2. Attach permissions to the role
Write-Host "Attaching permissions..." -ForegroundColor Yellow
$policy = '{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "rds:StopDBCluster",
        "rds:DescribeDBClusters",
        "ssm:StartAutomationExecution"
      ],
      "Resource": "*"
    }
  ]
}'
$policyFile = "rds-stop-policy.json"
$policy | Out-File $policyFile -Encoding utf8

aws iam put-role-policy --role-name $roleName --policy-name RDS-Stop-Permissions --policy-document file://$policyFile --no-cli-pager
Remove-Item $policyFile

Write-Host "Waiting for role to propagate..." -ForegroundColor Gray
Start-Sleep -Seconds 10

# 3. Create EventBridge Rule
Write-Host "Creating EventBridge rule..." -ForegroundColor Yellow
$eventPattern = @{
    source        = @("aws.rds")
    "detail-type" = @("RDS DB Cluster Event")
    detail        = @{
        EventID          = @("RDS-EVENT-0154")
        SourceIdentifier = @($clusterId)
    }
} | ConvertTo-Json -Compress

aws events put-rule --name $ruleName --event-pattern $eventPattern --state ENABLED --region $region --no-cli-pager

# 4. Set SSM Automation as Target
Write-Host "Setting SSM Automation target..." -ForegroundColor Yellow
$targetId = "StopRDSTarget"
# We'll use a custom SSM Automation document if AWS-StopRdsDbCluster isn't directly usable as a target
# Actually, we can use AWS-StopRdsDbCluster directly.
$targetInput = @{
    DbClusterIdentifier = @($clusterId)
} | ConvertTo-Json -Compress

aws events put-targets --rule $ruleName --targets "Id=$targetId,Arn=arn:aws:ssm:$region`:730335513045:automation-definition/AWS-StopRdsDbCluster,RoleArn=$($role.Role.Arn),Input='$targetInput'" --region $region --no-cli-pager

Write-Host "`n✅ SUCCESS! Automation setup complete." -ForegroundColor Green
Write-Host "--------------------------------------------------"
Write-Host "What this does:"
Write-Host "1. Listens for the 'Started' event (RDS-EVENT-0154) for your cluster."
Write-Host "2. Automatically triggers SSM Automation to stop the cluster."
Write-Host "3. This bypasses the 7-day automatic restart loop." -ForegroundColor White
Write-Host "--------------------------------------------------`n"
