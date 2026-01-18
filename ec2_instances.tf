# Web App Server Instance
resource "aws_instance" "web_app_server" {
  ami           = "ami-0da3e3a52fe58bf67"
  instance_type = "m7g.xlarge"
  key_name      = "coolify-keypair"

  subnet_id                   = data.aws_subnet.web_app.id
  vpc_security_group_ids      = [data.aws_security_group.web_app.id]
  iam_instance_profile        = data.aws_iam_instance_profile.coolify.name
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 100
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = false
  }

  ebs_optimized = true
  monitoring    = false

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    instance_metadata_tags      = "disabled"
  }

  tags = {
    Name        = "Web_App_Server"
    ManagedBy   = "Terraform"
    Environment = "production"
    Project     = "Coolify Hosting Platform"
  }

  lifecycle {
    ignore_changes = [
      ami,  # Prevent replacement if AMI is updated
    ]
  }
}

# Supabase Server Instance
resource "aws_instance" "supabase_server" {
  ami           = "ami-0030e4319cbf4dbf2"
  instance_type = "t3.small"
  key_name      = "coolify-keypair"

  subnet_id                   = data.aws_subnet.supabase.id
  vpc_security_group_ids      = [data.aws_security_group.coolify.id]
  iam_instance_profile        = data.aws_iam_instance_profile.coolify.name
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = false
  }

  ebs_optimized = true
  monitoring    = false

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "disabled"
  }

  tags = {
    Name        = "Supabase_server-Email"
    ManagedBy   = "Terraform"
    Environment = "production"
    Project     = "Coolify Hosting Platform"
  }

  lifecycle {
    ignore_changes = [
      ami,  # Prevent replacement if AMI is updated
    ]
  }
}
