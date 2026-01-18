# EC2 Instance Outputs

output "web_app_server_id" {
  description = "ID of the Web App Server instance"
  value       = aws_instance.web_app_server.id
}

output "web_app_server_public_ip" {
  description = "Public IP of the Web App Server"
  value       = aws_instance.web_app_server.public_ip
}

output "web_app_server_private_ip" {
  description = "Private IP of the Web App Server"
  value       = aws_instance.web_app_server.private_ip
}

output "web_app_server_state" {
  description = "Current state of the Web App Server"
  value       = aws_instance.web_app_server.instance_state
}

output "supabase_server_id" {
  description = "ID of the Supabase Server instance"
  value       = aws_instance.supabase_server.id
}

output "supabase_server_public_ip" {
  description = "Public IP of the Supabase Server"
  value       = aws_instance.supabase_server.public_ip
}

output "supabase_server_private_ip" {
  description = "Private IP of the Supabase Server"
  value       = aws_instance.supabase_server.private_ip
}

output "supabase_server_state" {
  description = "Current state of the Supabase Server"
  value       = aws_instance.supabase_server.instance_state
}

output "all_instance_ids" {
  description = "List of all EC2 instance IDs"
  value = [
    aws_instance.web_app_server.id,
    aws_instance.supabase_server.id
  ]
}
