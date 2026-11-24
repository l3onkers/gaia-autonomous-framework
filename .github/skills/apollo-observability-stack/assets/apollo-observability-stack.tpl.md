# Three-Pillar Kubernetes Observability Stack Template

```yaml
# k8s/observability/monitoring/prometheus-grafana-alertmanager.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: monitoring
  labels:
    gateway-access: platform
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: alertmanager-config
  namespace: monitoring
data:
  alertmanager.yml: |
    global:
      resolve_timeout: 5m
    route:
      group_by: ['alertname', 'namespace', 'service']
      group_wait: 30s
      group_interval: 5m
      repeat_interval: 4h
      receiver: 'slack-notifications'
    receivers:
      - name: 'slack-notifications'
        slack_configs:
          - api_url_file: '/etc/alertmanager/secrets/slack-webhook-url'
            channel: '#platform-alerts'
            send_resolved: true
            title: '[{{ .Status | toUpper }}] {{ .CommonLabels.alertname }}'
            text: '{{ range .Alerts }}*Summary:* {{ .Annotations.summary }}\n*Namespace:* {{ .Labels.namespace }}{{ end }}'
---
# k8s/observability/logging/eck-filebeat-elasticsearch-kibana.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: logging
  labels:
    gateway-access: platform
---
apiVersion: elasticsearch.k8s.elastic.co/v1
kind: Elasticsearch
metadata:
  name: boutique-es
  namespace: logging
spec:
  version: 8.15.0
  nodeSets:
    - name: default
      count: 1
      config:
        node.store.allow_mmap: false
      volumeClaimTemplates:
        - metadata:
            name: elasticsearch-data
          spec:
            accessModes:
              - ReadWriteOnce
            resources:
              requests:
                storage: 30Gi
            storageClassName: gp3
---
apiVersion: kibana.k8s.elastic.co/v1
kind: Kibana
metadata:
  name: boutique-kibana
  namespace: logging
spec:
  version: 8.15.0
  count: 1
  elasticsearchRef:
    name: boutique-es
---
# k8s/observability/tracing/jaeger-otlp.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: tracing
  labels:
    gateway-access: platform
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jaeger
  namespace: tracing
  labels:
    app: jaeger
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jaeger
  template:
    metadata:
      labels:
        app: jaeger
    spec:
      securityContext:
        runAsNonRoot: true
        runAsUser: 10001
      containers:
        - name: jaeger
          image: jaegertracing/all-in-one:1.60
          env:
            - name: COLLECTOR_OTLP_ENABLED
              value: "true"
          ports:
            - name: otlp-grpc
              containerPort: 4317
              protocol: TCP
            - name: otlp-http
              containerPort: 4318
              protocol: TCP
            - name: ui
              containerPort: 16686
              protocol: TCP
          resources:
            requests:
              cpu: 100m
              memory: 256Mi
            limits:
              cpu: 500m
              memory: 512Mi
---
apiVersion: v1
kind: Service
metadata:
  name: jaeger-collector
  namespace: tracing
spec:
  selector:
    app: jaeger
  ports:
    - name: otlp-grpc
      port: 4317
      targetPort: 4317
    - name: otlp-http
      port: 4318
      targetPort: 4318
    - name: ui
      port: 16686
      targetPort: 16686
```
