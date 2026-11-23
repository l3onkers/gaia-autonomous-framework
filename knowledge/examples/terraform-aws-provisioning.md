# Few-Shot Example: Provisioning Base AWS Infrastructure

**Agent:** DEMETER  
**Skills Resolved:** `demeter-terraform-aws-base`

## Scenario
The user requests a production-grade VPC and EKS cluster base on AWS.

## Execution Pattern
1. **State Isolation:** Configure `backend.tf` pointing to S3 with DynamoDB state locking:
   ```hcl
   terraform {
     backend "s3" {
       bucket         = "gaia-terraform-state-${var.environment}"
       key            = "core/terraform.tfstate"
       region         = "eu-west-1"
       dynamodb_table = "gaia-terraform-locks"
       encrypt        = true
     }
   }
   ```
2. **Network Topology:** Define public and private subnets across 3 availability zones with NAT Gateways.
3. **Zero Trust IAM:** Attach least-privilege IAM roles; forbid wildcard `*` actions on sensitive resources.
4. **Validation:** Generate `terraform validate` and `tflint` compliance checklist.
