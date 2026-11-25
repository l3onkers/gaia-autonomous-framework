# Monorepo Matrix CI (Trivy + GHCR) & Argo CD GitOps Template

```yaml
# .github/workflows/ci-build-matrix.yml
name: CI Matrix — Detect Changes, Build, Trivy & Push to GHCR

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

permissions:
  contents: read
  packages: write
  security-events: write

jobs:
  detect-changes:
    name: Detect Modified Microservices
    runs-on: ubuntu-latest
    outputs:
      matrix: ${{ steps.set-matrix.outputs.matrix }}
      has_changes: ${{ steps.set-matrix.outputs.has_changes }}
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 2

      - name: Compute affected services
        id: set-matrix
        run: |
          SERVICES=("frontend" "api-service" "worker-service")
          CHANGED=()
          for svc in "${SERVICES[@]}"; do
            if git diff --name-only HEAD~1 HEAD | grep -q "^services/${svc}/"; then
              CHANGED+=("\"${svc}\"")
            fi
          done
          if [ ${#CHANGED[@]} -eq 0 ]; then
            CHANGED=("\"frontend\"" "\"api-service\"" "\"worker-service\"")
          fi
          JSON_ARRAY="[$(IFS=,; echo "${CHANGED[*]}")]"
          echo "matrix=${JSON_ARRAY}" >> "$GITHUB_OUTPUT"
          echo "has_changes=true" >> "$GITHUB_OUTPUT"

  build-trivy-push:
    name: Build, Scan & Push (${{ matrix.service }})
    needs: detect-changes
    if: needs.detect-changes.outputs.has_changes == 'true'
    runs-on: ubuntu-latest
    strategy:
      fail-fast: false
      matrix:
        service: ${{ fromJson(needs.detect-changes.outputs.matrix) }}
    steps:
      - uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to GitHub Container Registry (GHCR)
        if: github.event_name != 'pull_request'
        uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Build container image
        uses: docker/build-push-action@v5
        with:
          context: ./services/${{ matrix.service }}
          load: true
          tags: |
            ghcr.io/${{ github.repository_owner }}/platform-${{ matrix.service }}:sha-${{ github.sha }}
            ghcr.io/${{ github.repository_owner }}/platform-${{ matrix.service }}:latest

      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@v0.35.0
        with:
          image-ref: ghcr.io/${{ github.repository_owner }}/platform-${{ matrix.service }}:sha-${{ github.sha }}
          format: table
          exit-code: '1'
          ignore-unfixed: true
          vuln-type: os,library
          severity: CRITICAL,HIGH

      - name: Push verified image to GHCR
        if: github.event_name != 'pull_request'
        uses: docker/build-push-action@v5
        with:
          context: ./services/${{ matrix.service }}
          push: true
          tags: |
            ghcr.io/${{ github.repository_owner }}/platform-${{ matrix.service }}:sha-${{ github.sha }}
            ghcr.io/${{ github.repository_owner }}/platform-${{ matrix.service }}:latest
---
# k8s/argocd/application-workloads.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: platform-app-workloads
  namespace: argocd
  annotations:
    argocd-image-updater.argoproj.io/image-list: >-
      frontend=ghcr.io/${GITHUB_OWNER}/platform-frontend,
      api-service=ghcr.io/${GITHUB_OWNER}/platform-api-service,
      worker-service=ghcr.io/${GITHUB_OWNER}/platform-worker-service
    argocd-image-updater.argoproj.io/write-back-method: argocd
spec:
  project: platform-workloads-project
  source:
    repoURL: https://github.com/${GITHUB_OWNER}/${REPOSITORY_NAME}.git
    targetRevision: main
    path: k8s/app-workloads
  destination:
    server: https://kubernetes.default.svc
    namespace: app-workloads
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
```
