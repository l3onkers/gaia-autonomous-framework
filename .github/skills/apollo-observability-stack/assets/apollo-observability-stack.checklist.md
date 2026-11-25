# Three-Pillar Kubernetes Observability Stack Compliance Checklist

- [ ] `monitoring`, `logging`, and `tracing` namespaces are isolated and labeled with `gateway-access: platform` for Gateway API exposure.
- [ ] Alertmanager Slack integration reads the webhook URL from a mounted Secret file (`api_url_file`), never plaintext credentials.
- [ ] Elasticsearch persistent volume claims specify the `gp3` storage class (`storageClassName: gp3`).
- [ ] Filebeat DaemonSet ships container logs directly to the `platform-es` Elasticsearch service in the `logging` namespace.
- [ ] Jaeger enables OTLP receiver (`COLLECTOR_OTLP_ENABLED=true`) and exposes gRPC port `4317` (`jaeger-collector.tracing.svc.cluster.local:4317`).
- [ ] All observability workloads declare explicit CPU/memory requests and limits and non-root security contexts where supported.
