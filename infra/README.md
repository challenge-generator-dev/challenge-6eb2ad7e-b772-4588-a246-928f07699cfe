# Terraform AWS Infrastructure

## Overview
This repository contains Terraform configurations to provision AWS infrastructure for a serverless application using Lambda and API Gateway.

## Structure
```
.
├── environments/          # Environment-specific configurations
│   ├── dev/               # Development environment
│   │   └── terraform.tfvars
│   ├── main.tf            # Root module entry point
│   └── variables.tf       # Input variables for root module
├── modules/               # Reusable Terraform modules
│   ├── api_gateway/       # API Gateway module
│   └── lambda/            # Lambda function module
└── tests/                 # Test configurations
    └── acceptance/        # Acceptance tests
        ├── f1.tftest.hcl
        └── f2.tftest.hcl
```

## Prerequisites
- Terraform 1.7.5
- AWS CLI configured with appropriate credentials
- AWS account with permissions to create Lambda, API Gateway, and IAM resources

## Setup
1. Initialize Terraform:
```bash
terraform init
```

2. Review the execution plan for the development environment:
```bash
terraform plan -var-file=environments/dev/terraform.tfvars
```

3. Apply the configuration:
```bash
terraform apply -var-file=environments/dev/terraform.tfvars
```

## Testing
Run acceptance tests:
```bash
terraform test
```

## Validation
After applying the configuration, verify:
- Lambda function is created in AWS Console
- API Gateway endpoint is accessible
- Resources match the expected configuration in `terraform.tfvars`

## Cleanup
Destroy provisioned resources:
```bash
terraform destroy -var-file=environments/dev/terraform.tfvars
```