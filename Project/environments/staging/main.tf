provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Multi-Environment-Terraform"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

locals {
  name = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name                 = local.name
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = local.common_tags
}

module "iam" {
  source = "../../modules/iam"

  name = local.name
  tags = local.common_tags
}

module "security_groups" {
  source = "../../modules/security-groups"

  name     = local.name
  vpc_id   = module.vpc.vpc_id
  vpc_cidr = var.vpc_cidr
  tags     = local.common_tags
}

module "ec2_asg" {
  source = "../../modules/ec2-asg"

  name                 = local.name
  private_subnet_ids   = module.vpc.private_subnet_ids
  security_group_id    = module.security_groups.ec2_security_group_id
  instance_profile_name = module.iam.instance_profile_name

  instance_type    = var.asg_instance_type
  min_size         = var.asg_min_size
  desired_capacity = var.asg_desired_capacity
  max_size         = var.asg_max_size

  tags = local.common_tags
}

module "eks" {
  source = "../../modules/eks"

  cluster_name        = "${local.name}-eks"
  kubernetes_version  = var.kubernetes_version
  private_subnet_ids  = module.vpc.private_subnet_ids
  public_access_cidrs = var.eks_public_access_cidrs

  node_instance_type = var.eks_node_instance_type
  node_min_size      = var.eks_node_min_size
  node_desired_size  = var.eks_node_desired_size
  node_max_size      = var.eks_node_max_size

  tags = local.common_tags
}