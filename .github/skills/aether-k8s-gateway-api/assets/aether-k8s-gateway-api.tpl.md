# Kubernetes Gateway API (AWS ALB + ExternalDNS) Template

```yaml
# k8s/networking/gateway-class.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: aws-alb-gateway-class
spec:
  controllerName: ingress.k8s.aws/alb
---
# k8s/networking/gateways.yaml
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
      hostname: "app.${DOMAIN_NAME}"
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
---
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: platform-alb-gateway
  namespace: default
  annotations:
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
    alb.ingress.kubernetes.io/certificate-arn: "${ACM_CERTIFICATE_ARN}"
    alb.ingress.kubernetes.io/ssl-policy: ELBSecurityPolicy-TLS13-1-2-2021-06
spec:
  gatewayClassName: aws-alb-gateway-class
  listeners:
    - name: https-platform
      protocol: HTTPS
      port: 443
      hostname: "*.${DOMAIN_NAME}"
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
              gateway-access: platform
---
# k8s/networking/httproutes.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: web-frontend-route
  namespace: app-workloads
spec:
  parentRefs:
    - name: app-alb-gateway
      namespace: default
      sectionName: https
  hostnames:
    - "app.${DOMAIN_NAME}"
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /
      backendRefs:
        - name: frontend
          port: 80
```
