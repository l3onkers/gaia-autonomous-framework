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
- `k8s/istio/gateway.yaml`
- `k8s/istio/virtualservice.yaml`
