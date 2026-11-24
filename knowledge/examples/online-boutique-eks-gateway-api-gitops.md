# Few-Shot Reference: Online Boutique AWS EKS 1.34 Platform (Gateway API, Hybrid IAM, Argo CD & 3-Pillar Observability)

## 1. Architectural Context
- **Pattern**: Multi-layer cloud-native e-commerce platform (`Online Boutique`) deployed on AWS (`us-east-1`).
- **Agents Coordinated**: `GAIA` -> `DEMETER` (Layer 1 Terraform), `AETHER` (Layer 2 Gateway API & Add-ons), `ELEUTHIA` (Layer 3 Polyglot Microservices & HPAs), `APOLLO` (Layer 4 3-Pillar Observability & Layer 6 Portfolio Docs/ADRs), `HEPHAESTUS` (Layer 5 Monorepo CI Matrix + Argo CD Image Updater), `HADES` (Layer 6 Chaos Mesh), `ARTEMIS` (Layer 6 k6 + Playwright + Validation), `MINERVA` (Layer 6 Zero Trust Audit).
- **Skills Applied**:
  - `demeter-terraform-aws-base`
  - `aether-k8s-gateway-api`
  - `hephaestus-argocd-gitops`
  - `apollo-observability-stack`
  - `eleuthia-py-api`, `eleuthia-net-api`
  - `hades-chaos-mesh-experiment`, `artemis-k6-load-test`, `artemis-playwright-e2e`, `minerva-review`

---

## 2. Verified Implementation Blueprints

### 2.1 Hybrid EKS 1.34 IAM (IRSA + EKS Pod Identity)
```hcl
# EKS Pod Identity Association for EBS CSI Driver & ExternalDNS
resource "aws_eks_pod_identity_association" "external_dns" {
  cluster_name    = var.cluster_name
  namespace       = "external-dns"
  service_account = "external-dns"
  role_arn        = aws_iam_role.external_dns_pod_identity.arn
}
```

### 2.2 Dual-ALB Kubernetes Gateway API Perimeter (`app-alb-gateway` vs `platform-alb-gateway`)
```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: app-alb-gateway
  namespace: default
  annotations:
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
    alb.ingress.kubernetes.io/certificate-arn: "${ACM_CERTIFICATE_ARN}"
    alb.ingress.kubernetes.io/ssl-policy: ELBSecurityPolicy-TLS13-1-2-2021-06
spec:
  gatewayClassName: aws-alb-gateway-class
  listeners:
    - name: https
      protocol: HTTPS
      port: 443
      hostname: "shop.${DOMAIN_NAME}"
      tls:
        mode: Terminate
        certificateRefs:
          - kind: Secret
            name: acm-tls-secret
      allowedRoutes:
        namespaces:
          from: Selector
          selector:
            matchLabels:
              gateway-access: app
```

### 2.3 Pull-Based GitOps with Argo CD Image Updater
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: online-boutique-app
  namespace: argocd
  annotations:
    argocd-image-updater.argoproj.io/image-list: >-
      frontend=ghcr.io/${GITHUB_OWNER}/online-boutique-frontend,
      cartservice=ghcr.io/${GITHUB_OWNER}/online-boutique-cartservice,
      productcatalogservice=ghcr.io/${GITHUB_OWNER}/online-boutique-productcatalogservice,
      checkoutservice=ghcr.io/${GITHUB_OWNER}/online-boutique-checkoutservice
    argocd-image-updater.argoproj.io/write-back-method: argocd
spec:
  project: online-boutique-project
  source:
    repoURL: https://github.com/${GITHUB_OWNER}/online-boutique-aws-platform.git
    targetRevision: main
    path: k8s/boutique-app
  destination:
    server: https://kubernetes.default.svc
    namespace: boutique-app
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```
