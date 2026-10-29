variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "kubernetes_version" {
  type        = string
  description = "Supported Kubernetes version for EKS"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for EKS"
}

variable "public_access_cidrs" {
  type        = list(string)
  description = "CIDR ranges permitted to access the public EKS API endpoint"
}

variable "node_instance_type" {
  type        = string
  description = "Managed node group instance type"
  default     = "t3.small"
}

variable "node_min_size" {
  type        = number
  default     = 1
}

variable "node_desired_size" {
  type        = number
  default     = 1
}

variable "node_max_size" {
  type        = number
  default     = 2
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags"
  default     = {}
}