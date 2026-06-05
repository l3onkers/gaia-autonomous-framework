---
name: demeter-terraform-azure-base
description: 'Use when: demeter resolves a request to provision base Azure infrastructure (VNet, AKS, Azure SQL) using Terraform with strict state management in Azure Blob Storage.'
user-invocable: false
---

# Terraform Azure Baseline Provisioning

## Purpose
- Scaffolds a production-grade Azure infrastructure baseline.
- Enforces remote state locking in Azure Blob Storage.
- Creates a secure VNet, AKS cluster, and Azure SQL instance.

## Output Contract
- infrastructure/azure/main.tf
- infrastructure/azure/variables.tf
- infrastructure/azure/providers.tf
- infrastructure/azure/backend.tf

## Governance Rules
- MUST NOT use hardcoded credentials. Uses Azure Managed Identities.
- AKS MUST be integrated with Azure AD.
