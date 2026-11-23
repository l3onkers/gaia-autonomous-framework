apiVersion: chaos-mesh.org/v1alpha1
kind: PodChaos
metadata:
  name: pod-failure-experiment
  namespace: staging
spec:
  action: pod-kill
  mode: one
  duration: "1m"
  selector:
    namespaces:
      - staging
    labelSelectors:
      app: "backend-service"
