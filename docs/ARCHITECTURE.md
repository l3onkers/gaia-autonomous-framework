# 🏛️ GAIA Ecosystem Architecture

The framework adopts a hierarchical, **Event-Driven** approach. Instead of a large monolithic prompt, we divide responsibilities into hyper-specialized sub-routines that collaborate via *skills*.

## The Lifecycle of a Request

1. **User Intent:** The developer interacts with GitHub Copilot Chat.
2. **Routing (GAIA):** If no agent is specified, GAIA analyzes the request and routes it.
3. **Sub-routine:** The selected agent (e.g., ELEUTHIA) reads its `*.agent.md`, where its Zero Trust rules and operational limits are defined.
4. **Skills and Assets:** The agent locates the relevant *skills* in `.github/skills/`, reads the necessary templates and checklists, and generates the response.
5. **Compliance Review (Optional):** The user can invoke APOLLO to verify that the generated code complies with governance.

## Key Components

- **Agents (`.github/agents/`)**: These are the roles or personalities. They don't do direct work; they coordinate.
- **Skills (`.github/skills/`)**: These are packaged "functions" (e.g., `eleuthia-net-api`). They contain the templates and step-by-step guides.
- **Governance (`.github/governance/`)**: Master contracts, global style guides, and security policies (used by MINERVA and APOLLO).

## Zero Trust Pattern in Prompts

Each agent has a **Zero Trust Rules** section. This forces Copilot to stop generation if the user asks for something dangerous (e.g., "Delete the Production database" will be blocked by HADES or POSEIDON).
