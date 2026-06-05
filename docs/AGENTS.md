# 🤖 GAIA Agents Ecosystem

This document details the artificial intelligences (sub-routines) that make up the GAIA ecosystem. Each agent acts as an orchestrator that reads the user's intent and routes it to the appropriate *skills* (scripts and templates), following a **Zero Trust** and regulatory compliance principle.

## Sub-routine Hierarchy

### 🌍 GAIA (Core Router)
The central brain of the ecosystem. Its sole purpose is to analyze ambiguous user requests, determine the context, and route the work to the corresponding specialized sub-routine.
- **Path:** .github/agents/gaia.agent.md
- **Usage:** @workspace Use gaia to...

### 🔨 HEPHAESTUS (Forge & CI/CD)
Responsible for building containers, forging continuous integration and deployment pipelines, and maintaining the framework itself (internal tooling governance).
- **Path:** .github/agents/hephaestus.agent.md
- **Usage:** @workspace Use hephaestus to generate the GitHub Actions pipeline...

### 🛡️ MINERVA (Security & DevSecOps)
The tactical guardian. Audits code for vulnerabilities, scans for leaked secrets in commits, enforces remediation policies, and manages security on Pull Requests.
- **Path:** .github/agents/minerva.agent.md
- **Usage:** @workspace Use minerva to review the security of this PR.

### 📚 APOLLO (Knowledge & Observability)
The archivist. Ensures technical documentation (READMEs, Runbooks, ADRs) never becomes obsolete. It also performs semantic audits (compliance reviews) to ensure other agents follow the rules.
- **Path:** .github/agents/apollo.agent.md
- **Usage:** @workspace Use apollo to generate a Runbook for this API.

### 🧬 ELEUTHIA (Scaffolding & Code)
The life creator. The only agent authorized to build the base structure of new applications (.NET, Angular, Python) from scratch, injecting architectural conventions and internal libraries.
- **Path:** .github/agents/eleuthia.agent.md
- **Usage:** @workspace Use eleuthia to start an Angular project.

### 🌱 DEMETER (Infrastructure as Code)
The earth shaper. Provisions servers, Kubernetes clusters, and Cloud resources using Terraform, Pulumi, or Crossplane. Maintains the desired state via GitOps.
- **Path:** .github/agents/demeter.agent.md
- **Usage:** @workspace Use demeter to create an S3 bucket via Terraform.

### 🌪️ AETHER (Networking & Routing)
Controls the winds and routes. Configures Ingress, Service Meshes (Istio), API Gateways, DNS, and load balancers.
- **Path:** .github/agents/aether.agent.md
- **Usage:** @workspace Use aether to configure the Ingress for this service.

### 🌊 POSEIDON (Data & Storage)
Sovereign of the data seas. Manages databases, schema migrations (Flyway/Liquibase), caches (Redis), and handles backups and at-rest encryption.
- **Path:** .github/agents/poseidon.agent.md
- **Usage:** @workspace Use poseidon to add a SQL migration script.

### 💀 HADES (Chaos & Teardown)
Destroyer of worlds. Responsible for tearing down ephemeral environments, executing rollbacks in production, and running chaos engineering experiments to ensure resilience.
- **Path:** .github/agents/hades.agent.md
- **Usage:** @workspace Use hades to destroy the staging environment.

### 🏹 ARTEMIS (QA & E2E Testing)
The bug hunter. Executes functional end-to-end tests, load tests (k6), and validates application health after deployments.
- **Path:** .github/agents/artemis.agent.md
- **Usage:** @workspace Use artemis to prepare a k6 load test.
"@

 = @"
# 🏛️ GAIA Ecosystem Architecture

The framework adopts a hierarchical, **Event-Driven** approach. Instead of a large monolithic prompt, we divide responsibilities into hyper-specialized sub-routines that collaborate via *skills*.

## The Lifecycle of a Request

1. **User Intent:** The developer interacts with GitHub Copilot Chat.
2. **Routing (GAIA):** If no agent is specified, GAIA analyzes the request and routes it.
3. **Sub-routine:** The selected agent (e.g., ELEUTHIA) reads its *.agent.md, where its Zero Trust rules and operational limits are defined.
4. **Skills and Assets:** The agent locates the relevant *skills* in .github/skills/, reads the necessary templates and checklists, and generates the response.
5. **Compliance Review (Optional):** The user can invoke APOLLO to verify that the generated code complies with governance.

## Key Components

- **Agents (.github/agents/)**: These are the roles or personalities. They don't do direct work; they coordinate.
- **Skills (.github/skills/)**: These are packaged "functions" (e.g., eleuthia-net-api). They contain the templates and step-by-step guides.
- **Governance (.github/governance/)**: Master contracts, global style guides, and security policies (used by MINERVA and APOLLO).

## Zero Trust Pattern in Prompts

Each agent has a **Zero Trust Rules** section. This forces Copilot to stop generation if the user asks for something dangerous (e.g., "Delete the Production database" will be blocked by HADES or POSEIDON).
