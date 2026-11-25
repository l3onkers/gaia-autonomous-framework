---
name: hephaestus-argocd-gitops
description: 'Use when: hephaestus resolves a request to scaffold a monorepo CI matrix (detect-changes, Build, Trivy scan, GHCR push) paired with Argo CD and Argo CD Image Updater GitOps deployment manifests.'
user-invocable: true
---

# Monorepo CI Matrix (Trivy + GHCR) & Argo CD Image Updater Skill

## Purpose
- This skill owns the end-to-end Continuous Integration and GitOps Continuous Delivery layer for multi-service Kubernetes platforms.
- This skill generates a GitHub Actions workflow featuring path-based change detection (`detect-changes`), a dynamic build-and-push matrix (`Build` -> `Trivy` vulnerability scan -> `Push` to GitHub Container Registry `GHCR`), and Argo CD declarative GitOps manifests (`AppProject`, `Application`, and `Argo CD Image Updater` annotations).
- This skill stays within CI/CD pipeline authoring and GitOps declarative sync manifests; it does not provision cloud clusters (delegated to `demeter`).

## Output Contract
- `.github/workflows/ci-build-matrix.yml`
- `k8s/argocd/project.yaml`
- `k8s/argocd/application-workloads.yaml`
- `k8s/argocd/application-observability.yaml`

If the target container registry or repository owner is not explicitly provided, parameterize using `${GITHUB_REPOSITORY_OWNER}` and `ghcr.io`.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned template asset: `./assets/hephaestus-argocd-gitops.tpl.md`
- Owned checklist asset: `./assets/hephaestus-argocd-gitops.checklist.md`

## When to Use
- `hephaestus` resolves a request requiring selective monorepo builds (`detect-changes`), container vulnerability gating with `Trivy`, publishing to `GHCR`, and automated pull-based deployment via `Argo CD` and `Argo CD Image Updater`.

## Procedure
1. Load `./assets/hephaestus-argocd-gitops.tpl.md` and `./assets/hephaestus-argocd-gitops.checklist.md`.
2. Generate `.github/workflows/ci-build-matrix.yml` with two jobs:
   - `detect-changes`: determines modified microservice directories and outputs a JSON matrix of affected services.
   - `build-scan-push`: runs across the matrix, builds the multi-stage Docker image, scans it with Aqua Security `Trivy` (`exit-code: '1'` on `CRITICAL,HIGH` unfixed CVEs), and pushes signed/tagged images (`sha-<short>` and `latest`) to `ghcr.io`.
3. Generate `k8s/argocd/project.yaml` restricting allowed source repositories, target namespaces (`app-workloads`, `monitoring`, `logging`, `tracing`, `external-dns`), and cluster resources.
4. Generate `k8s/argocd/application-workloads.yaml` with `argocd-image-updater.argoproj.io` annotations configured to track `ghcr.io` image digests/tags and write back or sync automatically with `prune: true` and `selfHeal: true`.
5. Validate all outputs against `./assets/hephaestus-argocd-gitops.checklist.md`.

## Validation and Compliance Decision Rules
- The CI matrix MUST block image publication to `GHCR` if the `Trivy` step fails on `CRITICAL` severity vulnerabilities.
- GitHub Actions permissions MUST follow least privilege (`contents: read`, `packages: write`, `security-events: write`).
- Argo CD `Application` resources MUST belong to a restricted `AppProject` (never `default` with wildcard cluster privileges in production) and enable automated `selfHeal` and `prune`.
