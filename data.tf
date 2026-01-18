# Data sources for existing AWS resources
# These are referenced by the EC2 instances but not managed by this Terraform configuration

# Web App Server VPC and Subnet
data "aws_vpc" "web_app" {
  id = "vpc-01686c093725d3d5f"
}

data "aws_subnet" "web_app" {
  id = "subnet-0abd3bcfd167e91e7"
}

data "aws_security_group" "web_app" {
  id = "sg-09905c7fdc2a43c67"  # launch-wizard-1
}

# Supabase Server VPC and Subnet
data "aws_vpc" "supabase" {
  id = "vpc-0dfd392b4d4abb920"
}

data "aws_subnet" "supabase" {
  id = "subnet-05fb19dff091cbf58"
}

data "aws_security_group" "coolify" {
  id = "sg-07daeac337f456441"
}

# Shared IAM Instance Profile
data "aws_iam_instance_profile" "coolify" {
  name = "coolify-ec2-profile"
}
