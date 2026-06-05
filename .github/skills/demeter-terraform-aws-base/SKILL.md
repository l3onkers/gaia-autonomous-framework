---
name: demeter-terraform-aws-base
description: 'Use when: demeter resolves a request to provision base AWS infrastructure (VPC, EKS, RDS) using Terraform with strict state management and least-privilege IAM.'
user-invocable: false
---

# Terraform AWS Baseline Provisioning

## Purpose
- Scaffolds a production-grade AWS infrastructure baseline.
- Enforces S3/DynamoDB remote state locking.
- Creates a secure VPC, EKS cluster, and RDS instance.

## Output Contract
- infrastructure/aws/main.tf
- infrastructure/aws/variables.tf
- infrastructure/aws/providers.tf
- infrastructure/aws/backend.tf

## Governance Rules
- MUST NOT use hardcoded credentials in providers.tf.
- RDS MUST be encrypted with AWS KMS.
- EKS MUST use private endpoints or restrict public access via CIDR.

## Assets
- ssets/demeter-aws-base.checklist.md
- ssets/demeter-aws.main.tf.tpl.md
- ssets/demeter-aws.backend.tf.tpl.md
