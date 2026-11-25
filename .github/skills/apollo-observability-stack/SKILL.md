---
name: apollo-observability-stack
description: 'Use when: apollo resolves a request to configure a 3-pillar Kubernetes observability stack comprising Prometheus/Grafana/Alertmanager (with Slack routing), ECK (Filebeat, Elasticsearch, Kibana), and Jaeger OTLP gRPC (:4317) distributed tracing.'
user-invocable: true
---

# Three-Pillar Kubernetes Observability Stack Skill

## Purpose
- This skill owns the declarative Kubernetes configuration for full-spectrum observability across three isolated namespaces: `monitoring` (metrics & alerting), `logging` (centralized log aggregation), and `tracing` (distributed OpenTelemetry tracing).
- This skill configures Prometheus, Grafana, and Alertmanager (with Slack webhook notifications) in `monitoring`; Elastic Cloud on Kubernetes (`ECK`) with Filebeat, Elasticsearch, and Kibana in `logging`; and Jaeger with OTLP gRPC collector on port `4317` in `tracing`.
- This skill stays within observability manifests, alert routing, and telemetry collector definitions.

## Output Contract
- `k8s/observability/monitoring/prometheus-grafana-alertmanager.yaml`
- `k8s/observability/logging/eck-filebeat-elasticsearch-kibana.yaml`
- `k8s/observability/tracing/jaeger-otlp.yaml`

If the Slack webhook URL or storage class is not explicitly specified, bind Alertmanager to a Kubernetes Secret reference (`alertmanager-slack-secret`) and default persistent volumes to `gp3`.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned template asset: `./assets/apollo-observability-stack.tpl.md`
- Owned checklist asset: `./assets/apollo-observability-stack.checklist.md`

## When to Use
- `apollo` resolves an observability or platform telemetry request requiring metrics (`Prometheus`, `Grafana`, `Alertmanager` -> `Slack`), logs (`ECK`, `Filebeat`, `Elasticsearch`, `Kibana`), and distributed tracing (`Jaeger` OTLP gRPC `:4317`).

## Procedure
1. Load `./assets/apollo-observability-stack.tpl.md` and `./assets/apollo-observability-stack.checklist.md`.
2. Generate `k8s/observability/monitoring/prometheus-grafana-alertmanager.yaml`:
   - Namespace `monitoring` labeled with `gateway-access: platform`.
   - Prometheus scrape configs for application workload pods and `kube-system` metrics.
   - Alertmanager configuration routing critical and warning alerts to Slack via `slack_api_url_file` secret mount (never plaintext webhook URLs).
   - Grafana deployment and Service ready for `platform-alb-gateway` exposure.
3. Generate `k8s/observability/logging/eck-filebeat-elasticsearch-kibana.yaml`:
   - Namespace `logging` labeled with `gateway-access: platform`.
   - Elasticsearch cluster backed by `gp3` storage class, Filebeat DaemonSet collecting container logs, and Kibana deployment/Service.
4. Generate `k8s/observability/tracing/jaeger-otlp.yaml`:
   - Namespace `tracing` labeled with `gateway-access: platform`.
   - Jaeger deployment and Service exposing OTLP gRPC receiver on `:4317`, OTLP HTTP on `:4318`, and Jaeger UI on `:16686`.
5. Validate all outputs against `./assets/apollo-observability-stack.checklist.md`.

## Validation and Compliance Decision Rules
- Alertmanager Slack webhooks MUST be referenced from a Kubernetes Secret (`slack_api_url_file`), never hardcoded in plaintext ConfigMaps.
- Stateful observability components (Prometheus, Elasticsearch) MUST request `gp3` persistent storage and explicit memory/CPU limits.
- Jaeger MUST expose port `4317` (`otlp-grpc`) so application microservices can export OpenTelemetry spans directly to `jaeger-collector.tracing.svc.cluster.local:4317`.
