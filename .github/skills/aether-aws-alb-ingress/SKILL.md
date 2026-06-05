---
name: aether-aws-alb-ingress
description: 'Use when: aether resolves a request to expose a Kubernetes service via AWS Application Load Balancer (ALB) using the AWS Load Balancer Controller.'
user-invocable: false
---

# AWS ALB Ingress Configuration

## Purpose
- Scaffolds an AWS ALB Ingress manifest.
- Configures TLS termination via ACM certificates.
- Sets up WAF integration.

## Output Contract
- k8s/ingress.yaml

## Governance Rules
- MUST NOT use HTTP without a redirect to HTTPS.
- MUST bind a valid ACM certificate via annotations.

## Assets
- ssets/aether-alb.checklist.md
- ssets/aether-alb.ingress.yaml.tpl.md
