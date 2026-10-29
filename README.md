# Multi-Environment AWS Infrastructure with Terraform

## Overview

This project demonstrates how to provision and manage AWS infrastructure for **development, staging, and production environments** using Terraform.

It uses reusable Terraform modules to reduce duplication, remote state storage to support team workflows, and EC2 Auto Scaling to help match compute capacity to application demand.

## Architecture

```text
                    Terraform
                        |
          +-------------+-------------+
          |             |             |
         Dev          Staging         Prod
          |             |             |
          +-------------+-------------+
                        |
               Reusable Modules
                        |
       +----------------+----------------+
       |        |        |       |       |
      VPC      EKS      IAM  Security   EC2 ASG
                              Groups
                        |
                 AWS Infrastructure

Terraform State:
S3 Remote Backend + State Locking
```

## Features

- **Multi-environment infrastructure:** Manage dev, staging, and production using one codebase.
- **Reusable Terraform modules:** Separate modules for VPC, EKS, IAM, security groups, and EC2 Auto Scaling.
- **Remote state:** Store Terraform state in an S3 bucket.
- **State locking:** Configure locking to prevent conflicting Terraform operations. The implementation must match the selected Terraform version and backend configuration.
- **EC2 Auto Scaling:** Configure minimum, desired, and maximum instance capacity.
- **Infrastructure as Code:** Provision resources consistently and track configuration changes in Git.
- **Environment-specific settings:** Maintain separate variables for each environment.

## Technologies Used

- AWS
- Terraform
- Amazon VPC
- Amazon EKS
- AWS IAM
- Amazon EC2
- EC2 Auto Scaling
- Amazon S3
- DynamoDB, if using the legacy S3 backend locking approach
- Git and GitHub

## Prerequisites

Install and configure:

1. Terraform
2. AWS CLI
3. Git
4. An AWS account with permissions to create the required infrastructure

Verify the installations:

```bash
terraform version
aws --version
git --version
```

Configure AWS credentials using an AWS CLI profile or another supported credential provider:

```bash
aws configure
aws sts get-caller-identity
```

Do not commit AWS access keys, secret keys, state files, or other credentials to GitHub.

## Repository Structure

```text
backend-bootstrap/   Creates the remote-state resources
modules/             Reusable infrastructure modules
environments/dev/    Development configuration
environments/staging/ Staging configuration
environments/prod/   Production configuration
```

## Setup and Execution

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/Multi-Environment_AWS_Infrastructure_with_Terraform.git
cd Multi-Environment_AWS_Infrastructure_with_Terraform
```

Replace `YOUR_USERNAME` with your GitHub username and update the repository URL if your repository name differs.

### 2. Create the remote-state resources

Review the files under `backend-bootstrap/` and configure unique names for the S3 bucket and any locking resources.

Run:

```bash
cd backend-bootstrap
terraform init
terraform fmt -recursive
terraform validate
terraform plan
```

Review the plan before applying:

```bash
terraform apply
```

The bootstrap configuration must be applied before the environment backends can use the bucket. Keep the bootstrap state secure as well.

**Locking compatibility:** DynamoDB-based locking is the legacy approach for the S3 backend. Recent Terraform versions support native S3 lockfiles through `use_lockfile`. Configure the backend according to the Terraform version you use; do not assume both locking approaches are interchangeable.

### 3. Deploy the development environment

From the repository root:

```bash
cd environments/dev
terraform init
terraform fmt -recursive
terraform validate
terraform plan
```

Inspect the proposed resources, estimated costs, security rules, and networking before applying:

```bash
terraform apply
```

### 4. Deploy staging and production

Repeat the same workflow from the relevant directories:

```bash
cd ../staging
terraform init
terraform validate
terraform plan
```

After reviewing the plan:

```bash
terraform apply
```

For production, use a formal review and approval process before applying changes. Configure a separate state key for each environment so state remains isolated.

## Managing Infrastructure

### View the Terraform plan

```bash
terraform plan
```

### Apply reviewed changes

```bash
terraform apply
```

### Inspect outputs

```bash
terraform output
```

### Destroy resources

Run this only in the environment you intentionally want to remove:

```bash
terraform destroy
```

Review the destroy plan carefully. Deleting production infrastructure can cause outages or data loss.

## Security Best Practices

- Use least-privilege IAM policies.
- Avoid exposing EKS endpoints or EC2 SSH access to the entire internet.
- Restrict security-group ingress to required sources and ports.
- Store Terraform state remotely with encryption and tightly controlled access.
- Use separate state keys and, where appropriate, separate AWS accounts for each environment.
- Keep credentials out of source control.
- Review `terraform plan` before applying changes.
- Configure monitoring, backups, and logging for production workloads.

## Cost Optimization

The EC2 Auto Scaling module allows you to define minimum, desired, and maximum capacity. Right-sizing instances and adjusting scaling policies can reduce unnecessary compute usage.

The approximately **18% compute-cost reduction** is a target project outcome, not a verified result. Measure the actual change using AWS billing or Cost Explorer and compare equivalent workloads over equivalent time periods.

EKS control planes, NAT gateways, load balancers, EC2 instances, storage, and data transfer may incur charges. Destroy lab resources when you no longer need them.

## Troubleshooting

**Backend initialization fails**

- Verify the S3 bucket exists and is in the configured region.
- Check AWS credentials and IAM permissions.
- Verify that the backend key is unique for the environment.
- Confirm that the locking configuration matches your Terraform version.

**Terraform reports missing variables**

- Review `variables.tf` and the relevant `terraform.tfvars`.
- Supply all required values without committing secrets.

**EKS nodes cannot reach required services**

- Check route tables, DNS, security groups, NAT gateways, or VPC endpoints.
- Verify that the node subnets have the network connectivity required for their configuration.

**Terraform plans unexpected replacements**

- Review the plan carefully and check for changes to immutable AWS resource attributes.
- Do not apply unexpected production replacements without investigating their impact.

## Learning Outcomes

- Organizing Terraform code with reusable modules
- Managing multiple AWS environments from a single codebase
- Configuring remote state and state locking
- Provisioning VPC and EKS infrastructure
- Applying IAM and security-group best practices
- Managing EC2 Auto Scaling and infrastructure costs
- Following a review-first Infrastructure as Code workflow

## Author

**Aditya Jadhav**  
Beginner Cloud & DevOps Learner

GitHub: https://github.com/AdiJadhav1608

---

**Note:** Review the module code, backend settings, AWS permissions, and costs before deploying. This repository is a learning project and should not be considered production-ready until it has been tested and security-reviewed.