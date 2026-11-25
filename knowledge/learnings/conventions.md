# 🎯 Verified Operational Conventions & Guidelines

---

## 1. Multi-Platform Interoperability
- **Root Configuration:** `AGENTS.md` is the single source of truth for repository rules across Antigravity App, Antigravity CLI, Cursor, and Copilot.
- **Skill Discovery:** Reusable skills live in `.github/skills/` and are registered in `.agents/skills.json` to prevent duplicated files.
- **Git Protocol:** Feature branches follow `apollo-git-workflow` (`feat/`, `fix/`, `chore/`). Direct pushes to `main` are blocked.

## 2. Scaffolding & Code Generation
- **Clean Root:** Application code belongs in generated target repositories or dedicated subdirectories; the GAIA framework root must remain pure governance and orchestration.
- **Domain-Agnostic Skills & Documentation:** All governed skills (`.github/skills/*`), templates (`*.tpl.md`), checklists (`*.checklist.md`), and framework documentation in GAIA must remain 100% domain-agnostic (using neutral identifiers such as `app-workloads`, `platform-es`, `api-service`, `app.example.com`) and must never leak project-specific naming from downstream PoCs or target repositories.
- **Frontend Standard:** New frontend scaffolds must default to React; Angular is preserved for existing `eleuthia-ng-*` profiles.

## 3. Resilience & Security
- **Strict Zero Trust:** Secrets must never be logged or echoed in markdown.
- **Destructive Actions:** Teardowns, schema drops, and chaos injections require explicit user approval.

## 4. Cloud Topology & Domain Parameterization (Ingested via `gaia-knowledge-ingest`)
- **Generic Parameterized Domains:** Never hardcode personal or diagram-example domain names as defaults in Terraform, ExternalDNS, ACM, or Gateway API manifests. Always expose a parameterized variable (`domain_name` in Terraform with a generic RFC-2606 default such as `app.example.com` and `${DOMAIN_NAME}` in Kubernetes overlays).
- **EKS Hybrid Identity Pattern:** When provisioning EKS 1.34+ clusters, combine **IRSA** (for `aws-load-balancer-controller` and `cluster-autoscaler`) with **EKS Pod Identity** (for `aws-ebs-csi-driver` with `gp3` storage and `external-dns`).
- **Gateway API Blast-Radius Isolation:** Separate external application traffic (`app-alb-gateway`) from administrative/observability platform traffic (`platform-alb-gateway`) using Kubernetes Gateway API `Gateway` and `HTTPRoute` resources with namespace selector policies.
