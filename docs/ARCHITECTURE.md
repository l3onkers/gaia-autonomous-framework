# 🏛️ GAIA Ecosystem Architecture

The framework adopts a hierarchical, **Event-Driven** approach. Instead of a large monolithic prompt, we divide responsibilities into hyper-specialized sub-routines that collaborate via governed skills.

## Architectural Principles

- **Thin agents, thick skills:** Agents route and validate; skills own generation logic, templates, and checklists.
- **Deterministic selection:** If multiple paths are possible, the agent must resolve the target using explicit evidence and documented precedence.
- **Zero Trust governance:** Requests outside scope stop early rather than guessing.
- **Repository-first UX:** The repo documentation must explain how to use the framework without external video, slides, or hidden context.

## The Lifecycle of a Request

1. **User Intent:** The developer interacts with GitHub Copilot Chat.
2. **Routing (GAIA):** If no agent is specified, GAIA analyzes the request and routes it.
3. **Sub-routine:** The selected agent (e.g., ELEUTHIA) reads its `*.agent.md`, where its Zero Trust rules and operational limits are defined.
4. **Skills and Assets:** The agent locates the relevant *skills* in `.github/skills/`, reads the necessary templates and checklists, and generates the response.
5. **Compliance Review (Optional):** The user can invoke APOLLO to verify that the generated code complies with governance.

## Authoring Model

The public-facing contract for new or updated agents is the 7-section structure defined in [docs/CREATING_AGENTS.md](CREATING_AGENTS.md). That contract keeps the entrypoints readable while moving detailed logic into companion assets and skills.

New or updated frontend skills should default to React first. Angular remains supported when the governed stack explicitly depends on it, but it should not be the default choice for new frontends.

## Key Components

- **Agents (`.github/agents/`)**: These are the roles or personalities. They don't do direct work; they coordinate.
- **Skills (`.github/skills/`)**: These are packaged "functions" (e.g., `eleuthia-net-api`). They contain the templates and step-by-step guides.
- **Governance (`.github/governance/`)**: Master contracts, global style guides, and security policies (used by MINERVA and APOLLO).

## Validation and CI/CD

The repository should validate its own governance shape separately from product pipelines.

- Structural validation belongs in a dedicated workflow.
- The workflow should verify required docs, agent entrypoints, skill manifests, and companion assets.
- Product pipelines can consume the result, but they should not own repository-governance checks.

## Zero Trust Pattern in Prompts

Each agent has a **Zero Trust Rules** section. This forces Copilot to stop generation if the user asks for something dangerous (e.g., "Delete the Production database" will be blocked by HADES or POSEIDON).
