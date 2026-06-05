---
name: aether-istio-ingress
description: 'Use when: aether resolves a request to expose a Kubernetes service using an Istio Gateway and VirtualService with mTLS.'
user-invocable: false
---

# Istio Ingress Configuration

## Purpose
- Scaffolds an Istio Gateway and VirtualService.
- Enforces strict mTLS at the mesh edge.

## Output Contract
- k8s/istio/gateway.yaml
- k8s/istio/virtualservice.yaml
"@ | Out-File -FilePath "d:\BONKERS\Documents\GitHub\IA-Agents\.github\skills\aether-istio-ingress\SKILL.md" -Encoding UTF8 -Force

@"
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: application-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 443
      name: https
      protocol: HTTPS
    tls:
      mode: SIMPLE
      credentialName: ingress-cert-secret
    hosts:
    - "api.example.com"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: application-vs
  namespace: default
spec:
  hosts:
  - "api.example.com"
  gateways:
  - istio-system/application-gateway
  http:
  - match:
    - uri:
        prefix: /api
    route:
    - destination:
        host: backend-service.default.svc.cluster.local
        port:
          number: 8080
