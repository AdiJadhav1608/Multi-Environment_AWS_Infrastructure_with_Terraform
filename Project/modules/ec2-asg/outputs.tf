output "autoscaling_group_name" {
  value       = aws_autoscaling_group.this.name
  description = "Auto Scaling group name"
}

output "launch_template_id" {
  value       = aws_launch_template.this.id
  description = "EC2 launch template ID"
}