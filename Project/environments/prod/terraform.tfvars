project_name = "aws-infrastructure"
environment  = "prod"
aws_region   = "ap-south-1"

vpc_cidr             = "10.30.0.0/16"
availability_zones   = ["ap-south-1a", "ap-south-1b"]
public_subnet_cidrs  = ["10.30.1.0/24", "10.30.2.0/24"]
private_subnet_cidrs = ["10.30.11.0/24", "10.30.12.0/24"]

# Replace with approved administrator public IP CIDRs before deployment.
eks_public_access_cidrs = ["203.0.113.10/32"]

kubernetes_version = "1.32"

eks_node_instance_type = "t3.medium"
eks_node_min_size      = 2
eks_node_desired_size  = 2
eks_node_max_size      = 4

asg_instance_type    = "t3.small"
asg_min_size         = 1
asg_desired_capacity = 1
asg_max_size         = 4