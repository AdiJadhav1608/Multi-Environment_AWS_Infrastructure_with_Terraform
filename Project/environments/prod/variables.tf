variable "project_name" {
  description = "Project name used in AWS resource names"
  type        = string
  default     = "aws-infrastructure"
}

variable "environment" {
  description = "Environment name"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "VPC IPv4 CIDR"
  type        = string
}

variable "availability_zones" {
  description = "Two Availability Zones in the selected region"
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) == 2
    error_message = "Provide exactly two Availability Zones."
  }
}

variable "public_subnet_cidrs" {
  description = "Two public subnet CIDRs"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Provide exactly two public subnet CIDRs."
  }
}

variable "private_subnet_cidrs" {
  description = "Two private subnet CIDRs"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == 2
    error_message = "Provide exactly two private subnet CIDRs."
  }
}

variable "eks_public_access_cidrs" {
  description = "Your public IP CIDR(s) allowed to access the EKS API"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "EKS-supported Kubernetes version for the selected region"
  type        = string
}

variable "eks_node_instance_type" {
  description = "EKS worker node instance type"
  type        = string
}

variable "eks_node_min_size" {
  type        = number
  description = "Minimum EKS worker node count"
}

variable "eks_node_desired_size" {
  type        = number
  description = "Desired EKS worker node count"
}

variable "eks_node_max_size" {
  type        = number
  description = "Maximum EKS worker node count"
}

variable "asg_instance_type" {
  description = "EC2 Auto Scaling instance type"
  type        = string
}

variable "asg_min_size" {
  type        = number
  description = "Minimum EC2 Auto Scaling capacity"
}

variable "asg_desired_capacity" {
  type        = number
  description = "Desired EC2 Auto Scaling capacity"
}

variable "asg_max_size" {
  type        = number
  description = "Maximum EC2 Auto Scaling capacity"
}