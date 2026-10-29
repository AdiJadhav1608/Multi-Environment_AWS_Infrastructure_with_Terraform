project_name = "aws-infrastructure"
environment  = "staging"
aws_region   = "ap-south-1"

vpc_cidr             = "10.20.0.0/16"
availability_zones   = ["ap-south-1a", "ap-south-1b"]
public_subnet_cidrs  = ["10.20.1.0/24", "10.20.2.0/24"]
private_subnet_cidrs = ["10.20.11.0/24", "10.20.12.0/24"]

# Replace with your public IP CIDR before creating the cluster.
eks_public_access_cidrs = ["203.0.113.10/32"]

kubernetes_version = "1.32"

eks_node_instance_type = "t3.small"
eks_node_min_size      = 1
eks_node_desired_size  = 1
eks_node_max_size      = 3

asg_instance_type    = "t3.micro"
asg_min_size         = 0
asg_desired_capacity = 0
asg_max_size         = 3