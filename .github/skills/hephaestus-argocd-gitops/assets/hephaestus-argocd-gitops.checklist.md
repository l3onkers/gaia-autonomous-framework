# Monorepo CI Matrix & Argo CD GitOps Compliance Checklist

- [ ] `detect-changes` job calculates modified service directories dynamically and emits a valid JSON array for the build matrix.
- [ ] `Trivy` vulnerability scanner runs on the built image *before* pushing to `GHCR` and fails the build (`exit-code: '1'`) on unfixed `CRITICAL` or `HIGH` vulnerabilities.
- [ ] Workflow permissions declare explicit least-privilege scopes (`contents: read`, `packages: write`, `security-events: write`).
- [ ] Argo CD `AppProject` restricts source repositories and target namespaces (`app-workloads`, `monitoring`, `logging`, `tracing`).
- [ ] Argo CD `Application` includes `argocd-image-updater.argoproj.io/image-list` annotations tracking `ghcr.io` images.
- [ ] Automated sync policy enables both `prune: true` and `selfHeal: true`.
- [ ] No hardcoded personal tokens or placeholder `TODO` comments exist in the generated manifests.
