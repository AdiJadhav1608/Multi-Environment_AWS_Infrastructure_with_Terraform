variable "name" {
  type        = string
  description = "Environment name prefix"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR allowed to reach HTTP"
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags"
  default     = {}
}