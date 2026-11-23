# 🌍 GAIA Repository Agent Guide & Harness Architecture

## 1. Overview & Framework Mission

**G.A.I.A. (Governance through Autonomous Infrastructure Agents)** is an autonomous platform engineering, DevOps, and code scaffolding framework.

The framework operates under two non-negotiable principles:
- **Thin Agents, Thick Skills:** Top-level agents act as routing and governance coordinators. Reusable, deterministic behavior, checklists, and code templates belong exclusively in skills.
- **Zero Trust Governance:** No agent may execute unverified assumptions, fabricate dependencies, or perform destructive operations without explicit verification and confirmation.

This file serves as the canonical root guide discovered by **Antigravity App**, **Antigravity CLI (`agy`)**, **GitHub Copilot**, **Cursor**, **Claude Code**, and **Codex**.

---

## 2. Agent Catalog & Routing Precedence

When a request is received, follow this deterministic lookup order:
1. **Ambiguous or Multi-Domain Requests:** Route through **GAIA Core**. GAIA analyzes intent and delegates sequentially or in parallel to specialized subroutines.
2. **Specific Technical Domain:** Dispatch directly to the owning specialized subroutine according to the matrix below:

| Subroutine | Role & Ecosystem Specialty | Primary Responsibilities | Scope Boundaries |
| :--- | :--- | :--- | :--- |
| **GAIA** | Central Orchestrator | User intent routing, multi-agent dispatch, workflow coordination. | Does not generate application or infra code directly. |
| **HEPHAESTUS** | Forge & CI/CD | GitHub Actions, container packaging, build agent scaffolding. | Does not provision cloud infra (delegates to DEMETER). |
| **MINERVA** | DevSecOps & Security | Vulnerability audits, secret scanning, dependency checking, PR review. | Focuses on Zero Trust validation and remediation advice. |
| **APOLLO** | Knowledge & Observability | Living documentation, ADRs, runbooks, metrics, git workflow. | Owns repository metadata and governance enforcement. |
| **ELEUTHIA** | Application Scaffolding | Bootstrapping services (.NET, Angular, Python FastAPI/workers). | Does not deploy or manage cloud infrastructure. |
| **DEMETER** | IaC & Cloud Provisioning | Terraform base modules (AWS, Azure, on-premises), GitOps sync. | Does not author business application logic. |
| **AETHER** | Networking & Service Mesh | Istio ingress, AWS ALB Ingress, API gateways, routing rules. | Focuses strictly on network perimeter and traffic. |
| **HADES** | Chaos Engineering & Resilience | Chaos Mesh experiments, failure injections, automated rollbacks. | Strictly blocked from unconfirmed production destruction. |
| **POSEIDON** | Data & Storage | Database migrations (Flyway), local PostgreSQL, stateful volumes. | Never drops or wipes production databases. |
| **ARTEMIS** | QA & Automated Testing | k6 load testing, Playwright E2E suites, test pipeline scaffolding. | Does not write business implementation code. |

---

## 3. Skill Resolution & Progressive Disclosure

- Reusable skills reside in `.github/skills/` and are registered in `.agents/skills.json`.
- Each skill contains:
  - `SKILL.md`: Metadata frontmatter (`name`, `description`) and procedure.
  - `assets/`: Governed templates (`*.tpl.md`) and checklists (`*.checklist.md`).
  - `scripts/`: Deterministic validation and generator scripts.
- **Rule of Progressive Disclosure:** Never load all skills into context at once. Inspect the skill catalog, identify the single skill matching the task, and load only its declared assets.

---

## 4. Operational Zero Trust Rules

1. **Production Safety:** Destructive actions (wiping databases, deleting cloud infrastructure, teardown of persistent volumes) are strictly blocked without human confirmation.
2. **Deterministic Outputs:** Do not invent placeholders (e.g. `// TODO: implement later`). Generated scaffolds must be bounded, compilable, and syntactically valid.
3. **Frontend Policy:** Default to React for new frontend capabilities. Angular is maintained for existing governed profiles under `eleuthia-ng-*`.
4. **Git Standards:** All branch creation, commit formatting, and pull requests must follow the guidelines governed by `apollo-git-workflow` (`feat/`, `fix/`, `chore/`, conventional commits). Commits directly to `main` are prohibited.

---

## 5. Multi-Platform Compatibility Matrix

| Platform | Discovery Mechanism | Configuration |
| :--- | :--- | :--- |
| **Antigravity App / CLI** | Discovers `AGENTS.md` and `.agents/skills.json` | Progressively registers all skills and enforces root rules. |
| **GitHub Copilot** | Reads `.github/AGENT.md` and `.github/agents/*.agent.md` | Invocable via `@workspace Use <agent>`. |
| **Cursor / Claude Code** | Discovers root `AGENTS.md` and standard `SKILL.md` | Standard instructions and skill executions. |
