variable "name" {
  type        = string
  description = "Environment name prefix"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for EC2 instances"
}

variable "security_group_id" {
  type        = string
  description = "EC2 security group ID"
}

variable "instance_profile_name" {
  type        = string
  description = "EC2 IAM instance profile"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "min_size" {
  type        = number
  description = "Minimum Auto Scaling capacity"
  default     = 0
}

variable "desired_capacity" {
  type        = number
  description = "Desired Auto Scaling capacity"
  default     = 0
}

variable "max_size" {
  type        = number
  description = "Maximum Auto Scaling capacity"
  default     = 2
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags"
  default     = {}
}