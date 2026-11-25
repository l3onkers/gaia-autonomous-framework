---
name: aether-k8s-gateway-api
description: 'Use when: aether resolves a request to expose Kubernetes services using the Kubernetes Gateway API (GatewayClass, Gateway, HTTPRoute) backed by AWS ALB and ExternalDNS.'
user-invocable: true
---

# Kubernetes Gateway API with AWS ALB & ExternalDNS Skill

## Purpose
- This skill owns the deterministic generation of Kubernetes Gateway API resources (`GatewayClass`, `Gateway`, `HTTPRoute`) backed by the AWS Load Balancer Controller and integrated with ExternalDNS and AWS Certificate Manager (ACM).
- This skill separates public application traffic (`app-alb-gateway`) from internal or administrative platform traffic (`platform-alb-gateway`) over HTTPS 443.
- This skill stays strictly within perimeter routing and Gateway API manifests; it does not provision VPC subnets or IAM roles (which belong to `demeter`).

## Output Contract
- `k8s/networking/gateway-class.yaml`
- `k8s/networking/gateways.yaml`
- `k8s/networking/httproutes.yaml`
- `k8s/networking/external-dns.yaml`

If the target hostname pattern or certificate configuration is unresolvable, use parameterized domain placeholders (`${DOMAIN_NAME}`) and document the required environment substitution.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned template asset: `./assets/aether-k8s-gateway-api.tpl.md`
- Owned checklist asset: `./assets/aether-k8s-gateway-api.checklist.md`

## When to Use
- `aether` resolves an ingress or perimeter routing request that specifies Kubernetes Gateway API (`Gateway`, `HTTPRoute`) instead of legacy `Ingress` resources.
- The architecture requires dedicated application and platform ALB Gateways terminating HTTPS 443 with ACM certificates and automated Route 53 DNS synchronization via ExternalDNS with EKS Pod Identity.

## Procedure
1. Load `./assets/aether-k8s-gateway-api.tpl.md` and `./assets/aether-k8s-gateway-api.checklist.md`.
2. Ensure domain names are parameterized (e.g., `${DOMAIN_NAME}`, default `app.example.com`) and never hardcoded to vendor or personal domains.
3. Define the `GatewayClass` bound to `aws-alb` controller class.
4. Define `app-alb-gateway` and `platform-alb-gateway` in the target namespace with HTTPS 443 listeners, TLS termination via ACM certificate ARN parameter, and HTTP 80 to HTTPS 443 redirect rules.
5. Define `HTTPRoute` resources mapping hostnames (`app.${DOMAIN_NAME}`, `argocd.${DOMAIN_NAME}`, `grafana.${DOMAIN_NAME}`, `kibana.${DOMAIN_NAME}`, `jaeger.${DOMAIN_NAME}`) to their corresponding backend Kubernetes `Service` endpoints.
6. Define the `external-dns` deployment in the `external-dns` namespace configured for EKS Pod Identity and Gateway API sources (`--source=gateway-httproute`).
7. Validate all generated manifests against `./assets/aether-k8s-gateway-api.checklist.md`.

## Validation and Compliance Decision Rules
- Every `Gateway` resource MUST enforce HTTPS on port 443 with a valid ACM certificate ARN reference.
- Plaintext HTTP listeners without a 301/302 redirect `HTTPRoute` filter are strictly prohibited.
- `HTTPRoute` resources MUST explicitly declare `parentRefs` pointing to either `app-alb-gateway` or `platform-alb-gateway` and restrict `allowedRoutes` by namespace policy.
- ExternalDNS MUST run with non-root security context and least-privilege EKS Pod Identity service account.
