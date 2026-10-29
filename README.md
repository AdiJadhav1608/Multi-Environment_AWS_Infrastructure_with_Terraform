# Multi-Environment AWS Infrastructure with Terraform

## Overview

This project provisions AWS infrastructure for development, staging, and production using Terraform and reusable modules.

It demonstrates Infrastructure as Code (IaC), environment isolation, remote state management, EKS provisioning, IAM configuration, and EC2 Auto Scaling.

## Architecture

```text
                     Terraform
                         |
             +-----------+-----------+
             |           |           |
            Dev        Staging      Prod
             |           |           |
             +-----------+-----------+
                         |
                 Reusable Modules
                         |
       +---------+-------+-------+---------+
       |         |       |       |         |
      VPC       EKS     IAM   Security    EC2 ASG
                              Groups
                         |
                 S3 Remote State
                  with Locking
```

## Features

- Three separate environments managed using a shared codebase.
- Reusable Terraform modules for networking, EKS, IAM, security groups, and EC2 Auto Scaling.
- S3 remote state with versioning and native S3 state locking.
- Separate state keys for dev, staging, and production.
- EC2 launch templates and Auto Scaling groups.
- Environment-specific instance sizing and configuration.
- Resource tags to improve infrastructure organization and cost tracking.

## Technologies

- AWS
- Terraform
- Amazon VPC
- Amazon EKS
- Amazon EC2
- EC2 Auto Scaling
- AWS IAM
- Amazon S3
- Git and GitHub

## Prerequisites

Install Terraform and AWS CLI.

Verify the installations:

```bash
terraform version
aws --version
```

Configure your AWS credentials using a supported method:

```bash
aws configure
aws sts get-caller-identity
```

Use an AWS identity with the permissions required to create the configured resources. Never commit credentials to this repository.

## Project Structure

```text
backend-bootstrap/   Creates the S3 state bucket
modules/             Reusable Terraform modules
environments/dev/    Development environment
environments/staging/ Staging environment
environments/prod/   Production environment
```

## Deployment Guide

### 1. Create the remote-state bucket

From the project root:

```bash
cd backend-bootstrap
terraform init
terraform fmt
terraform validate
terraform plan -var="state_bucket_name=YOUR_UNIQUE_BUCKET_NAME"
terraform apply -var="state_bucket_name=YOUR_UNIQUE_BUCKET_NAME"
```

Choose a globally unique S3 bucket name. Keep the bootstrap state secure; it is initially stored locally.

### 2. Configure the environment backends

In each environment's `backend.tf`, replace the bucket placeholder with the bucket created in the previous step.

Each environment must use a separate state key:

- `dev/terraform.tfstate`
- `staging/terraform.tfstate`
- `prod/terraform.tfstate`

The examples use native S3 lockfiles, supported by Terraform 1.10 and newer.

### 3. Configure environment variables

Review each environment's `terraform.tfvars`.

Before deploying, verify:
- The AWS region and Availability Zones are valid.
- The Kubernetes version is supported by EKS in that region.
- The EKS API allowlist contains your approved public IP CIDR.
- The instance types and scaling capacities meet your requirements.

### 4. Deploy development

```bash
cd ../environments/dev
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Review the plan before applying.

### 5. Deploy staging and production

Repeat the workflow from the corresponding directory:

```bash
cd ../staging
terraform init
terraform validate
terraform plan
```

After reviewing the plan, run `terraform apply`.

For production, require an additional review and approval before applying changes.

## Useful Terraform Commands

```bash
terraform fmt -recursive
terraform validate
terraform plan
terraform output
terraform destroy
```

Run commands from the appropriate environment directory. `terraform destroy` removes the infrastructure managed by that environment and should only be used after reviewing the plan.

## Security Considerations

- Use least-privilege IAM policies.
- Keep S3 state buckets private and encrypted.
- Enable S3 versioning and state locking.
- Restrict EKS API access to approved IP ranges.
- Avoid exposing SSH or unnecessary service ports.
- Protect Terraform state because it can contain sensitive data.
- Never commit AWS credentials, local state files, or secrets to GitHub.

## Cost Optimization

EC2 instance sizing and Auto Scaling capacity can help control compute costs. The development configuration starts its EC2 Auto Scaling group at zero desired capacity, while EKS worker nodes remain enabled.

AWS charges may still apply for EKS, NAT Gateways, EC2 instances, EBS storage, load balancers, and data transfer.

The approximately 18% compute-cost reduction mentioned in the project description must be measured and verified against actual AWS billing data before being claimed as a result.

## Troubleshooting

**Backend initialization fails**
- Confirm the S3 bucket exists.
- Verify the bucket region and name.
- Check AWS credentials and IAM permissions.
- Ensure the Terraform version supports `use_lockfile`.

**EKS deployment fails**
- Confirm that the Kubernetes version is supported.
- Check service quotas, IAM permissions, subnet configuration, and Availability Zones.
- Verify that private subnets have suitable outbound connectivity.

**Unexpected Terraform plan**
- Review resource replacements and deletions.
- Check variable values and recent configuration changes.
- Do not apply unexpected production changes without investigation.

## Author

**Aditya Jadhav**

Beginner Cloud & DevOps Learner

GitHub: https://github.com/AdiJadhav1608

## Disclaimer

This repository is a learning project. Validate the configuration, security, compatibility, and AWS costs before deployment. It has not been independently verified against your AWS account.
