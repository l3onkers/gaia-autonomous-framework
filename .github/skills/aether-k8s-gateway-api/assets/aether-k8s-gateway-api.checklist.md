# Kubernetes Gateway API & ExternalDNS Compliance Checklist

- [ ] `GatewayClass` specifies the canonical AWS ALB controller name (`ingress.k8s.aws/alb`).
- [ ] `app-alb-gateway` and `platform-alb-gateway` are separated into distinct `Gateway` resources for blast-radius isolation.
- [ ] Both `Gateway` resources enforce TLS 1.3/1.2 security policies (`ELBSecurityPolicy-TLS13-1-2-2021-06`) on port 443.
- [ ] Domain names use parameterized variables (`${DOMAIN_NAME}`) rather than hardcoded vendor or diagram domains.
- [ ] `allowedRoutes` restricts cross-namespace route attachment using explicit namespace label selectors (`gateway-access: app` and `gateway-access: platform`).
- [ ] `ExternalDNS` is configured in the `external-dns` namespace using EKS Pod Identity and `--source=gateway-httproute`.
- [ ] No `TODO` or unimplemented placeholder comments exist in the generated YAML manifests.
