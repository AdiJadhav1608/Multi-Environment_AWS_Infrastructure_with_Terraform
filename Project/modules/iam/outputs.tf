output "instance_profile_name" {
  value       = aws_iam_instance_profile.ec2.name
  description = "EC2 instance profile name"
}

output "ec2_role_arn" {
  value       = aws_iam_role.ec2.arn
  description = "EC2 IAM role ARN"
}